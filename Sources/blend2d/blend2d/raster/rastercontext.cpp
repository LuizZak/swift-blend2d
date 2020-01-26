// [Blend2D]
// 2D Vector Graphics Powered by a JIT Compiler.
//
// [License]
// Zlib - See LICENSE.md file in the package.

#include "../api-build_p.h"
#include "../compop_p.h"
#include "../font_p.h"
#include "../format_p.h"
#include "../geometry_p.h"
#include "../image_p.h"
#include "../path_p.h"
#include "../pathstroke_p.h"
#include "../piperuntime_p.h"
#include "../pixelops_p.h"
#include "../runtime_p.h"
#include "../support_p.h"
#include "../zeroallocator_p.h"
#include "../raster/edgebuilder_p.h"
#include "../raster/rastercontext_p.h"
#include "../raster/rasterfiller_p.h"

#ifndef BL_BUILD_NO_FIXED_PIPE
  #include "../fixedpipe/blfixedpiperuntime_p.h"
#endif

#ifndef BL_BUILD_NO_JIT
  #include "../pipegen/pipegenruntime_p.h"
#endif

// ============================================================================
// [BLRasterContext - Globals]
// ============================================================================

static BLContextVirt blRasterContextVirt;

static const uint32_t blRasterContextSolidDataRgba32[] = {
  0x00000000u, // BL_COMP_OP_SOLID_ID_NONE (not solid, not used).
  0x00000000u, // BL_COMP_OP_SOLID_ID_TRANSPARENT.
  0xFF000000u, // BL_COMP_OP_SOLID_ID_OPAQUE_BLACK.
  0xFFFFFFFFu  // BL_COMP_OP_SOLID_ID_OPAQUE_WHITE.
};

// ============================================================================
// [BLRasterContext - FetchData]
// ============================================================================

// These must be forward declarated as they are used early.
static void BL_CDECL blRasterFetchDataDestroyNop(BLRasterContextImpl* ctxI, BLRasterFetchData* fetchData) noexcept;
static void BL_CDECL blRasterFetchDataDestroyPattern(BLRasterContextImpl* ctxI, BLRasterFetchData* fetchData) noexcept;
static void BL_CDECL blRasterFetchDataDestroyGradient(BLRasterContextImpl* ctxI, BLRasterFetchData* fetchData) noexcept;

// A sentinel used to mark `BLRasterFetchData` to be solid. If used the
// `BLRasterFetchData` can never be dereferenced as it's not supposed to be.
//
// The value of the sentinel was chosen to allow `nullptr` fetch-data in cases
// when the fetch-data is not solid, but wasn't created for the source yet.
static BL_INLINE BLRasterFetchData* blFetchDataSolidSentinel() noexcept {
  return (BLRasterFetchData*)uintptr_t(0x1);
}

// Returns true if the given `fetchData` is already created and thus valid.
// If the `fetchData` is a solid-fetch sentinel then the answer would always
// be false.
static BL_INLINE bool blFetchDataIsCreated(BLRasterFetchData* fetchData) noexcept {
  // False if `fetchData` is nullptr or solid-fetch sentinel.
  return (uintptr_t)fetchData > (uintptr_t)blFetchDataSolidSentinel();
}

// Initializes `fetchData` pattern source (i.e. image data). Called implicitly
// by all pattern initializers so you don't have to call it explicitly.
static BL_INLINE void blRasterFetchDataInitPatternSource(BLRasterFetchData* fetchData, const BLImageImpl* imgI, const BLRectI& area) noexcept {
  BL_ASSERT(area.x >= 0);
  BL_ASSERT(area.y >= 0);
  BL_ASSERT(area.w > 0);
  BL_ASSERT(area.h > 0);

  const uint8_t* srcPixelData = static_cast<const uint8_t*>(imgI->pixelData);
  intptr_t srcStride = imgI->stride;
  uint32_t srcBytesPerPixel = blFormatInfo[imgI->format].depth / 8u;

  fetchData->data.initPatternSource(srcPixelData + uint32_t(area.y) * srcStride + uint32_t(area.x) * srcBytesPerPixel, imgI->stride, area.w, area.h);
}

// Initializes `fetchData` for a blit. Blits are never repeating and are
// always 1:1 (no scaling, only pixel translation is possible).
static BL_INLINE void blRasterFetchDataInitPatternBlit(BLRasterFetchData* fetchData, const BLImageImpl* imgI, const BLRectI& area) noexcept {
  blRasterFetchDataInitPatternSource(fetchData, imgI, area);

  uint32_t fetchType = fetchData->data.initPatternBlit();
  fetchData->fetchType = uint8_t(fetchType);
  fetchData->fetchFormat = uint8_t(imgI->format);
}

static BL_INLINE void blRasterFetchDataInitPatternFxFy(BLRasterFetchData* fetchData, const BLImageImpl* imgI, const BLRectI& area, uint32_t extendMode, uint32_t quality, int64_t txFixed, int64_t tyFixed) noexcept {
  blRasterFetchDataInitPatternSource(fetchData, imgI, area);

  uint32_t fetchType = fetchData->data.initPatternFxFy(extendMode, quality, imgI->depth / 8, txFixed, tyFixed);
  fetchData->fetchType = uint8_t(fetchType);
  fetchData->fetchFormat = uint8_t(imgI->format);
}

static BL_INLINE bool blRasterFetchDataInitPatternAffine(BLRasterFetchData* fetchData, const BLImageImpl* imgI, const BLRectI& area, uint32_t extendMode, uint32_t quality, const BLMatrix2D& m) noexcept {
  blRasterFetchDataInitPatternSource(fetchData, imgI, area);

  uint32_t fetchType = fetchData->data.initPatternAffine(extendMode, quality, imgI->depth / 8, m);
  fetchData->fetchType = uint8_t(fetchType);
  fetchData->fetchFormat = uint8_t(imgI->format);
  return fetchType != BL_PIPE_FETCH_TYPE_FAILURE;
}

static BL_INLINE bool blRasterFetchDataInitGradient(BLRasterFetchData* fetchData, const BLGradientImpl* gradientI, const BLGradientLUT* lut, const BLMatrix2D& m, uint32_t format) noexcept {
  uint32_t fetchType = fetchData->data.initGradient(gradientI->gradientType, gradientI->values, gradientI->extendMode, lut, m);
  fetchData->fetchType = uint8_t(fetchType);
  fetchData->fetchFormat = uint8_t(format);
  return fetchType != BL_PIPE_FETCH_TYPE_FAILURE;
}

// Create a new `BLRasterFetchData` from a `style`.
//
// Returns a `BLRasterFetchData` instance with reference count set to 1.
static BLRasterFetchData* blRasterContextImplCreateFetchData(BLRasterContextImpl* ctxI, BLRasterContextStyleData* style) noexcept {
  BLRasterFetchData* fetchData = ctxI->fetchPool.alloc();
  if (BL_UNLIKELY(!fetchData))
    return nullptr;

  BLVariantImpl* styleI = style->variant->impl;
  const BLMatrix2D& m = style->adjustedMatrix;

  switch (styleI->implType) {
    case BL_IMPL_TYPE_GRADIENT: {
      BLGradientImpl* gradientI = style->gradient->impl;
      BLGradientLUT* lut = blGradientImplEnsureLut32(gradientI);

      if (BL_UNLIKELY(!lut))
        break;

      if (!blRasterFetchDataInitGradient(fetchData, gradientI, lut, m, style->styleFormat))
        break;

      fetchData->refCount = 1;
      fetchData->destroy = blRasterFetchDataDestroyGradient;
      fetchData->gradientLut = lut->incRef();
      return fetchData;
    }

    case BL_IMPL_TYPE_PATTERN: {
      BLPatternImpl* patternI = style->pattern->impl;
      BLImageImpl* imgI = patternI->image.impl;

      // Zero area means to cover the whole image.
      BLRectI area = patternI->area;
      if (!blIsValid(area))
        area.reset(0, 0, imgI->size.w, imgI->size.h);

      if (BL_UNLIKELY(!area.w))
        break;

      if (!blRasterFetchDataInitPatternAffine(fetchData, imgI, area, patternI->extendMode, style->quality, m))
        break;

      fetchData->refCount = 1;
      fetchData->destroy = blRasterFetchDataDestroyPattern;
      fetchData->imageI = blImplIncRef(imgI);
      return fetchData;
    }

    default:
      break;
  }

  ctxI->fetchPool.free(fetchData);
  return nullptr;
}

static void BL_CDECL blRasterFetchDataDestroyNop(BLRasterContextImpl* ctxI, BLRasterFetchData* fetchData) noexcept {
  ctxI->fetchPool.free(fetchData);
}

static void BL_CDECL blRasterFetchDataDestroyPattern(BLRasterContextImpl* ctxI, BLRasterFetchData* fetchData) noexcept {
  BLImageImpl* imgI = fetchData->imageI;
  if (blImplDecRefAndTest(imgI))
    blImageImplDelete(imgI);
  ctxI->fetchPool.free(fetchData);
}

static void BL_CDECL blRasterFetchDataDestroyGradient(BLRasterContextImpl* ctxI, BLRasterFetchData* fetchData) noexcept {
  BLGradientLUT* lut = fetchData->gradientLut;
  lut->release();
  ctxI->fetchPool.free(fetchData);
}

static BL_INLINE void blRasterContextImplReleaseFetchData(BLRasterContextImpl* ctxI, BLRasterFetchData* fetchData) noexcept {
  if (--fetchData->refCount == 0)
    fetchData->destroy(ctxI, fetchData);
}

// ============================================================================
// [BLRasterContext - Pipeline Lookup]
// ============================================================================

static BL_INLINE BLPipeFillFunc blRasterContextImplGetFillFunc(BLRasterContextImpl* ctxI, uint32_t signature) noexcept {
  BLPipeLookupCache::MatchType m = ctxI->pipeLookupCache.match(signature);
  return m.isValid() ? ctxI->pipeLookupCache.getMatch<BLPipeFillFunc>(m)
                     : ctxI->pipeProvider.get(signature, &ctxI->pipeLookupCache);
}

// ============================================================================
// [BLRasterContext - Core State Internals]
// ============================================================================

static BL_INLINE void blRasterContextImplBeforeConfigChange(BLRasterContextImpl* ctxI) noexcept {
  if (ctxI->contextFlags & BL_RASTER_CONTEXT_STATE_CONFIG) {
    BLRasterContextSavedState* state = ctxI->savedState;
    state->approximationOptions = ctxI->currentState.approximationOptions;
  }
}

static BL_INLINE void blRasterContextImplCompOpChanged(BLRasterContextImpl* ctxI) noexcept {
  ctxI->compOpSimplifyTable = blCompOpSimplifyInfoArrayOf(ctxI->currentState.compOp, ctxI->dstInfo.format);
}

static BL_INLINE void blRasterContextImplFlattenToleranceChanged(BLRasterContextImpl* ctxI) noexcept {
  ctxI->toleranceFixedD = ctxI->currentState.approximationOptions.flattenTolerance * ctxI->fpScaleD;
  ctxI->workerCtx.edgeBuilder.setFlattenToleranceSq(blSquare(ctxI->toleranceFixedD));
}

static BL_INLINE void blRasterContextImplOffsetParameterChanged(BLRasterContextImpl* ctxI) noexcept {
  BL_UNUSED(ctxI);
}

// ============================================================================
// [BLRasterContext - Style State Internals]
// ============================================================================

static BL_INLINE void blRasterContextInitStyleToDefault(BLRasterContextStyleData& style, uint32_t alphaI) noexcept {
  style.packed = 0;
  style.styleType = BL_STYLE_TYPE_SOLID;
  style.styleFormat = BL_FORMAT_FRGB32;
  style.alphaI = alphaI;
  style.solidData.prgb32 = 0xFF000000u;
  style.fetchData = blFetchDataSolidSentinel();

  style.rgba64.value = 0xFFFF000000000000u;
  style.adjustedMatrix.reset();
}

static BL_INLINE void blRasterContextImplDestroyValidStyle(BLRasterContextImpl* ctxI, BLRasterContextStyleData* style) noexcept {
  BLRasterFetchData* fetchData = style->fetchData;
  if (blFetchDataIsCreated(fetchData))
    blRasterContextImplReleaseFetchData(ctxI, fetchData);
  blVariantImplRelease(style->variant->impl);
}

static BL_INLINE void blRasterContextBeforeStyleChange(BLRasterContextImpl* ctxI, uint32_t opType, BLRasterContextStyleData* style) noexcept {
  uint32_t contextFlags = ctxI->contextFlags;
  BLRasterFetchData* fetchData = style->fetchData;

  if ((contextFlags & (BL_RASTER_CONTEXT_BASE_FETCH_DATA << opType)) != 0) {
    if ((contextFlags & (BL_RASTER_CONTEXT_STATE_BASE_STYLE << opType)) == 0) {
      if (blFetchDataIsCreated(fetchData))
        blRasterContextImplReleaseFetchData(ctxI, fetchData);

      blVariantImplRelease(style->variant->impl);
      return;
    }
  }
  else {
    BL_ASSERT((contextFlags & (BL_RASTER_CONTEXT_STATE_BASE_STYLE << opType)) != 0);
  }

  BL_ASSERT(ctxI->savedState != nullptr);
  BLRasterContextStyleData* stateStyle = &ctxI->savedState->style[opType];

  // The content is moved to the `stateStyle`, so it doesn't matter if it
  // contains solid, gradient, or pattern as the state uses the same layout.
  stateStyle->packed = style->packed;
  // `stateStyle->alpha` has been already set by `BLRasterContextImpl::save()`.
  stateStyle->solidData.prgb64 = style->solidData.prgb64;
  stateStyle->fetchData = fetchData;

  stateStyle->rgba64 = style->rgba64;
  stateStyle->adjustedMatrix.reset();
}

template<uint32_t OpType>
static BLResult BL_CDECL blRasterContextImplGetStyle(const BLContextImpl* baseImpl, void* object) noexcept {
  const BLRasterContextImpl* ctxI = static_cast<const BLRasterContextImpl*>(baseImpl);
  const BLRasterContextStyleData* style = &ctxI->style[OpType];

  if (style->styleType <= BL_STYLE_TYPE_SOLID)
    return blTraceError(BL_ERROR_INVALID_STATE);

  BLVariantImpl* styleI = style->variant->impl;
  BLVariantImpl* objectI = static_cast<BLVariant*>(object)->impl;

  if (styleI->implType != objectI->implType)
    return blTraceError(BL_ERROR_INVALID_STATE);

  return blVariantAssignWeak(object, &style->variant);
}

template<uint32_t OpType>
static BLResult BL_CDECL blRasterContextImplGetStyleRgba32(const BLContextImpl* baseImpl, uint32_t* rgba32) noexcept {
  const BLRasterContextImpl* ctxI = static_cast<const BLRasterContextImpl*>(baseImpl);
  const BLRasterContextStyleData* style = &ctxI->style[OpType];

  if (style->styleType != BL_STYLE_TYPE_SOLID)
    return blTraceError(BL_ERROR_INVALID_STATE);

  *rgba32 = blRgba32FromRgba64(style->rgba64.value);
  return BL_SUCCESS;
}

template<uint32_t OpType>
static BLResult BL_CDECL blRasterContextImplGetStyleRgba64(const BLContextImpl* baseImpl, uint64_t* rgba64) noexcept {
  const BLRasterContextImpl* ctxI = static_cast<const BLRasterContextImpl*>(baseImpl);
  const BLRasterContextStyleData* style = &ctxI->style[OpType];

  if (style->styleType != BL_STYLE_TYPE_SOLID)
    return blTraceError(BL_ERROR_INVALID_STATE);

  *rgba64 = style->rgba64.value;
  return BL_SUCCESS;
}

template<uint32_t OpType>
static BLResult BL_CDECL blRasterContextImplSetStyle(BLContextImpl* baseImpl, const void* object) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLRasterContextStyleData* style = &ctxI->style[OpType];

  uint32_t contextFlags = ctxI->contextFlags;
  uint32_t styleFlags = (BL_RASTER_CONTEXT_BASE_FETCH_DATA | BL_RASTER_CONTEXT_STATE_BASE_STYLE) << OpType;

  BLVariantImpl* varI = static_cast<const BLVariant*>(object)->impl;
  const BLMatrix2D* srcMatrix = nullptr;
  uint32_t srcMatrixType = BL_MATRIX2D_TYPE_IDENTITY;

  switch (varI->implType) {
    case BL_IMPL_TYPE_GRADIENT: {
      if (contextFlags & styleFlags)
        blRasterContextBeforeStyleChange(ctxI, OpType, style);

      contextFlags &= ~(styleFlags | (BL_RASTER_CONTEXT_NO_BASE_STYLE << OpType));
      styleFlags = BL_RASTER_CONTEXT_BASE_FETCH_DATA;

      style->packed = 0;
      style->fetchData = nullptr;

      BLGradientImpl* gradientI = reinterpret_cast<BLGradientImpl*>(varI);
      BLGradientInfo gradientInfo = blGradientImplEnsureInfo32(gradientI);

      if (gradientInfo.empty()) {
        styleFlags |= BL_RASTER_CONTEXT_NO_BASE_STYLE;
      }
      else if (gradientInfo.solid) {
        // Use last color according to SVG spec.
        uint32_t rgba32 = BLPixelOps::prgb32_8888_from_argb32_8888(blRgba32FromRgba64(gradientI->stops[gradientI->size - 1].rgba.value));
        style->solidData.prgb32 = rgba32;
        style->fetchData = blFetchDataSolidSentinel();
      }

      srcMatrix = &gradientI->matrix;
      srcMatrixType = gradientI->matrixType;

      ctxI->currentState.styleType[OpType] = uint8_t(BL_STYLE_TYPE_GRADIENT);
      style->styleType = uint8_t(BL_STYLE_TYPE_GRADIENT);
      style->styleFormat = gradientInfo.format;
      style->quality = ctxI->currentState.hints.gradientQuality;
      break;
    }

    case BL_IMPL_TYPE_PATTERN: {
      if (contextFlags & styleFlags)
        blRasterContextBeforeStyleChange(ctxI, OpType, style);

      contextFlags &= ~(styleFlags | (BL_RASTER_CONTEXT_NO_BASE_STYLE << OpType));
      styleFlags = BL_RASTER_CONTEXT_BASE_FETCH_DATA;

      style->packed = 0;
      style->fetchData = nullptr;

      BLPatternImpl* patternI = reinterpret_cast<BLPatternImpl*>(varI);
      if (BL_UNLIKELY(patternI->image.empty()))
        styleFlags |= BL_RASTER_CONTEXT_NO_BASE_STYLE;

      srcMatrix = &patternI->matrix;
      srcMatrixType = patternI->matrixType;

      ctxI->currentState.styleType[OpType] = uint8_t(BL_STYLE_TYPE_PATTERN);
      style->styleType = uint8_t(BL_STYLE_TYPE_PATTERN);
      style->styleFormat = uint8_t(patternI->image.format());
      style->quality = ctxI->currentState.hints.patternQuality;
      break;
    }

    default: {
      return blTraceError(BL_ERROR_INVALID_VALUE);
    }
  }

  uint32_t adjustedMatrixType;
  if (srcMatrixType == BL_MATRIX2D_TYPE_IDENTITY) {
    style->adjustedMatrix = ctxI->finalMatrix;
    adjustedMatrixType = ctxI->finalMatrixType;
  }
  else {
    blMatrix2DMultiply(style->adjustedMatrix, *srcMatrix, ctxI->finalMatrix);
    adjustedMatrixType = style->adjustedMatrix.type();
  }

  if (BL_UNLIKELY(adjustedMatrixType >= BL_MATRIX2D_TYPE_INVALID))
    styleFlags |= BL_RASTER_CONTEXT_NO_BASE_STYLE;

  ctxI->contextFlags = contextFlags | (styleFlags << OpType);
  style->adjustedMatrixType = uint8_t(adjustedMatrixType);
  style->variant->impl = blImplIncRef(varI);

  return BL_SUCCESS;
}

template<uint32_t OpType>
static BLResult BL_CDECL blRasterContextImplSetStyleRgba32(BLContextImpl* baseImpl, uint32_t rgba32) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLRasterContextStyleData* style = &ctxI->style[OpType];

  uint32_t contextFlags = ctxI->contextFlags;
  uint32_t styleFlags = (BL_RASTER_CONTEXT_STATE_BASE_STYLE | BL_RASTER_CONTEXT_BASE_FETCH_DATA) << OpType;

  if (contextFlags & styleFlags)
    blRasterContextBeforeStyleChange(ctxI, OpType, style);

  style->rgba64.value = blRgba64FromRgba32(rgba32);
  uint32_t solidFormatIndex = BL_RASTER_CONTEXT_SOLID_FORMAT_FRGB;

  if (!blRgba32IsFullyOpaque(rgba32)) {
    rgba32 = BLPixelOps::prgb32_8888_from_argb32_8888(rgba32);
    solidFormatIndex = rgba32 == 0 ? BL_RASTER_CONTEXT_SOLID_FORMAT_ZERO
                                   : BL_RASTER_CONTEXT_SOLID_FORMAT_ARGB;
  }

  ctxI->contextFlags = contextFlags & ~(styleFlags | (BL_RASTER_CONTEXT_NO_BASE_STYLE << OpType));
  ctxI->currentState.styleType[OpType] = uint8_t(BL_STYLE_TYPE_SOLID);

  style->styleType = uint8_t(BL_STYLE_TYPE_SOLID);
  style->styleFormat = ctxI->solidFormatTable[solidFormatIndex];
  style->solidData.prgb32 = rgba32;
  style->fetchData = blFetchDataSolidSentinel();

  return BL_SUCCESS;
}

template<uint32_t OpType>
static BLResult BL_CDECL blRasterContextImplSetStyleRgba64(BLContextImpl* baseImpl, uint64_t rgba64) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLRasterContextStyleData* style = &ctxI->style[OpType];

  uint32_t contextFlags = ctxI->contextFlags;
  uint32_t styleFlags = (BL_RASTER_CONTEXT_STATE_BASE_STYLE | BL_RASTER_CONTEXT_BASE_FETCH_DATA) << OpType;

  if (contextFlags & styleFlags)
    blRasterContextBeforeStyleChange(ctxI, OpType, style);

  style->rgba64.value = rgba64;
  uint32_t rgba32 = blRgba32FromRgba64(rgba64);
  uint32_t solidFormatIndex = BL_RASTER_CONTEXT_SOLID_FORMAT_FRGB;

  if (!blRgba32IsFullyOpaque(rgba32)) {
    rgba32 = BLPixelOps::prgb32_8888_from_argb32_8888(rgba32);
    solidFormatIndex = rgba32 == 0 ? BL_RASTER_CONTEXT_SOLID_FORMAT_ZERO
                                   : BL_RASTER_CONTEXT_SOLID_FORMAT_ARGB;
  }

  ctxI->contextFlags = contextFlags & ~(styleFlags | (BL_RASTER_CONTEXT_NO_BASE_STYLE << OpType));
  ctxI->currentState.styleType[OpType] = uint8_t(BL_STYLE_TYPE_SOLID);

  style->styleType = uint8_t(BL_STYLE_TYPE_SOLID);
  style->styleFormat = ctxI->solidFormatTable[solidFormatIndex];
  style->solidData.prgb32 = rgba32;
  style->fetchData = blFetchDataSolidSentinel();

  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Stroke State Internals]
// ============================================================================

static BL_INLINE void blRasterContextImplBeforeStrokeChange(BLRasterContextImpl* ctxI) noexcept {
  if (ctxI->contextFlags & BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS) {
    BLRasterContextSavedState* state = ctxI->savedState;
    memcpy(&state->strokeOptions, &ctxI->currentState.strokeOptions, sizeof(BLStrokeOptionsCore));
    blImplIncRef(state->strokeOptions.dashArray.impl);
  }
}

// ============================================================================
// [BLRasterContext - Matrix State Internals]
// ============================================================================

// Called before `userMatrix` is changed.
//
// This function is responsible for saving the current userMatrix in
// case that the `BL_RASTER_CONTEXT_STATE_USER_MATRIX` flag is set, which means
// that userMatrix must be saved before any modification.
static BL_INLINE void blRasterContextImplBeforeUserMatrixChange(BLRasterContextImpl* ctxI) noexcept {
  if ((ctxI->contextFlags & BL_RASTER_CONTEXT_STATE_USER_MATRIX) != 0) {
    // MetaMatrix change would also save UserMatrix, no way this could be unset.
    BL_ASSERT((ctxI->contextFlags & BL_RASTER_CONTEXT_STATE_META_MATRIX) != 0);

    BLRasterContextSavedState* state = ctxI->savedState;
    state->altMatrix = ctxI->finalMatrix;
    state->userMatrix = ctxI->currentState.userMatrix;
  }
}

static BL_INLINE void blRasterContextImplUpdateFinalMatrix(BLRasterContextImpl* ctxI) noexcept {
  blMatrix2DMultiply(ctxI->finalMatrix, ctxI->currentState.userMatrix, ctxI->currentState.metaMatrix);
}

static BL_INLINE void blRasterContextImplUpdateMetaMatrixFixed(BLRasterContextImpl* ctxI) noexcept {
  ctxI->metaMatrixFixed = ctxI->currentState.metaMatrix;
  ctxI->metaMatrixFixed.postScale(ctxI->fpScaleD);
}

static BL_INLINE void blRasterContextImplUpdateFinalMatrixFixed(BLRasterContextImpl* ctxI) noexcept {
  ctxI->finalMatrixFixed = ctxI->finalMatrix;
  ctxI->finalMatrixFixed.postScale(ctxI->fpScaleD);
}

// Called after `userMatrix` has been modified.
//
// Responsible for updating `finalMatrix` and other matrix information.
static BL_INLINE void blRasterContextUserMatrixChanged(BLRasterContextImpl* ctxI) noexcept {
  ctxI->contextFlags &= ~(BL_RASTER_CONTEXT_NO_USER_MATRIX       |
                          BL_RASTER_CONTEXT_INTEGRAL_TRANSLATION |
                          BL_RASTER_CONTEXT_STATE_USER_MATRIX    );

  blRasterContextImplUpdateFinalMatrix(ctxI);
  blRasterContextImplUpdateFinalMatrixFixed(ctxI);

  BLMatrix2D& fm = ctxI->finalMatrixFixed;
  uint32_t finalMatrixType = ctxI->finalMatrix.type();

  ctxI->finalMatrixType = uint8_t(finalMatrixType);
  ctxI->finalMatrixFixedType = uint8_t(blMax<uint32_t>(finalMatrixType, BL_MATRIX2D_TYPE_SCALE));

  if (finalMatrixType <= BL_MATRIX2D_TYPE_TRANSLATE) {
    // No scaling - input coordinates have pixel granularity. Check if the
    // translation has pixel granularity as well and setup the `translationI`
    // data for that case.
    if (fm.m20 >= ctxI->fpMinSafeCoordD && fm.m20 <= ctxI->fpMaxSafeCoordD &&
        fm.m21 >= ctxI->fpMinSafeCoordD && fm.m21 <= ctxI->fpMaxSafeCoordD) {
      // We need 64-bit ints here as we are already scaled. We also need a `floor`
      // function as we have to handle negative translations which cannot be
      // truncated (the default conversion).
      int64_t tx64 = blFloorToInt64(fm.m20);
      int64_t ty64 = blFloorToInt64(fm.m21);

      // Pixel to pixel translation is only possible when both fixed points
      // `tx64` and `ty64` have all zeros in their fraction parts.
      if (((tx64 | ty64) & ctxI->fpMaskI) == 0) {
        int tx = int(tx64 >> ctxI->fpShiftI);
        int ty = int(ty64 >> ctxI->fpShiftI);

        ctxI->translationI.reset(tx, ty);
        ctxI->contextFlags |= BL_RASTER_CONTEXT_INTEGRAL_TRANSLATION;
      }
    }
  }
}

// ============================================================================
// [BLRasterContext - Clip State Internals]
// ============================================================================

static BL_INLINE void blRasterContextImplBeforeClipBoxChange(BLRasterContextImpl* ctxI) noexcept {
  if (ctxI->contextFlags & BL_RASTER_CONTEXT_STATE_CLIP) {
    BLRasterContextSavedState* state = ctxI->savedState;
    state->finalClipBoxD = ctxI->finalClipBoxD;
  }
}

static BL_INLINE void blRasterContextImplResetClippingToMetaClipBox(BLRasterContextImpl* ctxI) noexcept {
  const BLBoxI& meta = ctxI->metaClipBoxI;
  ctxI->finalClipBoxI.reset(meta.x0, meta.y0, meta.x1, meta.y1);
  ctxI->finalClipBoxD.reset(meta.x0, meta.y0, meta.x1, meta.y1);
  ctxI->setFinalClipBoxFixedD(ctxI->finalClipBoxD * ctxI->fpScaleD);
}

static BL_INLINE void blRasterContextImplRestoreClippingFromState(BLRasterContextImpl* ctxI, BLRasterContextSavedState* savedState) noexcept {
  // TODO: Path-based clipping.
  ctxI->finalClipBoxD = savedState->finalClipBoxD;

  ctxI->finalClipBoxI.reset(
    blTruncToInt(ctxI->finalClipBoxD.x0),
    blTruncToInt(ctxI->finalClipBoxD.y0),
    blCeilToInt(ctxI->finalClipBoxD.x1),
    blCeilToInt(ctxI->finalClipBoxD.y1));

  double fpScale = ctxI->fpScaleD;
  ctxI->setFinalClipBoxFixedD(BLBox(
    ctxI->finalClipBoxD.x0 * fpScale,
    ctxI->finalClipBoxD.y0 * fpScale,
    ctxI->finalClipBoxD.x1 * fpScale,
    ctxI->finalClipBoxD.y1 * fpScale));
}

// ============================================================================
// [BLRasterContext - Rendering Internals - FillCmd]
// ============================================================================

static BL_INLINE uint32_t blRasterContextImplPrepareClear(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, uint32_t fillRule, uint32_t nopFlags) noexcept {
  BLCompOpSimplifyInfo simplifyInfo = blCompOpSimplifyInfo(BL_COMP_OP_CLEAR, ctxI->dstInfo.format, BL_FORMAT_PRGB32);
  uint32_t contextFlags = ctxI->contextFlags;

  fillCmd->reset(simplifyInfo.signature(), ctxI->dstInfo.fullAlphaI, fillRule);
  nopFlags &= contextFlags;

  if (nopFlags != 0)
    return BL_RASTER_CONTEXT_FILL_STATUS_NOP;

  // The combination of a destination format, source format, and compOp results
  // in a solid fill. The only thing we have to do is to copy the correct source
  // color to the `solidData`.
  fillCmd->solidData.prgb32 = blRasterContextSolidDataRgba32[simplifyInfo.solidId()];
  fillCmd->fetchData = blFetchDataSolidSentinel();

  return BL_RASTER_CONTEXT_FILL_STATUS_SOLID;
}

static BL_INLINE uint32_t blRasterContextImplPrepareFill(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, BLRasterContextStyleData* styleData, uint32_t fillRule, uint32_t nopFlags) noexcept {
  BLCompOpSimplifyInfo simplifyInfo = ctxI->compOpSimplifyTable[styleData->styleFormat];
  uint32_t solidId = simplifyInfo.solidId();
  uint32_t contextFlags = ctxI->contextFlags | solidId;

  fillCmd->reset(simplifyInfo.signature(), styleData->alphaI, fillRule);
  fillCmd->setFetchDataFromStyle(styleData);

  // Likely case - composition flag doesn't lead to a solid fill and there are no
  // other 'NO_' flags so the rendering of this command should produce something.
  //
  // This works since we combined `contextFlags` with `srcSolidId`, which is only
  // non-zero to force either NOP or SOLID fill.
  nopFlags &= contextFlags;
  if (nopFlags == 0)
    return BL_RASTER_CONTEXT_FILL_STATUS_FETCH;

  // Remove reserved flags we may have added to `nopFlags` if srcSolidId was
  // non-zero and add a possible condition flag to `nopFlags` if the composition
  // is NOP (DST-COPY).
  nopFlags &= ~BL_RASTER_CONTEXT_NO_RESERVED;
  nopFlags |= uint32_t(fillCmd->baseSignature == BLCompOpSimplifyInfo::dstCopy().signature());

  // Nothing to render as compOp, style, alpha, or something else is nop/invalid.
  if (nopFlags != 0)
    return BL_RASTER_CONTEXT_FILL_STATUS_NOP;

  // The combination of a destination format, source format, and compOp results
  // in a solid fill. The only thing we have to do is to copy the correct source
  // color to the `solidData`.
  fillCmd->solidData.prgb32 = blRasterContextSolidDataRgba32[solidId];
  fillCmd->fetchData = blFetchDataSolidSentinel();

  return BL_RASTER_CONTEXT_FILL_STATUS_SOLID;
}

static BL_INLINE BLResult blRasterContextImplEnsureFetchData(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd) noexcept {
  BLRasterFetchData* fetchData = fillCmd->fetchData;

  if (fetchData == blFetchDataSolidSentinel()) {
    fillCmd->baseSignature.addFetchType(BL_PIPE_FETCH_TYPE_SOLID);
    fillCmd->fetchData = const_cast<BLRasterFetchData*>(reinterpret_cast<const BLRasterFetchData*>(&fillCmd->solidData));
  }
  else {
    if (!fetchData) {
      fetchData = blRasterContextImplCreateFetchData(ctxI, fillCmd->styleData);
      if (BL_UNLIKELY(!fetchData))
        return blTraceError(BL_ERROR_OUT_OF_MEMORY);

      fillCmd->styleData->fetchData = fetchData;
    }

    fillCmd->baseSignature.addFetchType(fetchData->fetchType);
    fillCmd->fetchData = fetchData;
  }

  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Rendering Internals - Fill Safe Data]
// ============================================================================

static BL_INLINE BLResult blRasterContextImplProcessFillCmd(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, BLRasterFiller& fillContext) noexcept {
  BLPipeSignature sig(0);
  sig.add(fillCmd->baseSignature);
  sig.add(fillContext.fillSignature);
  fillContext.setFillFunc(blRasterContextImplGetFillFunc(ctxI, sig.value));
  return fillContext.doWork(&ctxI->workerCtx, fillCmd->fetchData);
}

static BL_INLINE BLResult blRasterContextImplFillClippedBoxAA(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, const BLBoxI& box) noexcept {
  BLRasterFiller fillContext;
  fillContext.initBoxAA8bpc(fillCmd->alphaI, box.x0, box.y0, box.x1, box.y1);

  BL_PROPAGATE(blRasterContextImplEnsureFetchData(ctxI, fillCmd));
  return blRasterContextImplProcessFillCmd(ctxI, fillCmd, fillContext);
}

static BL_INLINE BLResult blRasterContextImplFillClippedBoxAU(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, const BLBoxI& box) noexcept {
  BLRasterFiller fillContext;
  fillContext.initBoxAU8bpc24x8(fillCmd->alphaI, box.x0, box.y0, box.x1, box.y1);

  if (!fillContext.isValid())
    return BL_SUCCESS;

  BL_PROPAGATE(blRasterContextImplEnsureFetchData(ctxI, fillCmd));
  return blRasterContextImplProcessFillCmd(ctxI, fillCmd, fillContext);
}

static BL_INLINE BLResult blRasterContextImplFillClippedEdges(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd) noexcept {
  // No data or everything was clipped out (no edges at all).
  if (ctxI->workerCtx.edgeStorage.empty())
    return BL_SUCCESS;

  BLResult result = blRasterContextImplEnsureFetchData(ctxI, fillCmd);
  if (BL_UNLIKELY(result != BL_SUCCESS)) {
    ctxI->workerCtx.edgeBuilder.mergeBoundingBox();
    ctxI->workerCtx.edgeStorage.clear();
    ctxI->workerCtx.workZone.clear();
    return result;
  }

  BLRasterFiller fillContext;
  fillContext.initAnalytic(fillCmd->alphaI, &ctxI->workerCtx.edgeStorage, fillCmd->fillRule);

  return blRasterContextImplProcessFillCmd(ctxI, fillCmd, fillContext);
}

// ============================================================================
// [BLRasterContext - Rendering Internals - Fill Unsafe Data]
// ============================================================================

static BL_NOINLINE BLResult blRasterContextImplFillUnsafePolyData(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, const BLMatrix2D& m, uint32_t mType, const BLPoint* pts, size_t size) noexcept {
  BLEdgeBuilder<int>& edgeBuilder = ctxI->workerCtx.edgeBuilder;
  edgeBuilder.begin();
  edgeBuilder.addPoly(pts, size, m, mType);
  edgeBuilder.done();
  return blRasterContextImplFillClippedEdges(ctxI, fillCmd);
}

static BL_NOINLINE BLResult blRasterContextImplFillUnsafePathData(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, const BLMatrix2D& m, uint32_t mType, const BLPathView& pathView) noexcept {
  BLEdgeBuilder<int>& edgeBuilder = ctxI->workerCtx.edgeBuilder;
  edgeBuilder.begin();
  edgeBuilder.addPath(pathView, true, m, mType);
  edgeBuilder.done();

  return blRasterContextImplFillClippedEdges(ctxI, fillCmd);
}

static BL_INLINE BLResult blRasterContextImplFillUnsafePath(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, const BLMatrix2D& m, uint32_t mType, const BLPath& path) noexcept {
  return blRasterContextImplFillUnsafePathData(ctxI, fillCmd, m, mType, path.impl->view);
}

static BL_INLINE BLResult blRasterContextImplFillUnsafeBox(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, const BLMatrix2D& m, uint32_t mType, const BLBox& box) noexcept {
  if (mType <= BL_MATRIX2D_TYPE_SWAP) {
    BLBox finalBox = blMatrix2DMapBox(m, box);

    if (!blIntersectBoxes(finalBox, finalBox, ctxI->finalClipBoxFixedD()))
      return BL_SUCCESS;

    BLBoxI finalBoxFixed(blTruncToInt(finalBox.x0),
                         blTruncToInt(finalBox.y0),
                         blTruncToInt(finalBox.x1),
                         blTruncToInt(finalBox.y1));
    return blRasterContextImplFillClippedBoxAU(ctxI, fillCmd, finalBoxFixed);
  }
  else {
    BLPoint polyD[] = {
      BLPoint(box.x0, box.y0),
      BLPoint(box.x1, box.y0),
      BLPoint(box.x1, box.y1),
      BLPoint(box.x0, box.y1)
    };
    return blRasterContextImplFillUnsafePolyData(ctxI, fillCmd, m, mType, polyD, BL_ARRAY_SIZE(polyD));
  }
}

// Fully integer-based rectangle fill.
static BL_INLINE BLResult blRasterContextImplFillUnsafeRectI(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, const BLRectI& rect) noexcept {
  int rw = rect.w;
  int rh = rect.h;

  if (!(ctxI->contextFlags & BL_RASTER_CONTEXT_INTEGRAL_TRANSLATION)) {
    // Clipped out.
    if ((rw <= 0) | (rh <= 0))
      return BL_SUCCESS;

    BLBox boxD(double(rect.x),
               double(rect.y),
               double(rect.x) + double(rect.w),
               double(rect.y) + double(rect.h));
    return blRasterContextImplFillUnsafeBox(ctxI, fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, boxD);
  }

  if (BL_TARGET_ARCH_BITS < 64) {
    BLOverflowFlag of = 0;

    int x0 = blAddOverflow(rect.x, ctxI->translationI.x, &of);
    int y0 = blAddOverflow(rect.y, ctxI->translationI.y, &of);
    int x1 = blAddOverflow(rw, x0, &of);
    int y1 = blAddOverflow(rh, y0, &of);

    if (BL_UNLIKELY(of))
      goto Use64Bit;

    x0 = blMax(x0, ctxI->finalClipBoxI.x0);
    y0 = blMax(y0, ctxI->finalClipBoxI.y0);
    x1 = blMin(x1, ctxI->finalClipBoxI.x1);
    y1 = blMin(y1, ctxI->finalClipBoxI.y1);

    // Clipped out or invalid rect.
    if ((x0 >= x1) | (y0 >= y1))
      return BL_SUCCESS;

    BLBoxI boxI{int(x0), int(y0), int(x1), int(y1)};
    return blRasterContextImplFillClippedBoxAA(ctxI, fillCmd, boxI);

  }
  else {
Use64Bit:
    int64_t x0 = int64_t(rect.x) + int64_t(ctxI->translationI.x);
    int64_t y0 = int64_t(rect.y) + int64_t(ctxI->translationI.y);
    int64_t x1 = int64_t(rw) + x0;
    int64_t y1 = int64_t(rh) + y0;

    x0 = blMax<int64_t>(x0, ctxI->finalClipBoxI.x0);
    y0 = blMax<int64_t>(y0, ctxI->finalClipBoxI.y0);
    x1 = blMin<int64_t>(x1, ctxI->finalClipBoxI.x1);
    y1 = blMin<int64_t>(y1, ctxI->finalClipBoxI.y1);

    // Clipped out or invalid rect.
    if ((x0 >= x1) | (y0 >= y1))
      return BL_SUCCESS;

    BLBoxI boxI{int(x0), int(y0), int(x1), int(y1)};
    return blRasterContextImplFillClippedBoxAA(ctxI, fillCmd, boxI);
  }
}

// ============================================================================
// [BLRasterContext - Rendering Internals - Stroke Unsafe Data]
// ============================================================================

struct BLRasterContextEdgeBuilderSink {
  BLRasterContextImpl* ctxI;
  BLEdgeBuilder<int>* edgeBuilder;
};

// Stroke Sink
// -----------
//
// Passes the stroked paths to EdgeBuilder and flips signs where necessary.
// This is much better than using BLPath::addStrokedPath() as no reversal
// of `b` path is necessary, instead we flip sign of such path directly in
// EdgeBuilder
struct BLRasterContextStrokeSink : public BLRasterContextEdgeBuilderSink {
  const BLMatrix2D* m;
  uint32_t mType;

  static BLResult BL_CDECL func(BLPath* a, BLPath* b, BLPath* c, void* closure_) noexcept {
    BLRasterContextStrokeSink* self = static_cast<BLRasterContextStrokeSink*>(closure_);
    BLEdgeBuilder<int>* edgeBuilder = self->edgeBuilder;

    BL_PROPAGATE(edgeBuilder->addPath(a->view(), false, *self->m, self->mType));
    BL_PROPAGATE(edgeBuilder->flipSign());
    BL_PROPAGATE(edgeBuilder->addPath(b->view(), false, *self->m, self->mType));
    BL_PROPAGATE(edgeBuilder->flipSign());

    if (!c->empty())
      BL_PROPAGATE(edgeBuilder->addPath(c->view(), false, *self->m, self->mType));

    return a->clear();
  }
};

static BL_INLINE BLResult blRasterContextImplStrokeUnsafePath(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, const BLPath* path) noexcept {
  BLRasterContextStrokeSink sink;

  sink.ctxI = ctxI;
  sink.edgeBuilder = &ctxI->workerCtx.edgeBuilder;

  sink.m = &ctxI->finalMatrixFixed;
  sink.mType = ctxI->finalMatrixFixedType;

  BLPath* a = &ctxI->workerCtx.tmpPath[0];
  BLPath* b = &ctxI->workerCtx.tmpPath[1];
  BLPath* c = &ctxI->workerCtx.tmpPath[2];

  if (ctxI->currentState.strokeOptions.transformOrder != BL_STROKE_TRANSFORM_ORDER_AFTER) {
    a->clear();
    BL_PROPAGATE(blPathAddTransformedPath(a, path, nullptr, &ctxI->currentState.userMatrix));

    path = a;
    a = &ctxI->workerCtx.tmpPath[3];

    sink.m = &ctxI->metaMatrixFixed;
    sink.mType = ctxI->metaMatrixFixedType;
  }

  a->clear();
  ctxI->workerCtx.edgeBuilder.begin();

  BLResult result = blPathStrokeInternal(
    path->view(),
    ctxI->currentState.strokeOptions,
    ctxI->currentState.approximationOptions,
    a, b, c,
    BLRasterContextStrokeSink::func, &sink);

  if (result == BL_SUCCESS)
    result = ctxI->workerCtx.edgeBuilder.done();

  if (BL_UNLIKELY(result != BL_SUCCESS)) {
    ctxI->workerCtx.edgeBuilder.mergeBoundingBox();
    ctxI->workerCtx.edgeStorage.clear();
    ctxI->workerCtx.workZone.clear();
    return result;
  }

  return blRasterContextImplFillClippedEdges(ctxI, fillCmd);
}

// ============================================================================
// [BLRasterContext - Flush]
// ============================================================================

BLResult BL_CDECL blRasterContextImplFlush(BLContextImpl* baseImpl, uint32_t flags) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BL_UNUSED(ctxI);
  BL_UNUSED(flags);

  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Save / Restore]
// ============================================================================

// Returns how many states have to be restored to match the `stateId`. It would
// return zero if there is no state that matches `stateId`.
static BL_INLINE uint32_t blRasterContextImplNumStatesToRestore(BLRasterContextSavedState* savedState, uint64_t stateId) noexcept {
  uint32_t n = 1;
  do {
    uint64_t savedId = savedState->stateId;
    if (savedId <= stateId)
      return savedId == stateId ? n : uint32_t(0);
    n++;
    savedState = savedState->prevState;
  } while (savedState);

  return 0;
}

// "CoreState" consists of states that are always saved and restored to make
// the restoration simpler. All states saved/restored by CoreState should be
// cheap to copy.
static BL_INLINE void blRasterContextImplSaveCoreState(BLRasterContextImpl* ctxI, BLRasterContextSavedState* state) noexcept {
  state->prevContextFlags = ctxI->contextFlags;

  state->hints = ctxI->currentState.hints;
  state->compOp = ctxI->currentState.compOp;
  state->fillRule = ctxI->currentState.fillRule;
  state->clipMode = ctxI->workerCtx.clipMode;

  state->metaMatrixType = ctxI->metaMatrixType;
  state->finalMatrixType = ctxI->finalMatrixType;
  state->metaMatrixFixedType = ctxI->metaMatrixFixedType;
  state->finalMatrixFixedType = ctxI->finalMatrixFixedType;
  state->translationI = ctxI->translationI;

  state->globalAlpha = ctxI->currentState.globalAlpha;
  state->styleAlpha[0] = ctxI->currentState.styleAlpha[0];
  state->styleAlpha[1] = ctxI->currentState.styleAlpha[1];

  state->globalAlphaI = ctxI->globalAlphaI;
  state->style[0].alphaI = ctxI->style[0].alphaI;
  state->style[1].alphaI = ctxI->style[1].alphaI;
}

static BL_INLINE void blRasterContextImplRestoreCoreState(BLRasterContextImpl* ctxI, BLRasterContextSavedState* state) noexcept {
  ctxI->contextFlags = state->prevContextFlags;

  ctxI->currentState.hints = state->hints;
  ctxI->currentState.compOp = state->compOp;
  ctxI->currentState.fillRule = state->fillRule;
  ctxI->workerCtx.clipMode = state->clipMode;

  ctxI->metaMatrixType = state->metaMatrixType;
  ctxI->finalMatrixType = state->finalMatrixType;
  ctxI->metaMatrixFixedType = state->metaMatrixFixedType;
  ctxI->finalMatrixFixedType = state->finalMatrixFixedType;
  ctxI->translationI = state->translationI;

  ctxI->currentState.globalAlpha = state->globalAlpha;
  ctxI->currentState.styleAlpha[0] = state->styleAlpha[0];
  ctxI->currentState.styleAlpha[1] = state->styleAlpha[1];

  ctxI->globalAlphaI = state->globalAlphaI;
  ctxI->style[0].alphaI = state->style[0].alphaI;
  ctxI->style[1].alphaI = state->style[1].alphaI;

  blRasterContextImplCompOpChanged(ctxI);
}

static void blRasterContextImplDiscardStates(BLRasterContextImpl* ctxI, BLRasterContextSavedState* topState) noexcept {
  BLRasterContextSavedState* savedState = ctxI->savedState;
  if (savedState == topState)
    return;

  // NOTE: No need to handle states that don't require any memory management.
  uint32_t contextFlags = ctxI->contextFlags;
  do {
    if ((contextFlags & (BL_RASTER_CONTEXT_FILL_FETCH_DATA | BL_RASTER_CONTEXT_STATE_FILL_STYLE)) == BL_RASTER_CONTEXT_FILL_FETCH_DATA) {
      constexpr uint32_t kOpType = BL_CONTEXT_OP_TYPE_FILL;
      BLRasterFetchData* fetchData = savedState->style[kOpType].fetchData;

      if (blFetchDataIsCreated(fetchData))
        blRasterContextImplReleaseFetchData(ctxI, fetchData);
      blVariantImplRelease(savedState->style[kOpType].variant->impl);
    }

    if ((contextFlags & (BL_RASTER_CONTEXT_STROKE_FETCH_DATA | BL_RASTER_CONTEXT_STATE_STROKE_STYLE)) == BL_RASTER_CONTEXT_STROKE_FETCH_DATA) {
      constexpr uint32_t kOpType = BL_CONTEXT_OP_TYPE_STROKE;
      BLRasterFetchData* fetchData = savedState->style[kOpType].fetchData;

      if (blFetchDataIsCreated(fetchData))
        blRasterContextImplReleaseFetchData(ctxI, fetchData);
      blVariantImplRelease(savedState->style[kOpType].variant->impl);
    }

    if ((contextFlags & BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS) == 0) {
      blCallDtor(savedState->strokeOptions.dashArray);
    }

    BLRasterContextSavedState* prevState = savedState->prevState;
    contextFlags = savedState->prevContextFlags;

    ctxI->statePool.free(savedState);
    savedState = prevState;
  } while (savedState != topState);

  // Make 'topState' the current state.
  ctxI->savedState = topState;
  ctxI->contextFlags = contextFlags;
}

static BLResult BL_CDECL blRasterContextImplSave(BLContextImpl* baseImpl, BLContextCookie* cookie) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLRasterContextSavedState* newState = ctxI->statePool.alloc();

  if (BL_UNLIKELY(!newState))
    return blTraceError(BL_ERROR_OUT_OF_MEMORY);

  newState->prevState = ctxI->savedState;
  newState->stateId = blMaxValue<uint64_t>();

  ctxI->savedState = newState;
  ctxI->currentState.savedStateCount++;

  blRasterContextImplSaveCoreState(ctxI, newState);
  ctxI->contextFlags |= BL_RASTER_CONTEXT_STATE_ALL_FLAGS;

  if (!cookie)
    return BL_SUCCESS;

  // Setup the given `coookie` and make the state cookie-dependent.
  uint64_t stateId = ++ctxI->stateIdCounter;
  newState->stateId = stateId;

  cookie->reset(ctxI->contextOriginId, stateId);
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplRestore(BLContextImpl* baseImpl, const BLContextCookie* cookie) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLRasterContextSavedState* savedState = ctxI->savedState;

  if (BL_UNLIKELY(!savedState))
    return blTraceError(BL_ERROR_NO_STATES_TO_RESTORE);

  // By default there would be only one state to restore if `cookie` was not provided.
  uint32_t n = 1;

  if (cookie) {
    // Verify context origin.
    if (BL_UNLIKELY(cookie->data[0] != ctxI->contextOriginId))
      return blTraceError(BL_ERROR_NO_MATCHING_COOKIE);

    // Verify cookie payload and get the number of states we have to restore (if valid).
    n = blRasterContextImplNumStatesToRestore(savedState, cookie->data[1]);
    if (BL_UNLIKELY(n == 0))
      return blTraceError(BL_ERROR_NO_MATCHING_COOKIE);
  }
  else {
    // A state that has a `stateId` assigned cannot be restored without a matching cookie.
    if (savedState->stateId != blMaxValue<uint64_t>())
      return blTraceError(BL_ERROR_NO_MATCHING_COOKIE);
  }

  ctxI->currentState.savedStateCount -= n;
  for (;;) {
    uint32_t restoreFlags = ctxI->contextFlags;
    blRasterContextImplRestoreCoreState(ctxI, savedState);

    if ((restoreFlags & BL_RASTER_CONTEXT_STATE_CONFIG) == 0) {
      ctxI->currentState.approximationOptions = savedState->approximationOptions;
      blRasterContextImplFlattenToleranceChanged(ctxI);
      blRasterContextImplOffsetParameterChanged(ctxI);
    }

    if ((restoreFlags & BL_RASTER_CONTEXT_STATE_CLIP) == 0)
      blRasterContextImplRestoreClippingFromState(ctxI, savedState);

    if ((restoreFlags & BL_RASTER_CONTEXT_STATE_FILL_STYLE) == 0) {
      constexpr uint32_t kOpType = BL_CONTEXT_OP_TYPE_FILL;

      BLRasterContextStyleData* dst = &ctxI->style[kOpType];
      BLRasterContextStyleData* src = &savedState->style[kOpType];

      if (restoreFlags & BL_RASTER_CONTEXT_FILL_FETCH_DATA)
        blRasterContextImplDestroyValidStyle(ctxI, dst);

      dst->packed = src->packed;
      dst->solidData.prgb64 = src->solidData.prgb64;
      dst->fetchData = src->fetchData;

      dst->rgba64 = src->rgba64;
      dst->adjustedMatrix = src->adjustedMatrix;
      ctxI->currentState.styleType[kOpType] = src->styleType;
    }

    if ((restoreFlags & BL_RASTER_CONTEXT_STATE_STROKE_STYLE) == 0) {
      constexpr uint32_t kOpType = BL_CONTEXT_OP_TYPE_STROKE;

      BLRasterContextStyleData* dst = &ctxI->style[kOpType];
      BLRasterContextStyleData* src = &savedState->style[kOpType];

      if (restoreFlags & BL_RASTER_CONTEXT_STROKE_FETCH_DATA)
        blRasterContextImplDestroyValidStyle(ctxI, dst);

      dst->packed = src->packed;
      dst->solidData.prgb64 = src->solidData.prgb64;
      dst->fetchData = src->fetchData;

      dst->rgba64 = src->rgba64;
      dst->adjustedMatrix = src->adjustedMatrix;
      ctxI->currentState.styleType[kOpType] = src->styleType;
    }

    if ((restoreFlags & BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS) == 0) {
      // NOTE: This code is unsafe, but since we know that `BLStrokeOptions` is
      // movable it's just fine. We destroy `BLStrokeOptions` first and then move
      // into that destroyed instance params from the state itself.
      blArrayReset(&ctxI->currentState.strokeOptions.dashArray);
      memcpy(&ctxI->currentState.strokeOptions, &savedState->strokeOptions, sizeof(BLStrokeOptions));
    }

    // UserMatrix state is unsed when MetaMatrix and/or UserMatrix were saved.
    if ((restoreFlags & BL_RASTER_CONTEXT_STATE_USER_MATRIX) == 0) {
      ctxI->currentState.userMatrix = savedState->userMatrix;

      if ((restoreFlags & BL_RASTER_CONTEXT_STATE_META_MATRIX) == 0) {
        ctxI->currentState.metaMatrix = savedState->altMatrix;
        blRasterContextImplUpdateFinalMatrix(ctxI);
        blRasterContextImplUpdateMetaMatrixFixed(ctxI);
        blRasterContextImplUpdateFinalMatrixFixed(ctxI);
      }
      else {
        ctxI->finalMatrix = savedState->altMatrix;
        blRasterContextImplUpdateFinalMatrixFixed(ctxI);
      }
    }

    BLRasterContextSavedState* finishedSavedState = savedState;
    savedState = savedState->prevState;

    ctxI->savedState = savedState;
    ctxI->statePool.free(finishedSavedState);

    if (--n == 0)
      break;
  }

  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Transformations]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplMatrixOp(BLContextImpl* baseImpl, uint32_t opType, const void* opData) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  blRasterContextImplBeforeUserMatrixChange(ctxI);
  BL_PROPAGATE(blMatrix2DApplyOp(&ctxI->currentState.userMatrix, opType, opData));

  blRasterContextUserMatrixChanged(ctxI);
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplUserToMeta(BLContextImpl* baseImpl) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  constexpr uint32_t kUserAndMetaFlags = BL_RASTER_CONTEXT_STATE_META_MATRIX |
                                         BL_RASTER_CONTEXT_STATE_USER_MATRIX ;

  if (ctxI->contextFlags & kUserAndMetaFlags) {
    BLRasterContextSavedState* state = ctxI->savedState;

    // Always save both `metaMatrix` and `userMatrix` in case we have to save
    // the current state before we change the matrix. In this case the `altMatrix`
    // of the state would store the current `metaMatrix` and on state restore
    // the final matrix would be recalculated in-place.
    state->altMatrix = ctxI->currentState.metaMatrix;

    // Don't copy it if it was already saved, we would have copied an altered
    // userMatrix.
    if (ctxI->contextFlags & BL_RASTER_CONTEXT_STATE_USER_MATRIX)
      state->userMatrix = ctxI->currentState.userMatrix;
  }

  ctxI->contextFlags &= ~kUserAndMetaFlags;
  ctxI->currentState.userMatrix.reset();
  ctxI->currentState.metaMatrix = ctxI->finalMatrix;
  ctxI->metaMatrixFixed = ctxI->finalMatrixFixed;
  ctxI->metaMatrixType = ctxI->finalMatrixType;
  ctxI->metaMatrixFixedType = ctxI->finalMatrixFixedType;

  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Rendering Hints]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplSetHint(BLContextImpl* baseImpl, uint32_t hintType, uint32_t value) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  switch (hintType) {
    case BL_CONTEXT_HINT_RENDERING_QUALITY:
      if (BL_UNLIKELY(value >= BL_RENDERING_QUALITY_COUNT))
        return blTraceError(BL_ERROR_INVALID_VALUE);

      ctxI->currentState.hints.renderingQuality = uint8_t(value);
      return BL_SUCCESS;

    case BL_CONTEXT_HINT_GRADIENT_QUALITY:
      if (BL_UNLIKELY(value >= BL_GRADIENT_QUALITY_COUNT))
        return blTraceError(BL_ERROR_INVALID_VALUE);

      ctxI->currentState.hints.gradientQuality = uint8_t(value);
      return BL_SUCCESS;

    case BL_CONTEXT_HINT_PATTERN_QUALITY:
      if (BL_UNLIKELY(value >= BL_PATTERN_QUALITY_COUNT))
        return blTraceError(BL_ERROR_INVALID_VALUE);

      ctxI->currentState.hints.patternQuality = uint8_t(value);
      return BL_SUCCESS;

    default:
      return blTraceError(BL_ERROR_INVALID_VALUE);
  }
}

static BLResult BL_CDECL blRasterContextImplSetHints(BLContextImpl* baseImpl, const BLContextHints* hints) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  uint8_t renderingQuality = hints->renderingQuality;
  uint8_t patternQuality = hints->patternQuality;
  uint8_t gradientQuality = hints->gradientQuality;

  if (BL_UNLIKELY(renderingQuality >= BL_RENDERING_QUALITY_COUNT ||
                  patternQuality   >= BL_PATTERN_QUALITY_COUNT   ||
                  gradientQuality  >= BL_GRADIENT_QUALITY_COUNT  ))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  ctxI->currentState.hints.renderingQuality = renderingQuality;
  ctxI->currentState.hints.patternQuality = patternQuality;
  ctxI->currentState.hints.gradientQuality = gradientQuality;
  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Approximation Options]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplSetFlattenMode(BLContextImpl* baseImpl, uint32_t mode) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(mode >= BL_FLATTEN_MODE_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeConfigChange(ctxI);
  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_CONFIG;

  ctxI->currentState.approximationOptions.flattenMode = uint8_t(mode);
  blRasterContextImplFlattenToleranceChanged(ctxI);

  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetFlattenTolerance(BLContextImpl* baseImpl, double tolerance) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(blIsNaN(tolerance)))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeConfigChange(ctxI);
  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_CONFIG;

  tolerance = blClamp(tolerance, BL_CONTEXT_MINIMUM_TOLERANCE, BL_CONTEXT_MAXIMUM_TOLERANCE);
  BL_ASSERT(blIsFinite(tolerance));

  ctxI->currentState.approximationOptions.flattenTolerance = tolerance;
  blRasterContextImplFlattenToleranceChanged(ctxI);

  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetApproximationOptions(BLContextImpl* baseImpl, const BLApproximationOptions* options) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  uint32_t flattenMode = options->flattenMode;
  uint32_t offsetMode = options->offsetMode;

  double flattenTolerance = options->flattenTolerance;
  double offsetParameter = options->offsetParameter;

  if (BL_UNLIKELY(flattenMode >= BL_FLATTEN_MODE_COUNT ||
                  offsetMode >= BL_OFFSET_MODE_COUNT ||
                  blIsNaN(flattenTolerance) ||
                  blIsNaN(offsetParameter)))
    blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeConfigChange(ctxI);
  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_CONFIG;

  BLApproximationOptions& dst = ctxI->currentState.approximationOptions;
  dst.flattenMode = uint8_t(flattenMode);
  dst.offsetMode = uint8_t(offsetMode);
  dst.flattenTolerance = blClamp(flattenTolerance, BL_CONTEXT_MINIMUM_TOLERANCE, BL_CONTEXT_MAXIMUM_TOLERANCE);
  dst.offsetParameter = offsetParameter;

  blRasterContextImplFlattenToleranceChanged(ctxI);
  blRasterContextImplOffsetParameterChanged(ctxI);
  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Compositing Options]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplSetCompOp(BLContextImpl* baseImpl, uint32_t compOp) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(compOp >= BL_COMP_OP_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  ctxI->currentState.compOp = uint8_t(compOp);
  blRasterContextImplCompOpChanged(ctxI);

  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetGlobalAlpha(BLContextImpl* baseImpl, double alpha) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(blIsNaN(alpha)))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  alpha = blClamp(alpha, 0.0, 1.0);

  double intAlphaD = alpha * ctxI->dstInfo.fullAlphaD;
  double fillAlphaD = intAlphaD * ctxI->currentState.styleAlpha[BL_CONTEXT_OP_TYPE_FILL];
  double strokeAlphaD = intAlphaD * ctxI->currentState.styleAlpha[BL_CONTEXT_OP_TYPE_STROKE];

  uint32_t globalAlphaI = uint32_t(blRoundToInt(intAlphaD));
  uint32_t fillAlphaI = uint32_t(blRoundToInt(fillAlphaD));
  uint32_t strokeAlphaI = uint32_t(blRoundToInt(strokeAlphaD));

  ctxI->currentState.globalAlpha = alpha;
  ctxI->globalAlphaI = globalAlphaI;

  ctxI->style[BL_CONTEXT_OP_TYPE_FILL].alphaI = fillAlphaI;
  ctxI->style[BL_CONTEXT_OP_TYPE_STROKE].alphaI = strokeAlphaI;

  uint32_t contextFlags = ctxI->contextFlags;
  contextFlags &= ~(BL_RASTER_CONTEXT_NO_GLOBAL_ALPHA |
                    BL_RASTER_CONTEXT_NO_FILL_ALPHA   |
                    BL_RASTER_CONTEXT_NO_STROKE_ALPHA );

  if (!globalAlphaI) contextFlags |= BL_RASTER_CONTEXT_NO_GLOBAL_ALPHA;
  if (!fillAlphaI  ) contextFlags |= BL_RASTER_CONTEXT_NO_FILL_ALPHA;
  if (!strokeAlphaI) contextFlags |= BL_RASTER_CONTEXT_NO_STROKE_ALPHA;

  ctxI->contextFlags = contextFlags;
  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Fill Options]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplSetFillRule(BLContextImpl* baseImpl, uint32_t fillRule) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(fillRule >= BL_FILL_RULE_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  ctxI->currentState.fillRule = uint8_t(fillRule);
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetFillAlpha(BLContextImpl* baseImpl, double alpha) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(blIsNaN(alpha)))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  alpha = blClamp(alpha, 0.0, 1.0);

  uint32_t alphaI = uint32_t(blRoundToInt(ctxI->currentState.globalAlpha * ctxI->dstInfo.fullAlphaD * alpha));
  ctxI->currentState.styleAlpha[BL_CONTEXT_OP_TYPE_FILL] = alpha;
  ctxI->style[BL_CONTEXT_OP_TYPE_FILL].alphaI = alphaI;

  uint32_t contextFlags = ctxI->contextFlags & ~BL_RASTER_CONTEXT_NO_FILL_ALPHA;
  if (!alphaI) contextFlags |= BL_RASTER_CONTEXT_NO_FILL_ALPHA;

  ctxI->contextFlags = contextFlags;
  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Stroke Options]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplSetStrokeWidth(BLContextImpl* baseImpl, double width) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~(BL_RASTER_CONTEXT_NO_STROKE_OPTIONS    |
                          BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS |
                          BL_RASTER_CONTEXT_STROKE_CHANGED);

  ctxI->currentState.strokeOptions.width = width;
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetStrokeMiterLimit(BLContextImpl* baseImpl, double miterLimit) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~(BL_RASTER_CONTEXT_NO_STROKE_OPTIONS    |
                          BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS |
                          BL_RASTER_CONTEXT_STROKE_CHANGED);

  ctxI->currentState.strokeOptions.miterLimit = miterLimit;
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetStrokeCap(BLContextImpl* baseImpl, uint32_t position, uint32_t strokeCap) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(position >= BL_STROKE_CAP_POSITION_COUNT || strokeCap >= BL_STROKE_CAP_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS;

  ctxI->currentState.strokeOptions.caps[position] = uint8_t(strokeCap);
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetStrokeCaps(BLContextImpl* baseImpl, uint32_t strokeCap) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(strokeCap >= BL_STROKE_CAP_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS;

  for (uint32_t i = 0; i < BL_STROKE_CAP_POSITION_COUNT; i++)
    ctxI->currentState.strokeOptions.caps[i] = uint8_t(strokeCap);
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetStrokeJoin(BLContextImpl* baseImpl, uint32_t strokeJoin) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(strokeJoin >= BL_STROKE_JOIN_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS;

  ctxI->currentState.strokeOptions.join = uint8_t(strokeJoin);
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetStrokeDashOffset(BLContextImpl* baseImpl, double dashOffset) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~(BL_RASTER_CONTEXT_NO_STROKE_OPTIONS    |
                          BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS |
                          BL_RASTER_CONTEXT_STROKE_CHANGED);

  ctxI->currentState.strokeOptions.dashOffset = dashOffset;
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetStrokeDashArray(BLContextImpl* baseImpl, const BLArrayCore* dashArray) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(dashArray->impl->implType != BL_IMPL_TYPE_ARRAY_F64))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~(BL_RASTER_CONTEXT_NO_STROKE_OPTIONS    |
                          BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS |
                          BL_RASTER_CONTEXT_STROKE_CHANGED);

  ctxI->currentState.strokeOptions.dashArray = dashArray->dcast<BLArray<double>>();
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetStrokeTransformOrder(BLContextImpl* baseImpl, uint32_t transformOrder) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(transformOrder >= BL_STROKE_TRANSFORM_ORDER_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS;

  ctxI->currentState.strokeOptions.transformOrder = uint8_t(transformOrder);
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplSetStrokeOptions(BLContextImpl* baseImpl, const BLStrokeOptionsCore* options) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(options->startCap >= BL_STROKE_CAP_COUNT ||
                  options->endCap >= BL_STROKE_CAP_COUNT ||
                  options->join >= BL_STROKE_JOIN_COUNT ||
                  options->transformOrder >= BL_STROKE_TRANSFORM_ORDER_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  blRasterContextImplBeforeStrokeChange(ctxI);
  ctxI->contextFlags &= ~(BL_RASTER_CONTEXT_NO_STROKE_OPTIONS    |
                          BL_RASTER_CONTEXT_STATE_STROKE_OPTIONS |
                          BL_RASTER_CONTEXT_STROKE_CHANGED);
  return blStrokeOptionsAssignWeak(&ctxI->currentState.strokeOptions, options);
}

static BLResult BL_CDECL blRasterContextImplSetStrokeAlpha(BLContextImpl* baseImpl, double alpha) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (BL_UNLIKELY(blIsNaN(alpha)))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  alpha = blClamp(alpha, 0.0, 1.0);

  uint32_t alphaI = uint32_t(blRoundToInt(ctxI->currentState.globalAlpha * ctxI->dstInfo.fullAlphaD * alpha));
  ctxI->currentState.styleAlpha[BL_CONTEXT_OP_TYPE_STROKE] = alpha;
  ctxI->style[BL_CONTEXT_OP_TYPE_STROKE].alphaI = alphaI;

  uint32_t contextFlags = ctxI->contextFlags & ~BL_RASTER_CONTEXT_NO_STROKE_ALPHA;
  if (!alphaI)
    contextFlags |= BL_RASTER_CONTEXT_NO_STROKE_ALPHA;

  ctxI->contextFlags = contextFlags;
  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Clip Operations]
// ============================================================================

static BLResult blRasterContextImplClipToFinalBox(BLRasterContextImpl* ctxI, const BLBox& inputBox) noexcept {
  BLBox b;
  blRasterContextImplBeforeClipBoxChange(ctxI);

  if (blIntersectBoxes(b, ctxI->finalClipBoxD, inputBox)) {
    ctxI->finalClipBoxD = b;
    ctxI->finalClipBoxI.reset(blTruncToInt(b.x0), blTruncToInt(b.y0), blCeilToInt(b.x1), blCeilToInt(b.y1));
    ctxI->setFinalClipBoxFixedD(b * ctxI->fpScaleD);

    double frac = blMax(ctxI->finalClipBoxD.x0 - ctxI->finalClipBoxI.x0,
                        ctxI->finalClipBoxD.y0 - ctxI->finalClipBoxI.y0,
                        ctxI->finalClipBoxD.x1 - ctxI->finalClipBoxI.x1,
                        ctxI->finalClipBoxD.y1 - ctxI->finalClipBoxI.y1) * ctxI->fpScaleD;

    if (blTrunc(frac) == 0)
      ctxI->workerCtx.clipMode = BL_CLIP_MODE_ALIGNED_RECT;
    else
      ctxI->workerCtx.clipMode = BL_CLIP_MODE_UNALIGNED_RECT;
  }
  else {
    ctxI->finalClipBoxD.reset();
    ctxI->finalClipBoxI.reset();
    ctxI->setFinalClipBoxFixedD(BLBox(0, 0, 0, 0));
    ctxI->contextFlags |= BL_RASTER_CONTEXT_NO_CLIP_RECT;
    ctxI->workerCtx.clipMode = BL_CLIP_MODE_ALIGNED_RECT;
  }

  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_CLIP;
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplClipToRectD(BLContextImpl* baseImpl, const BLRect* rect) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  // TODO: Non-rectangular clipping is not supperted yet (affine transformation).
  BLBox inputBox = BLBox(rect->x, rect->y, rect->x + rect->w, rect->y + rect->h);
  return blRasterContextImplClipToFinalBox(ctxI, blMatrix2DMapBox(ctxI->finalMatrix, inputBox));
}

static BLResult BL_CDECL blRasterContextImplClipToRectI(BLContextImpl* baseImpl, const BLRectI* rect) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  // Don't bother if the current ClipBox is not aligned or the translation is not integral.
  if (ctxI->workerCtx.clipMode != BL_CLIP_MODE_ALIGNED_RECT || !(ctxI->contextFlags & BL_RASTER_CONTEXT_INTEGRAL_TRANSLATION)) {
    BLRect rectD;
    rectD.x = double(rect->x);
    rectD.y = double(rect->y);
    rectD.w = double(rect->w);
    rectD.h = double(rect->h);
    return blRasterContextImplClipToRectD(ctxI, &rectD);
  }

  BLBoxI b;
  blRasterContextImplBeforeClipBoxChange(ctxI);

  int tx = ctxI->translationI.x;
  int ty = ctxI->translationI.y;

  if (BL_TARGET_ARCH_BITS < 64) {
    BLOverflowFlag of = 0;

    int x0 = blAddOverflow(tx, rect->x, &of);
    int y0 = blAddOverflow(ty, rect->y, &of);
    int x1 = blAddOverflow(x0, rect->w, &of);
    int y1 = blAddOverflow(y0, rect->h, &of);

    if (BL_UNLIKELY(of))
      goto Use64Bit;

    b.x0 = blMax(x0, ctxI->finalClipBoxI.x0);
    b.y0 = blMax(y0, ctxI->finalClipBoxI.y0);
    b.x1 = blMin(x1, ctxI->finalClipBoxI.x1);
    b.y1 = blMin(y1, ctxI->finalClipBoxI.y1);
  }
  else {
Use64Bit:
    // We don't have to worry about overflow in 64-bit mode.
    int64_t x0 = tx + int64_t(rect->x);
    int64_t y0 = ty + int64_t(rect->y);
    int64_t x1 = x0 + int64_t(rect->w);
    int64_t y1 = y0 + int64_t(rect->h);

    b.x0 = int(blMax<int64_t>(x0, ctxI->finalClipBoxI.x0));
    b.y0 = int(blMax<int64_t>(y0, ctxI->finalClipBoxI.y0));
    b.x1 = int(blMin<int64_t>(x1, ctxI->finalClipBoxI.x1));
    b.y1 = int(blMin<int64_t>(y1, ctxI->finalClipBoxI.y1));
  }

  if (b.x0 < b.x1 && b.y0 < b.y1) {
    ctxI->finalClipBoxI = b;
    ctxI->finalClipBoxD.reset(b);
    ctxI->setFinalClipBoxFixedD(ctxI->finalClipBoxD * ctxI->fpScaleD);
  }
  else {
    ctxI->finalClipBoxI.reset();
    ctxI->finalClipBoxD.reset(b);
    ctxI->setFinalClipBoxFixedD(BLBox(0, 0, 0, 0));
    ctxI->contextFlags |= BL_RASTER_CONTEXT_NO_CLIP_RECT;
  }

  ctxI->contextFlags &= ~BL_RASTER_CONTEXT_STATE_CLIP;
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplRestoreClipping(BLContextImpl* baseImpl) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLRasterContextSavedState* state = ctxI->savedState;

  if (!(ctxI->contextFlags & BL_RASTER_CONTEXT_STATE_CLIP)) {
    if (state) {
      blRasterContextImplRestoreClippingFromState(ctxI, state);
      ctxI->workerCtx.clipMode = state->clipMode;
      ctxI->contextFlags &= ~(BL_RASTER_CONTEXT_NO_CLIP_RECT | BL_RASTER_CONTEXT_STATE_CLIP);
      ctxI->contextFlags |= (state->prevContextFlags & BL_RASTER_CONTEXT_NO_CLIP_RECT);
    }
    else {
      // If there is no state saved it means that we have to restore clipping to
      // the initial state, which is accessible through `metaClipBoxI` member.
      ctxI->contextFlags &= ~(BL_RASTER_CONTEXT_NO_CLIP_RECT);
      blRasterContextImplResetClippingToMetaClipBox(ctxI);
    }
  }

  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Clear Operations]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplClearAll(BLContextImpl* baseImpl) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareClear(ctxI, &fillCmd, BL_RASTER_CONTEXT_PREFERRED_FILL_RULE, BL_RASTER_CONTEXT_NO_CLEAR_FLAGS_FORCE);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  if (ctxI->workerCtx.clipMode == BL_CLIP_MODE_ALIGNED_RECT)
    return blRasterContextImplFillClippedBoxAA(ctxI, &fillCmd, ctxI->finalClipBoxI);

  BLBoxI box(blTruncToInt(ctxI->finalClipBoxFixedD().x0),
             blTruncToInt(ctxI->finalClipBoxFixedD().y0),
             blTruncToInt(ctxI->finalClipBoxFixedD().x1),
             blTruncToInt(ctxI->finalClipBoxFixedD().y1));
  return blRasterContextImplFillClippedBoxAU(ctxI, &fillCmd, box);
}

static BLResult BL_CDECL blRasterContextImplClearRectI(BLContextImpl* baseImpl, const BLRectI* rect) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareClear(ctxI, &fillCmd, BL_RASTER_CONTEXT_PREFERRED_FILL_RULE, BL_RASTER_CONTEXT_NO_CLEAR_FLAGS);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  return blRasterContextImplFillUnsafeRectI(ctxI, &fillCmd, *rect);
}

static BLResult BL_CDECL blRasterContextImplClearRectD(BLContextImpl* baseImpl, const BLRect* rect) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareClear(ctxI, &fillCmd, BL_RASTER_CONTEXT_PREFERRED_FILL_RULE, BL_RASTER_CONTEXT_NO_CLEAR_FLAGS);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  BLBox boxD(rect->x, rect->y, rect->x + rect->w, rect->y + rect->h);
  return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, boxD);
}

// ============================================================================
// [BLRasterContext - Fill Operations]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplFillAll(BLContextImpl* baseImpl) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_FILL], BL_RASTER_CONTEXT_PREFERRED_FILL_RULE, BL_RASTER_CONTEXT_NO_FILL_FLAGS_FORCE);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  if (ctxI->workerCtx.clipMode == BL_CLIP_MODE_ALIGNED_RECT)
    return blRasterContextImplFillClippedBoxAA(ctxI, &fillCmd, ctxI->finalClipBoxI);

  BLBoxI box(blTruncToInt(ctxI->finalClipBoxFixedD().x0),
             blTruncToInt(ctxI->finalClipBoxFixedD().y0),
             blTruncToInt(ctxI->finalClipBoxFixedD().x1),
             blTruncToInt(ctxI->finalClipBoxFixedD().y1));
  return blRasterContextImplFillClippedBoxAU(ctxI, &fillCmd, box);
}

static BLResult BL_CDECL blRasterContextImplFillRectI(BLContextImpl* baseImpl, const BLRectI* rect) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_FILL], BL_RASTER_CONTEXT_PREFERRED_FILL_RULE, BL_RASTER_CONTEXT_NO_FILL_FLAGS);
  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;
  return blRasterContextImplFillUnsafeRectI(ctxI, &fillCmd, *rect);
}

static BLResult BL_CDECL blRasterContextImplFillRectD(BLContextImpl* baseImpl, const BLRect* rect) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_FILL], BL_RASTER_CONTEXT_PREFERRED_FILL_RULE, BL_RASTER_CONTEXT_NO_FILL_FLAGS);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  BLBox boxD(rect->x, rect->y, rect->x + rect->w, rect->y + rect->h);
  return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, boxD);
}

static BLResult BL_CDECL blRasterContextImplFillGeometry(BLContextImpl* baseImpl, uint32_t geometryType, const void* geometryData) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_FILL], ctxI->currentState.fillRule, BL_RASTER_CONTEXT_NO_FILL_FLAGS);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  switch (geometryType) {
    case BL_GEOMETRY_TYPE_BOXD: {
      fillCmd.fillRule = BL_RASTER_CONTEXT_PREFERRED_FILL_RULE;
      return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, *static_cast<const BLBox*>(geometryData));
    }

    case BL_GEOMETRY_TYPE_RECTD: {
      const BLRect* r = static_cast<const BLRect*>(geometryData);
      BLBox boxD {
        r->x,
        r->y,
        r->x + r->w,
        r->y + r->h
      };

      fillCmd.fillRule = BL_RASTER_CONTEXT_PREFERRED_FILL_RULE;
      return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, boxD);
    }

    case BL_GEOMETRY_TYPE_BOXI: {
      const BLBoxI* boxI = static_cast<const BLBoxI*>(geometryData);
      BLBox boxD {
        double(boxI->x0),
        double(boxI->y0),
        double(boxI->x1),
        double(boxI->y1)
      };

      fillCmd.fillRule = BL_RASTER_CONTEXT_PREFERRED_FILL_RULE;
      return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, boxD);
    }

    case BL_GEOMETRY_TYPE_RECTI: {
      fillCmd.fillRule = BL_RASTER_CONTEXT_PREFERRED_FILL_RULE;
      return blRasterContextImplFillUnsafeRectI(ctxI, &fillCmd, *static_cast<const BLRectI*>(geometryData));
    }

    case BL_GEOMETRY_TYPE_POLYGOND:
    case BL_GEOMETRY_TYPE_POLYLINED: {
      const BLArrayView<BLPoint>* array = static_cast<const BLArrayView<BLPoint>*>(geometryData);
      if (BL_UNLIKELY(array->size < 3))
        return BL_SUCCESS;

      return blRasterContextImplFillUnsafePolyData(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, array->data, array->size);
    }

    case BL_GEOMETRY_TYPE_PATH: {
      const BLPath* path = static_cast<const BLPath*>(geometryData);
      if (BL_UNLIKELY(path->empty()))
        return BL_SUCCESS;

      return blRasterContextImplFillUnsafePath(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, *path);
    }
    default: {
      BLPath* path = &ctxI->workerCtx.tmpPath[3];
      path->clear();
      BL_PROPAGATE(path->addGeometry(geometryType, geometryData, nullptr, BL_GEOMETRY_DIRECTION_CW));

      return blRasterContextImplFillUnsafePath(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, *path);
    }
  }
}

static BLResult BL_CDECL blRasterContextImplFillPathD(BLContextImpl* baseImpl, const BLPathCore* path) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  return blRasterContextImplFillGeometry(ctxI, BL_GEOMETRY_TYPE_PATH, path);
}

static BLResult BL_CDECL blRasterContextImplFillGlyphRunD(BLContextImpl* baseImpl, const BLPoint* pt, const BLFontCore* font, const BLGlyphRun* glyphRun) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  if (blDownCast(font)->isNone())
    return blTraceError(BL_ERROR_NOT_INITIALIZED);

  if (glyphRun->empty())
    return BL_SUCCESS;

  BLRasterFillCmd fillCmd;
  if (blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_FILL], BL_FILL_RULE_NON_ZERO, BL_RASTER_CONTEXT_NO_FILL_FLAGS) == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  BLMatrix2D m(ctxI->finalMatrixFixed);
  m.translate(*pt);

  BLResult result = BL_SUCCESS;
  BLPath* tmpPath = &ctxI->workerCtx.tmpPath[3];
  tmpPath->clear();

  BLRasterContextEdgeBuilderSink sink;
  sink.ctxI = ctxI;
  sink.edgeBuilder = &ctxI->workerCtx.edgeBuilder;
  sink.edgeBuilder->begin();

  result = blFontGetGlyphRunOutlines(font, glyphRun, &m, tmpPath, [](BLPathCore* path, const void* info, void* closure_) noexcept -> BLResult {
    BL_UNUSED(info);

    BLRasterContextEdgeBuilderSink* sink = static_cast<BLRasterContextEdgeBuilderSink*>(closure_);
    BLEdgeBuilder<int>* edgeBuilder = sink->edgeBuilder;

    BL_PROPAGATE(edgeBuilder->addPath(path->impl->view, true, blMatrix2DIdentity, BL_MATRIX2D_TYPE_IDENTITY));
    return blDownCast(path)->clear();
  }, &sink);

  if (result == BL_SUCCESS)
    result = ctxI->workerCtx.edgeBuilder.done();

  if (BL_UNLIKELY(result != BL_SUCCESS)) {
    ctxI->workerCtx.edgeBuilder.mergeBoundingBox();
    ctxI->workerCtx.edgeStorage.clear();
    ctxI->workerCtx.workZone.clear();
    return result;
  }

  return blRasterContextImplFillClippedEdges(ctxI, &fillCmd);
}

static BLResult BL_CDECL blRasterContextImplFillGlyphRunI(BLContextImpl* baseImpl, const BLPointI* pt, const BLFontCore* font, const BLGlyphRun* glyphRun) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLPoint ptD(pt->x, pt->y);
  return blRasterContextImplFillGlyphRunD(ctxI, &ptD, font, glyphRun);
}

static BLResult BL_CDECL blRasterContextImplFillTextD(BLContextImpl* baseImpl, const BLPoint* pt, const BLFontCore* font, const void* text, size_t size, uint32_t encoding) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  if (blDownCast(font)->isNone())
    return blTraceError(BL_ERROR_NOT_INITIALIZED);

  BL_PROPAGATE(ctxI->glyphBuffer.setText(text, size, encoding));
  if (ctxI->glyphBuffer.empty())
    return BL_SUCCESS;

  BL_PROPAGATE(blDownCast(font)->shape(ctxI->glyphBuffer));
  return blRasterContextImplFillGlyphRunD(ctxI, pt, font, &ctxI->glyphBuffer.impl->glyphRun);
}

static BLResult BL_CDECL blRasterContextImplFillTextI(BLContextImpl* baseImpl, const BLPointI* pt, const BLFontCore* font, const void* text, size_t size, uint32_t encoding) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLPoint ptD(pt->x, pt->y);
  return blRasterContextImplFillTextD(ctxI, &ptD, font, text, size, encoding);
}

// ============================================================================
// [BLRasterContext - Stroke Operations]
// ============================================================================

static BLResult BL_CDECL blRasterContextImplStrokeRectI(BLContextImpl* baseImpl, const BLRectI* rect) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_STROKE], BL_FILL_RULE_NON_ZERO, BL_RASTER_CONTEXT_NO_STROKE_FLAGS);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  BLPath& path = ctxI->workerCtx.tmpPath[3];
  path.clear();
  BL_PROPAGATE(path.addRect(*rect));

  return blRasterContextImplStrokeUnsafePath(ctxI, &fillCmd, &path);
}

static BLResult BL_CDECL blRasterContextImplStrokeRectD(BLContextImpl* baseImpl, const BLRect* rect) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_STROKE], BL_FILL_RULE_NON_ZERO, BL_RASTER_CONTEXT_NO_STROKE_FLAGS);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  BLPath& path = ctxI->workerCtx.tmpPath[3];
  path.clear();
  BL_PROPAGATE(path.addRect(*rect));

  return blRasterContextImplStrokeUnsafePath(ctxI, &fillCmd, &path);
}

static BLResult BL_CDECL blRasterContextImplStrokeGeometry(BLContextImpl* baseImpl, uint32_t geometryType, const void* geometryData) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (geometryType == BL_GEOMETRY_TYPE_RECTD)
    return blRasterContextImplStrokeRectD(ctxI, static_cast<const BLRect*>(geometryData));

  if (geometryType == BL_GEOMETRY_TYPE_RECTI)
    return blRasterContextImplStrokeRectI(ctxI, static_cast<const BLRectI*>(geometryData));

  BLRasterFillCmd fillCmd;
  uint32_t status = blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_STROKE], BL_FILL_RULE_NON_ZERO, BL_RASTER_CONTEXT_NO_STROKE_FLAGS);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  BLPath* path;
  if (geometryType == BL_GEOMETRY_TYPE_PATH) {
    path = const_cast<BLPath*>(static_cast<const BLPath*>(geometryData));
  }
  else {
    path = &ctxI->workerCtx.tmpPath[3];
    path->clear();
    BL_PROPAGATE(path->addGeometry(geometryType, geometryData, nullptr, BL_GEOMETRY_DIRECTION_CW));
  }

  return blRasterContextImplStrokeUnsafePath(ctxI, &fillCmd, path);
}

static BLResult BL_CDECL blRasterContextImplStrokePathD(BLContextImpl* baseImpl, const BLPathCore* path) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  return blRasterContextImplStrokeGeometry(ctxI, BL_GEOMETRY_TYPE_PATH, path);
}

static BLResult BL_CDECL blRasterContextImplStrokeGlyphRunD(BLContextImpl* baseImpl, const BLPoint* pt, const BLFontCore* font, const BLGlyphRun* glyphRun) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (blDownCast(font)->isNone())
    return blTraceError(BL_ERROR_NOT_INITIALIZED);

  if (glyphRun->empty())
    return BL_SUCCESS;

  BLRasterFillCmd fillCmd;
  if (blRasterContextImplPrepareFill(ctxI, &fillCmd, &ctxI->style[BL_CONTEXT_OP_TYPE_STROKE], BL_FILL_RULE_NON_ZERO, BL_RASTER_CONTEXT_NO_STROKE_FLAGS) == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  BLRasterContextStrokeSink sink;
  sink.ctxI = ctxI;
  sink.edgeBuilder = &ctxI->workerCtx.edgeBuilder;
  sink.edgeBuilder->begin();

  BLMatrix2D preMatrix;
  if (ctxI->currentState.strokeOptions.transformOrder != BL_STROKE_TRANSFORM_ORDER_AFTER) {
    preMatrix = ctxI->currentState.userMatrix;
    preMatrix.translate(*pt);
    sink.m = &ctxI->metaMatrixFixed;
    sink.mType = ctxI->metaMatrixFixedType;
  }
  else {
    preMatrix.resetToTranslation(*pt);
    sink.m = &ctxI->finalMatrixFixed;
    sink.mType = ctxI->finalMatrixFixedType;
  }

  BLResult result = BL_SUCCESS;
  BLPath* tmpPath = &ctxI->workerCtx.tmpPath[3];
  tmpPath->clear();

  result = blFontGetGlyphRunOutlines(font, glyphRun, &preMatrix, tmpPath, [](BLPathCore* path, const void* info, void* closure_) noexcept -> BLResult {
    BL_UNUSED(info);

    BLRasterContextStrokeSink* sink = static_cast<BLRasterContextStrokeSink*>(closure_);
    BLRasterContextImpl* ctxI = sink->ctxI;

    BLPath* a = &ctxI->workerCtx.tmpPath[0];
    BLPath* b = &ctxI->workerCtx.tmpPath[1];
    BLPath* c = &ctxI->workerCtx.tmpPath[2];

    a->clear();
    BLResult localResult = blPathStrokeInternal(
      blDownCast(path)->view(),
      ctxI->currentState.strokeOptions,
      ctxI->currentState.approximationOptions,
      a, b, c,
      BLRasterContextStrokeSink::func, sink);

    // We must clear the input path as glyph outputes are appended to it and
    // we just consumed its content. If we haven't cleared it then next time
    // we would process the same outputs that we have already processed.
    blPathClear(path);
    return localResult;
  }, &sink);

  if (result == BL_SUCCESS)
    result = ctxI->workerCtx.edgeBuilder.done();

  if (BL_UNLIKELY(result != BL_SUCCESS)) {
    ctxI->workerCtx.edgeBuilder.mergeBoundingBox();
    ctxI->workerCtx.edgeStorage.clear();
    ctxI->workerCtx.workZone.clear();
    return result;
  }

  return blRasterContextImplFillClippedEdges(ctxI, &fillCmd);
}

static BLResult BL_CDECL blRasterContextImplStrokeGlyphRunI(BLContextImpl* baseImpl, const BLPointI* pt, const BLFontCore* font, const BLGlyphRun* glyphRun) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLPoint ptD(pt->x, pt->y);
  return blRasterContextImplStrokeGlyphRunD(ctxI, &ptD, font, glyphRun);
}

static BLResult BL_CDECL blRasterContextImplStrokeTextD(BLContextImpl* baseImpl, const BLPoint* pt, const BLFontCore* font, const void* text, size_t size, uint32_t encoding) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  if (blDownCast(font)->isNone())
    return blTraceError(BL_ERROR_NOT_INITIALIZED);

  BL_PROPAGATE(ctxI->glyphBuffer.setText(text, size, encoding));
  if (ctxI->glyphBuffer.empty())
    return BL_SUCCESS;

  BL_PROPAGATE(blDownCast(font)->shape(ctxI->glyphBuffer));
  return blRasterContextImplStrokeGlyphRunD(ctxI, pt, font, &ctxI->glyphBuffer.impl->glyphRun);
}

static BLResult BL_CDECL blRasterContextImplStrokeTextI(BLContextImpl* baseImpl, const BLPointI* pt, const BLFontCore* font, const void* text, size_t size, uint32_t encoding) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  BLPoint ptD(pt->x, pt->y);
  return blRasterContextImplStrokeTextD(ctxI, &ptD, font, text, size, encoding);
}

// ============================================================================
// [BLRasterContext - Blit Operations]
// ============================================================================

static BL_INLINE uint32_t blRasterContextImplPrepareBlit(BLRasterContextImpl* ctxI, BLRasterFillCmd* fillCmd, BLRasterFetchData* localFetchData, uint32_t alpha, uint32_t format) noexcept {
  BLCompOpSimplifyInfo simplifyInfo = ctxI->compOpSimplifyTable[format];

  uint32_t solidId = simplifyInfo.solidId();
  uint32_t contextFlags = ctxI->contextFlags | solidId;
  uint32_t nopFlags = BL_RASTER_CONTEXT_NO_BLIT_FLAGS;

  fillCmd->reset(simplifyInfo.signature(), alpha, BL_RASTER_CONTEXT_PREFERRED_FILL_RULE);
  fillCmd->setFetchDataFromLocal(localFetchData);

  // Likely case - composition flag doesn't lead to a solid fill and there are no
  // other 'NO_' flags so the rendering of this command should produce something.
  nopFlags &= contextFlags;
  if (nopFlags == 0)
    return BL_RASTER_CONTEXT_FILL_STATUS_FETCH;

  // Remove reserved flags we may have added to `nopFlags` if srcSolidId was
  // non-zero and add a possible condition flag to `nopFlags` if the composition
  // is NOP (DST-COPY).
  nopFlags &= ~BL_RASTER_CONTEXT_NO_RESERVED;
  nopFlags |= uint32_t(fillCmd->baseSignature == BLCompOpSimplifyInfo::dstCopy().signature());

  // Nothing to render as compOp, style, alpha, or something else is nop/invalid.
  if (nopFlags != 0)
    return BL_RASTER_CONTEXT_FILL_STATUS_NOP;

  // The combination of a destination format, source format, and compOp results
  // in a solid fill. The only thing we have to do is to copy the correct source
  // color to the `solidData`.
  fillCmd->solidData.prgb32 = blRasterContextSolidDataRgba32[solidId];
  fillCmd->fetchData = blFetchDataSolidSentinel();

  return BL_RASTER_CONTEXT_FILL_STATUS_SOLID;
}

static BLResult BL_CDECL blRasterContextImplBlitImageD(BLContextImpl* baseImpl, const BLPoint* pt, const BLImageCore* img, const BLRectI* imgArea) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  const BLImageImpl* imgI = img->impl;

  BLPoint dst(*pt);
  int srcX = 0;
  int srcY = 0;
  int srcW = imgI->size.w;
  int srcH = imgI->size.h;

  if (imgArea) {
    unsigned maxW = unsigned(srcW) - unsigned(imgArea->x);
    unsigned maxH = unsigned(srcH) - unsigned(imgArea->y);

    if ((maxW > unsigned(srcW)) | (unsigned(imgArea->w) > maxW) |
        (maxH > unsigned(srcH)) | (unsigned(imgArea->h) > maxH))
      return blTraceError(BL_ERROR_INVALID_VALUE);

    srcX = imgArea->x;
    srcY = imgArea->y;
    srcW = imgArea->w;
    srcH = imgArea->h;
  }

  BLRasterFillCmd fillCmd;
  BLRasterFetchData fetchData;
  uint32_t status = blRasterContextImplPrepareBlit(ctxI, &fillCmd, &fetchData, ctxI->globalAlphaI, imgI->format);

  if (status <= BL_RASTER_CONTEXT_FILL_STATUS_SOLID) {
    if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
      return BL_SUCCESS;

    BLBox finalBox(dst.x, dst.y, dst.x + double(srcW), dst.y + double(srcH));
    return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, finalBox);
  }
  else if (ctxI->finalMatrixType <= BL_MATRIX2D_TYPE_TRANSLATE) {
    double startX = dst.x * ctxI->finalMatrixFixed.m00 + ctxI->finalMatrixFixed.m20;
    double startY = dst.y * ctxI->finalMatrixFixed.m11 + ctxI->finalMatrixFixed.m21;

    double dx0 = blMax(startX, ctxI->finalClipBoxFixedD().x0);
    double dy0 = blMax(startY, ctxI->finalClipBoxFixedD().y0);
    double dx1 = blMin(startX + double(srcW) * ctxI->finalMatrixFixed.m00, ctxI->finalClipBoxFixedD().x1);
    double dy1 = blMin(startY + double(srcH) * ctxI->finalMatrixFixed.m11, ctxI->finalClipBoxFixedD().y1);

    // Clipped out, invalid coordinates, or empty `imgArea`.
    if (!((dx0 < dx1) & (dy0 < dy1)))
      return BL_SUCCESS;

    int64_t startFx = blFloorToInt64(startX);
    int64_t startFy = blFloorToInt64(startY);

    int ix0 = blTruncToInt(dx0);
    int iy0 = blTruncToInt(dy0);
    int ix1 = blTruncToInt(dx1);
    int iy1 = blTruncToInt(dy1);

    if (!((startFx | startFy) & ctxI->fpMaskI)) {
      // Pixel aligned blit. At this point we still don't know whether the area where
      // the pixels will be composited is aligned, but we for sure know that the pixels
      // of `src` image don't require any filtering.
      int x0 = ix0 >> ctxI->fpShiftI;
      int y0 = iy0 >> ctxI->fpShiftI;
      int x1 = (ix1 + ctxI->fpMaskI) >> ctxI->fpShiftI;
      int y1 = (iy1 + ctxI->fpMaskI) >> ctxI->fpShiftI;

      srcX += x0 - int(startFx >> ctxI->fpShiftI);
      srcY += y0 - int(startFy >> ctxI->fpShiftI);

      blRasterFetchDataInitPatternBlit(&fetchData, imgI, BLRectI(srcX, srcY, x1 - x0, y1 - y0));
      return blRasterContextImplFillClippedBoxAU(ctxI, &fillCmd, BLBoxI(ix0, iy0, ix1, iy1));
    }
    else {
      blRasterFetchDataInitPatternFxFy(&fetchData, imgI, BLRectI(srcX, srcY, srcW, srcH), BL_RASTER_CONTEXT_PREFERRED_BLIT_EXTEND, ctxI->currentState.hints.patternQuality, startFx, startFy);
      return blRasterContextImplFillClippedBoxAU(ctxI, &fillCmd, BLBoxI(ix0, iy0, ix1, iy1));
    }
  }
  else {
    BLMatrix2D m(ctxI->finalMatrix);
    m.translate(dst.x, dst.y);

    BLRectI srcRect(srcX, srcY, srcW, srcH);
    if (!blRasterFetchDataInitPatternAffine(&fetchData, imgI, srcRect, BL_RASTER_CONTEXT_PREFERRED_BLIT_EXTEND, ctxI->currentState.hints.patternQuality, m))
      return BL_SUCCESS;

    BLBox finalBox(dst.x, dst.y, dst.x + double(srcW), dst.y + double(srcH));
    return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, finalBox);
  }
}

static BLResult BL_CDECL blRasterContextImplBlitImageI(BLContextImpl* baseImpl, const BLPointI* pt, const BLImageCore* img, const BLRectI* imgArea) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (!(ctxI->contextFlags & BL_RASTER_CONTEXT_INTEGRAL_TRANSLATION)) {
    BLPoint ptD(pt->x, pt->y);
    return blRasterContextImplBlitImageD(ctxI, &ptD, img, imgArea);
  }

  const BLImageImpl* imgI = img->impl;

  int srcX = 0;
  int srcY = 0;
  int srcW = imgI->size.w;
  int srcH = imgI->size.h;

  if (imgArea) {
    unsigned maxW = unsigned(srcW) - unsigned(imgArea->x);
    unsigned maxH = unsigned(srcH) - unsigned(imgArea->y);

    if ( (maxW > unsigned(srcW)) | (unsigned(imgArea->w) > maxW) |
         (maxH > unsigned(srcH)) | (unsigned(imgArea->h) > maxH) )
      return blTraceError(BL_ERROR_INVALID_VALUE);

    srcX = imgArea->x;
    srcY = imgArea->y;
    srcW = imgArea->w;
    srcH = imgArea->h;
  }

  BLBoxI dstBox;
  BLRectI srcRect;

  if (BL_TARGET_ARCH_BITS < 64) {
    BLOverflowFlag of = 0;

    int dx = blAddOverflow(pt->x, ctxI->translationI.x, &of);
    int dy = blAddOverflow(pt->y, ctxI->translationI.y, &of);

    int x0 = dx;
    int y0 = dy;
    int x1 = blAddOverflow(x0, srcW, &of);
    int y1 = blAddOverflow(y0, srcH, &of);

    if (BL_UNLIKELY(of))
      goto Use64Bit;

    x0 = blMax(x0, ctxI->finalClipBoxI.x0);
    y0 = blMax(y0, ctxI->finalClipBoxI.y0);
    x1 = blMin(x1, ctxI->finalClipBoxI.x1);
    y1 = blMin(y1, ctxI->finalClipBoxI.y1);

    // Clipped out.
    if ((x0 >= x1) | (y0 >= y1))
      return BL_SUCCESS;

    srcX += x0 - dx;
    srcY += y0 - dy;
    dstBox.reset(x0, y0, x1, y1);
  }
  else {
Use64Bit:
    int64_t dx = int64_t(pt->x) + ctxI->translationI.x;
    int64_t dy = int64_t(pt->y) + ctxI->translationI.y;

    int64_t x0 = dx;
    int64_t y0 = dy;
    int64_t x1 = x0 + int64_t(unsigned(srcW));
    int64_t y1 = y0 + int64_t(unsigned(srcH));

    x0 = blMax<int64_t>(x0, ctxI->finalClipBoxI.x0);
    y0 = blMax<int64_t>(y0, ctxI->finalClipBoxI.y0);
    x1 = blMin<int64_t>(x1, ctxI->finalClipBoxI.x1);
    y1 = blMin<int64_t>(y1, ctxI->finalClipBoxI.y1);

    // Clipped out.
    if ((x0 >= x1) | (y0 >= y1))
      return BL_SUCCESS;

    srcX += int(x0 - dx);
    srcY += int(y0 - dy);
    dstBox.reset(int(x0), int(y0), int(x1), int(y1));
  }

  srcRect.reset(srcX, srcY, dstBox.x1 - dstBox.x0, dstBox.y1 - dstBox.y0);

  BLRasterFillCmd fillCmd;
  BLRasterFetchData fetchData;
  uint32_t status = blRasterContextImplPrepareBlit(ctxI, &fillCmd, &fetchData, ctxI->globalAlphaI, imgI->format);

  if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
    return BL_SUCCESS;

  blRasterFetchDataInitPatternBlit(&fetchData, imgI, srcRect);
  return blRasterContextImplFillClippedBoxAA(ctxI, &fillCmd, dstBox);
}

static BLResult BL_CDECL blRasterContextImplBlitScaledImageD(BLContextImpl* baseImpl, const BLRect* rect, const BLImageCore* img, const BLRectI* imgArea) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  const BLImageImpl* imgI = img->impl;

  int srcX = 0;
  int srcY = 0;
  int srcW = imgI->size.w;
  int srcH = imgI->size.h;

  if (imgArea) {
    unsigned maxW = unsigned(srcW) - unsigned(imgArea->x);
    unsigned maxH = unsigned(srcH) - unsigned(imgArea->y);

    if ((maxW > unsigned(srcW)) | (unsigned(imgArea->w) > maxW) |
        (maxH > unsigned(srcH)) | (unsigned(imgArea->h) > maxH) )
      return blTraceError(BL_ERROR_INVALID_VALUE);

    srcX = imgArea->x;
    srcY = imgArea->y;
    srcW = imgArea->w;
    srcH = imgArea->h;
  }

  BLBox finalBox(rect->x, rect->y, rect->x + rect->w, rect->y + rect->h);
  BLRasterFillCmd fillCmd;
  BLRasterFetchData fetchData;
  uint32_t status = blRasterContextImplPrepareBlit(ctxI, &fillCmd, &fetchData, ctxI->globalAlphaI, imgI->format);

  if (status <= BL_RASTER_CONTEXT_FILL_STATUS_SOLID) {
    if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
      return BL_SUCCESS;
    return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, finalBox);
  }
  else {
    BLMatrix2D m(rect->w / double(srcW), 0.0,
                 0.0, rect->h / double(srcH),
                 rect->x, rect->y);

    blMatrix2DMultiply(m, m, ctxI->finalMatrix);
    BLRectI srcRect(srcX, srcY, srcW, srcH);

    if (!blRasterFetchDataInitPatternAffine(&fetchData, imgI, srcRect, BL_RASTER_CONTEXT_PREFERRED_BLIT_EXTEND, ctxI->currentState.hints.patternQuality, m))
      return BL_SUCCESS;

    return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, finalBox);
  }
}

static BLResult BL_CDECL blRasterContextImplBlitScaledImageI(BLContextImpl* baseImpl, const BLRectI* rect, const BLImageCore* img, const BLRectI* imgArea) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);
  const BLImageImpl* imgI = img->impl;

  int srcX = 0;
  int srcY = 0;
  int srcW = imgI->size.w;
  int srcH = imgI->size.h;

  if (imgArea) {
    unsigned maxW = unsigned(srcW) - unsigned(imgArea->x);
    unsigned maxH = unsigned(srcH) - unsigned(imgArea->y);

    if ( (maxW > unsigned(srcW)) | (unsigned(imgArea->w) > maxW) |
         (maxH > unsigned(srcH)) | (unsigned(imgArea->h) > maxH) )
      return blTraceError(BL_ERROR_INVALID_VALUE);

    srcX = imgArea->x;
    srcY = imgArea->y;
    srcW = imgArea->w;
    srcH = imgArea->h;
  }

  BLRasterFillCmd fillCmd;
  BLRasterFetchData fetchData;
  uint32_t status = blRasterContextImplPrepareBlit(ctxI, &fillCmd, &fetchData, ctxI->globalAlphaI, imgI->format);

  BLBox finalBox(double(rect->x),
                 double(rect->y),
                 double(rect->x) + double(rect->w),
                 double(rect->y) + double(rect->h));

  if (status <= BL_RASTER_CONTEXT_FILL_STATUS_SOLID) {
    if (status == BL_RASTER_CONTEXT_FILL_STATUS_NOP)
      return BL_SUCCESS;
    return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, finalBox);
  }
  else {
    BLMatrix2D m(double(rect->w) / double(srcW), 0.0,
                 0.0, double(rect->h) / double(srcH),
                 double(rect->x), double(rect->y));

    blMatrix2DMultiply(m, m, ctxI->finalMatrix);
    BLRectI srcRect(srcX, srcY, srcW, srcH);

    if (!blRasterFetchDataInitPatternAffine(&fetchData, imgI, srcRect, BL_RASTER_CONTEXT_PREFERRED_BLIT_EXTEND, ctxI->currentState.hints.patternQuality, m))
      return BL_SUCCESS;

    return blRasterContextImplFillUnsafeBox(ctxI, &fillCmd, ctxI->finalMatrixFixed, ctxI->finalMatrixFixedType, finalBox);
  }
}

// ============================================================================
// [BLRasterContext - Attach / Detach]
// ============================================================================

static BLResult blRasterContextImplAttach(BLRasterContextImpl* ctxI, BLImageCore* image, const BLContextCreateInfo* options) noexcept {
  BL_ASSERT(image != nullptr);
  BL_ASSERT(options != nullptr);

  uint32_t format = image->impl->format;
  BLSizeI size = image->impl->size;

  uint32_t initFlags = options->flags;
  uint32_t threadCount = options->threadCount;

  // TODO: Hardcoded for 8-bit alpha.
  int fpShift = 8;
  int fpScaleI = 1 << fpShift;
  int fullAlphaI = fpScaleI - 1;
  double fpScaleD = double(fpScaleI);

  // Initialization.
  BLResult result = BL_SUCCESS;
  BLPipeRuntime* pipeRuntime = nullptr;

  BLZoneAllocator& zone = ctxI->baseZone;
  BLZoneAllocator::State zoneState;

  zone.saveState(&zoneState);
  do {
    // Step 1: Initialize Threads/WorkerContexts if multithreaded.
    result = ctxI->workerMgr.init(ctxI, initFlags, threadCount);
    if (result != BL_SUCCESS) break;

    // Step 2: Initialize pipeline runtime (JIT or fixed).
#if !defined(BL_BUILD_NO_JIT)
    pipeRuntime = &BLPipeGenRuntime::_global;

    if (initFlags & BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT) {
      // Create an isolated `BLPipeGenRuntime` if specified. It will be used
      // to store all functions generated during the rendering and will be
      // destroyed together with the context.
      BLPipeGenRuntime* isolatedRT = zone.newT<BLPipeGenRuntime>(BL_PIPE_RUNTIME_FLAG_ISOLATED);

      // This should not really happen as the first block is allocated with the impl.
      if (BL_UNLIKELY(!isolatedRT)) {
        result = blTraceError(BL_ERROR_OUT_OF_MEMORY);
        break;
      }

      if (initFlags & BL_CONTEXT_CREATE_FLAG_OVERRIDE_CPU_FEATURES) {
        isolatedRT->_restrictFeatures(options->cpuFeatures);
      }

      pipeRuntime = isolatedRT;
    }
#else
    pipeRuntime = &BLFixedPipeRuntime::_global;
#endif

    // Step 3: Initialize edge storage of the sync worker.
    result = ctxI->workerCtx.initEdgeStorage(uint32_t(size.h));
    if (result != BL_SUCCESS) break;

    // Step 4: Make the destination image mutable.
    result = blImageMakeMutable(image, &ctxI->workerCtx.dstData);
    if (result != BL_SUCCESS) break;
  } while (0);

  if (result != BL_SUCCESS) {
    // Initialization failure.
    ctxI->workerMgr.reset();

    // If we failed we don't want the pipeline runtime associated with the
    // context we so simply destroy it and pretend like nothing happened.
    if (pipeRuntime->runtimeFlags() & BL_PIPE_RUNTIME_FLAG_ISOLATED)
      pipeRuntime->destroy();

    zone.restoreState(&zoneState);
    return result;
  }
  else {
    // Increase `writerCount` of the image, will be decreased by `blRasterContextImplDetach()`.
    BLInternalImageImpl* imageI = blInternalCast(image->impl);
    blAtomicFetchAdd(&imageI->writerCount);

    // Initialize pipeline runtime.
    ctxI->pipeProvider.init(pipeRuntime);
    ctxI->pipeLookupCache.reset();

    // Initialize the rest of the sync worker.
    ctxI->workerCtx.initFullAlpha(uint32_t(fullAlphaI));
    ctxI->workerCtx.initContextDataByDstData();

    // Initialize destination image and worker.
    ctxI->targetSize.reset(size.w, size.h);
    ctxI->dstImage.impl = imageI;
    ctxI->dstInfo.format = uint8_t(format);
    ctxI->dstInfo.is16Bit = false;
    ctxI->dstInfo.fullAlphaI = uint32_t(fullAlphaI);
    ctxI->dstInfo.fullAlphaD = double(fullAlphaI);

    // Initialize members that are related to alpha and composition.
    ctxI->globalAlphaI = uint32_t(fullAlphaI);
    ctxI->solidFormatTable[BL_RASTER_CONTEXT_SOLID_FORMAT_ARGB] = uint8_t(BL_FORMAT_PRGB32);
    ctxI->solidFormatTable[BL_RASTER_CONTEXT_SOLID_FORMAT_FRGB] = uint8_t(BL_FORMAT_FRGB32);
    ctxI->solidFormatTable[BL_RASTER_CONTEXT_SOLID_FORMAT_ZERO] = uint8_t(BL_FORMAT_ZERO32);

    // Initialize members that are related to fixed point and scaling.
    ctxI->contextFlags = BL_RASTER_CONTEXT_INTEGRAL_TRANSLATION;
    ctxI->fpShiftI = fpShift;
    ctxI->fpScaleI = fpScaleI;
    ctxI->fpMaskI = fpScaleI - 1;
    ctxI->fpScaleD = fpScaleD;
    ctxI->fpMinSafeCoordD = blFloor(double(blMinValue<int32_t>() + 1) * fpScaleD);
    ctxI->fpMaxSafeCoordD = blFloor(double(blMaxValue<int32_t>() - 1 - blMax(size.w, size.h)) * fpScaleD);

    // Initialize the current rendering state.
    ctxI->currentState.compOp = uint8_t(BL_COMP_OP_SRC_OVER);
    ctxI->currentState.fillRule = uint8_t(BL_FILL_RULE_NON_ZERO);
    ctxI->currentState.styleType[BL_CONTEXT_OP_TYPE_FILL] = uint8_t(BL_STYLE_TYPE_SOLID);
    ctxI->currentState.styleType[BL_CONTEXT_OP_TYPE_STROKE] = uint8_t(BL_STYLE_TYPE_SOLID);
    ctxI->currentState.hints.reset();
    ctxI->currentState.hints.patternQuality = BL_PATTERN_QUALITY_BILINEAR;
    memset(ctxI->currentState.reserved, 0, sizeof(ctxI->currentState.reserved));
    ctxI->currentState.savedStateCount = 0;
    ctxI->currentState.approximationOptions = blMakeDefaultApproximationOptions();
    ctxI->currentState.globalAlpha = 1.0;
    ctxI->currentState.styleAlpha[0] = 1.0;
    ctxI->currentState.styleAlpha[1] = 1.0;
    blCallCtor(ctxI->currentState.strokeOptions);
    ctxI->currentState.metaMatrix.reset();
    ctxI->currentState.userMatrix.reset();
    ctxI->savedState = nullptr;
    ctxI->stateIdCounter = 0;

    blRasterContextImplCompOpChanged(ctxI);
    blRasterContextImplFlattenToleranceChanged(ctxI);
    blRasterContextImplOffsetParameterChanged(ctxI);

    // Initialize styles.
    blRasterContextInitStyleToDefault(ctxI->style[0], uint32_t(fullAlphaI));
    blRasterContextInitStyleToDefault(ctxI->style[1], uint32_t(fullAlphaI));

    // Initialize members that are related to transformation and clipping.
    ctxI->metaMatrixType = BL_MATRIX2D_TYPE_TRANSLATE;
    ctxI->finalMatrixType = BL_MATRIX2D_TYPE_TRANSLATE;
    ctxI->metaMatrixFixedType = BL_MATRIX2D_TYPE_SCALE;
    ctxI->finalMatrixFixedType = BL_MATRIX2D_TYPE_SCALE;

    ctxI->metaMatrixFixed.resetToScaling(fpScaleD);
    ctxI->finalMatrix.reset();
    ctxI->finalMatrixFixed.resetToScaling(fpScaleD);

    ctxI->metaClipBoxI.reset(0, 0, size.w, size.h);
    ctxI->translationI.reset(0, 0);
    blRasterContextImplResetClippingToMetaClipBox(ctxI);

    return BL_SUCCESS;
  }
}

static BLResult blRasterContextImplDetach(BLRasterContextImpl* ctxI) noexcept {
  // Release the ImageImpl.
  BLInternalImageImpl* imageI = blInternalCast(ctxI->dstImage.impl);
  BL_ASSERT(imageI != nullptr);

  // If the image was dereferenced during rendering it's our responsibility to
  // destroy it. This is not useful from consumer perspective as the resulting
  // image can never be used again, but it can happen in some cases (for example
  // when an asynchronous rendering is terminated and the target image released
  // with it).
  if (blAtomicFetchSub(&imageI->writerCount) == 1) {
    if (imageI->refCount == 0)
      blImageImplDelete(imageI);
  }
  ctxI->dstImage.impl = nullptr;

  // Release Threads/WorkerContexts used by asynchronous rendering.
  ctxI->workerMgr.reset();

  // Release PipeRuntime.
  if (ctxI->pipeProvider.runtime()->runtimeFlags() & BL_PIPE_RUNTIME_FLAG_ISOLATED)
    ctxI->pipeProvider.runtime()->destroy();
  ctxI->pipeProvider.reset();

  // Release all states.
  blRasterContextImplDiscardStates(ctxI, nullptr);
  blCallDtor(ctxI->currentState.strokeOptions);

  uint32_t contextFlags = ctxI->contextFlags;
  if (contextFlags & BL_RASTER_CONTEXT_FILL_FETCH_DATA)
    blRasterContextImplDestroyValidStyle(ctxI, &ctxI->style[BL_CONTEXT_OP_TYPE_FILL]);

  if (contextFlags & BL_RASTER_CONTEXT_STROKE_FETCH_DATA)
    blRasterContextImplDestroyValidStyle(ctxI, &ctxI->style[BL_CONTEXT_OP_TYPE_STROKE]);

  // Clear some other important members. We don't have to clear everything as
  // if we re-attach an image again all members will be overwritten anyway.
  ctxI->contextFlags = 0;
  ctxI->dstInfo.reset();

  ctxI->baseZone.clear();
  ctxI->cmdZone.clear();
  ctxI->fetchPool.reset();
  ctxI->statePool.reset();
  ctxI->workerCtx.dstData.reset();
  ctxI->workerCtx.ctxData.reset();
  ctxI->workerCtx.workZone.clear();

  return BL_SUCCESS;
}

// ============================================================================
// [BLRasterContext - Init / Destroy]
// ============================================================================

BLResult blRasterContextImplCreate(BLContextImpl** out, BLImageCore* image, const BLContextCreateInfo* options) noexcept {
  uint16_t memPoolData;
  BLRasterContextImpl* ctxI = blRuntimeAllocImplT<BLRasterContextImpl>(sizeof(BLRasterContextImpl), &memPoolData);

  if (BL_UNLIKELY(!ctxI))
    return blTraceError(BL_ERROR_OUT_OF_MEMORY);

  ctxI = new(ctxI) BLRasterContextImpl(&blRasterContextVirt, memPoolData);
  BLResult result = blRasterContextImplAttach(ctxI, image, options);

  if (result != BL_SUCCESS) {
    ctxI->virt->destroy(ctxI);
    return result;
  }

  *out = ctxI;
  return BL_SUCCESS;
}

static BLResult BL_CDECL blRasterContextImplDestroy(BLContextImpl* baseImpl) noexcept {
  BLRasterContextImpl* ctxI = static_cast<BLRasterContextImpl*>(baseImpl);

  if (ctxI->dstImage.impl)
    blRasterContextImplDetach(ctxI);

  uint32_t memPoolData = ctxI->memPoolData;
  ctxI->~BLRasterContextImpl();
  return blRuntimeFreeImpl(ctxI, sizeof(BLRasterContextImpl), memPoolData);
}

// ============================================================================
// [BLRasterContext - RtInit]
// ============================================================================

static void blRasterContextVirtInit(BLContextVirt* virt) noexcept {
  constexpr uint32_t F = BL_CONTEXT_OP_TYPE_FILL;
  constexpr uint32_t S = BL_CONTEXT_OP_TYPE_STROKE;

  virt->destroy                 = blRasterContextImplDestroy;
  virt->flush                   = blRasterContextImplFlush;

  virt->save                    = blRasterContextImplSave;
  virt->restore                 = blRasterContextImplRestore;

  virt->matrixOp                = blRasterContextImplMatrixOp;
  virt->userToMeta              = blRasterContextImplUserToMeta;

  virt->setHint                 = blRasterContextImplSetHint;
  virt->setHints                = blRasterContextImplSetHints;

  virt->setFlattenMode          = blRasterContextImplSetFlattenMode;
  virt->setFlattenTolerance     = blRasterContextImplSetFlattenTolerance;
  virt->setApproximationOptions = blRasterContextImplSetApproximationOptions;

  virt->setCompOp               = blRasterContextImplSetCompOp;
  virt->setGlobalAlpha          = blRasterContextImplSetGlobalAlpha;

  virt->setStyleAlpha[F]        = blRasterContextImplSetFillAlpha;
  virt->setStyleAlpha[S]        = blRasterContextImplSetStrokeAlpha;
  virt->getStyle[F]             = blRasterContextImplGetStyle<F>;
  virt->getStyle[S]             = blRasterContextImplGetStyle<S>;
  virt->getStyleRgba32[F]       = blRasterContextImplGetStyleRgba32<F>;
  virt->getStyleRgba32[S]       = blRasterContextImplGetStyleRgba32<S>;
  virt->getStyleRgba64[F]       = blRasterContextImplGetStyleRgba64<F>;
  virt->getStyleRgba64[S]       = blRasterContextImplGetStyleRgba64<S>;
  virt->setStyle[F]             = blRasterContextImplSetStyle<F>;
  virt->setStyle[S]             = blRasterContextImplSetStyle<S>;
  virt->setStyleRgba32[F]       = blRasterContextImplSetStyleRgba32<F>;
  virt->setStyleRgba32[S]       = blRasterContextImplSetStyleRgba32<S>;
  virt->setStyleRgba64[F]       = blRasterContextImplSetStyleRgba64<F>;
  virt->setStyleRgba64[S]       = blRasterContextImplSetStyleRgba64<S>;

  virt->setFillRule             = blRasterContextImplSetFillRule;

  virt->setStrokeWidth          = blRasterContextImplSetStrokeWidth;
  virt->setStrokeMiterLimit     = blRasterContextImplSetStrokeMiterLimit;
  virt->setStrokeCap            = blRasterContextImplSetStrokeCap;
  virt->setStrokeCaps           = blRasterContextImplSetStrokeCaps;
  virt->setStrokeJoin           = blRasterContextImplSetStrokeJoin;
  virt->setStrokeTransformOrder = blRasterContextImplSetStrokeTransformOrder;
  virt->setStrokeDashOffset     = blRasterContextImplSetStrokeDashOffset;
  virt->setStrokeDashArray      = blRasterContextImplSetStrokeDashArray;
  virt->setStrokeOptions        = blRasterContextImplSetStrokeOptions;

  virt->clipToRectI             = blRasterContextImplClipToRectI;
  virt->clipToRectD             = blRasterContextImplClipToRectD;
  virt->restoreClipping         = blRasterContextImplRestoreClipping;

  virt->clearAll                = blRasterContextImplClearAll;
  virt->clearRectI              = blRasterContextImplClearRectI;
  virt->clearRectD              = blRasterContextImplClearRectD;

  virt->fillAll                 = blRasterContextImplFillAll;
  virt->fillRectI               = blRasterContextImplFillRectI;
  virt->fillRectD               = blRasterContextImplFillRectD;
  virt->fillPathD               = blRasterContextImplFillPathD;
  virt->fillGeometry            = blRasterContextImplFillGeometry;
  virt->fillTextI               = blRasterContextImplFillTextI;
  virt->fillTextD               = blRasterContextImplFillTextD;
  virt->fillGlyphRunI           = blRasterContextImplFillGlyphRunI;
  virt->fillGlyphRunD           = blRasterContextImplFillGlyphRunD;

  virt->strokeRectI             = blRasterContextImplStrokeRectI;
  virt->strokeRectD             = blRasterContextImplStrokeRectD;
  virt->strokePathD             = blRasterContextImplStrokePathD;
  virt->strokeGeometry          = blRasterContextImplStrokeGeometry;
  virt->strokeTextI             = blRasterContextImplStrokeTextI;
  virt->strokeTextD             = blRasterContextImplStrokeTextD;
  virt->strokeGlyphRunI         = blRasterContextImplStrokeGlyphRunI;
  virt->strokeGlyphRunD         = blRasterContextImplStrokeGlyphRunD;

  virt->blitImageI              = blRasterContextImplBlitImageI;
  virt->blitImageD              = blRasterContextImplBlitImageD;
  virt->blitScaledImageI        = blRasterContextImplBlitScaledImageI;
  virt->blitScaledImageD        = blRasterContextImplBlitScaledImageD;
}

void blRasterContextRtInit(BLRuntimeContext* rt) noexcept {
  BL_UNUSED(rt);
  blRasterContextVirtInit(&blRasterContextVirt);
}
