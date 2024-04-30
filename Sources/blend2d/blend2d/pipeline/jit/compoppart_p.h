// This file is part of Blend2D project <https://blend2d.com>
//
// See blend2d.h or LICENSE.md for license and copyright information
// SPDX-License-Identifier: Zlib

#ifndef BLEND2D_PIPELINE_JIT_COMPOPPART_P_H_INCLUDED
#define BLEND2D_PIPELINE_JIT_COMPOPPART_P_H_INCLUDED

#include "../../compopinfo_p.h"
#include "../../pipeline/jit/fetchpart_p.h"
#include "../../pipeline/jit/pipepart_p.h"
#include "../../support/wrap_p.h"

//! \cond INTERNAL
//! \addtogroup blend2d_pipeline_jit
//! \{

namespace bl {
namespace Pipeline {
namespace JIT {

//! Pipeline combine part.
class CompOpPart : public PipePart {
public:
  enum : uint32_t {
    kIndexDstPart = 0,
    kIndexSrcPart = 1
  };

  //! \name Members
  //! \{

  //! Composition operator.
  CompOpExt _compOp{};
  //! Pixel type of the composition.
  PixelType _pixelType = PixelType::kNone;
  //! The current span mode.
  CMaskLoopType _cMaskLoopType = CMaskLoopType::kNone;
  //! Maximum pixels the compositor can handle at a time.
  uint8_t _maxPixels = 0;
  //! Pixel granularity.
  PixelCount _pixelGranularity {};
  //! Minimum alignment required to process `_maxPixels`.
  Alignment _minAlignment {1};

  uint8_t _isInPartialMode : 1;
  //! Whether the destination format has an alpha component.
  uint8_t _hasDa : 1;
  //! Whether the source format has an alpha component.
  uint8_t _hasSa : 1;

  //! A hook that is used by the current loop.
  asmjit::BaseNode* _cMaskLoopHook = nullptr;
  //! Optimized solid pixel for operators that allow it.
  SolidPixel _solidOpt;
  //! Pre-processed solid pixel for TypeA operators that always use `vMaskProc?()`.
  Pixel _solidPre {};
  //! Partial fetch that happened at the end of the scanline (border case).
  Pixel _partialPixel {};
  //! Const mask.
  Wrap<PipeCMask> _mask;

  //! \}

  //! \name Construction & Destruction
  //! \{

  CompOpPart(PipeCompiler* pc, CompOpExt compOp, FetchPart* dstPart, FetchPart* srcPart) noexcept;

  //! \}

  //! \name Part Accessors
  //! \{

  BL_INLINE FetchPart* dstPart() const noexcept { return reinterpret_cast<FetchPart*>(_children[kIndexDstPart]); }
  BL_INLINE FetchPart* srcPart() const noexcept { return reinterpret_cast<FetchPart*>(_children[kIndexSrcPart]); }

  //! \}

  //! Returns the composition operator id, see `BLCompOp`.
  BL_INLINE CompOpExt compOp() const noexcept { return _compOp; }

  BL_INLINE bool isSrcCopy() const noexcept { return _compOp == CompOpExt::kSrcCopy; }
  BL_INLINE bool isSrcOver() const noexcept { return _compOp == CompOpExt::kSrcOver; }
  BL_INLINE bool isSrcIn() const noexcept { return _compOp == CompOpExt::kSrcIn; }
  BL_INLINE bool isSrcOut() const noexcept { return _compOp == CompOpExt::kSrcOut; }
  BL_INLINE bool isSrcAtop() const noexcept { return _compOp == CompOpExt::kSrcAtop; }
  BL_INLINE bool isDstCopy() const noexcept { return _compOp == CompOpExt::kDstCopy; }
  BL_INLINE bool isDstOver() const noexcept { return _compOp == CompOpExt::kDstOver; }
  BL_INLINE bool isDstIn() const noexcept { return _compOp == CompOpExt::kDstIn; }
  BL_INLINE bool isDstOut() const noexcept { return _compOp == CompOpExt::kDstOut; }
  BL_INLINE bool isDstAtop() const noexcept { return _compOp == CompOpExt::kDstAtop; }
  BL_INLINE bool isXor() const noexcept { return _compOp == CompOpExt::kXor; }
  BL_INLINE bool isPlus() const noexcept { return _compOp == CompOpExt::kPlus; }
  BL_INLINE bool isMinus() const noexcept { return _compOp == CompOpExt::kMinus; }
  BL_INLINE bool isModulate() const noexcept { return _compOp == CompOpExt::kModulate; }
  BL_INLINE bool isMultiply() const noexcept { return _compOp == CompOpExt::kMultiply; }
  BL_INLINE bool isScreen() const noexcept { return _compOp == CompOpExt::kScreen; }
  BL_INLINE bool isOverlay() const noexcept { return _compOp == CompOpExt::kOverlay; }
  BL_INLINE bool isDarken() const noexcept { return _compOp == CompOpExt::kDarken; }
  BL_INLINE bool isLighten() const noexcept { return _compOp == CompOpExt::kLighten; }
  BL_INLINE bool isColorDodge() const noexcept { return _compOp == CompOpExt::kColorDodge; }
  BL_INLINE bool isColorBurn() const noexcept { return _compOp == CompOpExt::kColorBurn; }
  BL_INLINE bool isLinearBurn() const noexcept { return _compOp == CompOpExt::kLinearBurn; }
  BL_INLINE bool isLinearLight() const noexcept { return _compOp == CompOpExt::kLinearLight; }
  BL_INLINE bool isPinLight() const noexcept { return _compOp == CompOpExt::kPinLight; }
  BL_INLINE bool isHardLight() const noexcept { return _compOp == CompOpExt::kHardLight; }
  BL_INLINE bool isSoftLight() const noexcept { return _compOp == CompOpExt::kSoftLight; }
  BL_INLINE bool isDifference() const noexcept { return _compOp == CompOpExt::kDifference; }
  BL_INLINE bool isExclusion() const noexcept { return _compOp == CompOpExt::kExclusion; }

  BL_INLINE bool isAlphaInv() const noexcept { return _compOp == CompOpExt::kAlphaInv; }

  //! Returns the composition operator flags, see `CompOpFlags`.
  BL_INLINE CompOpFlags compOpFlags() const noexcept { return compOpInfoTable[size_t(_compOp)].flags(); }

  //! Tests whether the destination pixel format has an alpha component.
  BL_INLINE bool hasDa() const noexcept { return _hasDa != 0; }
  //! Tests whether the source pixel format has an alpha component.
  BL_INLINE bool hasSa() const noexcept { return _hasSa != 0; }

  BL_INLINE PixelType pixelType() const noexcept { return _pixelType; }
  BL_INLINE bool isA8Pixel() const noexcept { return _pixelType == PixelType::kA8; }
  BL_INLINE bool isRGBA32Pixel() const noexcept { return _pixelType == PixelType::kRGBA32; }

  //! Returns the current loop mode.
  BL_INLINE CMaskLoopType cMaskLoopType() const noexcept { return _cMaskLoopType; }
  //! Tests whether the current loop is fully opaque (no mask).
  BL_INLINE bool isLoopOpaque() const noexcept { return _cMaskLoopType == CMaskLoopType::kOpaque; }
  //! Tests whether the current loop is `CMask` (constant mask).
  BL_INLINE bool isLoopCMask() const noexcept { return _cMaskLoopType == CMaskLoopType::kVariant; }

  //! Returns the maximum pixels the composite part can handle at a time.
  //!
  //! \note This value is configured in a way that it's always one if the fetch
  //! part doesn't support more. This makes it easy to use it in loop compilers.
  //! In other words, the value doesn't describe the real implementation of the
  //! composite part.
  BL_INLINE uint32_t maxPixels() const noexcept { return _maxPixels; }
  //! Returns the maximum pixels the children of this part can handle.
  BL_INLINE uint32_t maxPixelsOfChildren() const noexcept { return blMin(dstPart()->maxPixels(), srcPart()->maxPixels()); }

  BL_INLINE void setMaxPixels(uint32_t maxPixels) noexcept {
    BL_ASSERT(maxPixels <= 0xFF);
    _maxPixels = uint8_t(maxPixels);
  }

  //! Returns pixel granularity passed to `init()`, otherwise the result should be zero.
  BL_INLINE PixelCount pixelGranularity() const noexcept { return _pixelGranularity; }
  //! Returns the minimum destination alignment required to the maximum number of pixels `_maxPixels`.
  BL_INLINE Alignment minAlignment() const noexcept { return _minAlignment; }

  BL_INLINE bool isUsingSolidPre() const noexcept { return !_solidPre.pc.empty() || !_solidPre.uc.empty(); }

  void preparePart() noexcept override;

  void init(Gp& x, Gp& y, uint32_t pixelGranularity) noexcept;
  void fini() noexcept;

  //! Tests whether the opaque fill should be optimized and placed into a separate
  //! loop. This means that if this function returns true two composition loops
  //! would be generated by the filler.
  bool shouldOptimizeOpaqueFill() const noexcept;

  //! Tests whether the compositor should emit a specialized loop that contains
  //! an inlined version of `memcpy()` or `memset()`.
  bool shouldJustCopyOpaqueFill() const noexcept;

  void startAtX(const Gp& x) noexcept;
  void advanceX(const Gp& x, const Gp& diff) noexcept;
  void advanceY() noexcept;

  // These are just wrappers that call these on both source & destination parts.
  void prefetch1() noexcept;
  void enterN() noexcept;
  void leaveN() noexcept;
  void prefetchN() noexcept;
  void postfetchN() noexcept;

  void dstFetch(Pixel& p, PixelCount n, PixelFlags flags, PixelPredicate& predicate) noexcept;
  void srcFetch(Pixel& p, PixelCount n, PixelFlags flags, PixelPredicate& predicate) noexcept;

  BL_INLINE bool isInPartialMode() const noexcept { return _isInPartialMode != 0; }

  void enterPartialMode(PixelFlags partialFlags = PixelFlags::kNone) noexcept;
  void exitPartialMode() noexcept;
  void nextPartialPixel() noexcept;

  void cMaskInit(const Mem& mem) noexcept;
  void cMaskInit(const Gp& sm_, const Vec& vm_) noexcept;
  void cMaskInitOpaque() noexcept;
  void cMaskFini() noexcept;

  void _cMaskLoopInit(CMaskLoopType loopType) noexcept;
  void _cMaskLoopFini() noexcept;

  void cMaskGenericLoop(Gp& i) noexcept;
  void cMaskGenericLoopVec(Gp& i) noexcept;

  void cMaskGranularLoop(Gp& i) noexcept;
  void cMaskGranularLoopVec(Gp& i) noexcept;

  void cMaskMemcpyOrMemsetLoop(Gp& i) noexcept;

  void cMaskProcStoreAdvance(const Gp& dPtr, PixelCount n, Alignment alignment = Alignment(1)) noexcept;
  void cMaskProcStoreAdvance(const Gp& dPtr, PixelCount n, Alignment alignment, PixelPredicate& predicate) noexcept;

  void vMaskGenericLoop(Gp& i, const Gp& dPtr, const Gp& mPtr, GlobalAlpha& ga, const Label& done) noexcept;
  void vMaskGenericStep(const Gp& dPtr, PixelCount n, const Gp& mPtr, const Reg& ga) noexcept;

  void vMaskProcStoreAdvance(const Gp& dPtr, PixelCount n, VecArray& vm, bool vmImmutable, Alignment alignment = Alignment(1)) noexcept;
  void vMaskProcStoreAdvance(const Gp& dPtr, PixelCount n, VecArray& vm, bool vmImmutable, Alignment alignment, PixelPredicate& predicate) noexcept;

  void vMaskProc(Pixel& out, PixelFlags flags, Gp& msk, bool mImmutable) noexcept;

  void cMaskInitA8(const Gp& sm_, const Vec& vm_) noexcept;
  void cMaskFiniA8() noexcept;

  void cMaskProcA8Gp(Pixel& out, PixelFlags flags) noexcept;
  void vMaskProcA8Gp(Pixel& out, PixelFlags flags, Gp& msk, bool mImmutable) noexcept;

  void cMaskProcA8Vec(Pixel& out, PixelCount n, PixelFlags flags, PixelPredicate& predicate) noexcept;
  void vMaskProcA8Vec(Pixel& out, PixelCount n, PixelFlags flags, VecArray& vm, bool mImmutable, PixelPredicate& predicate) noexcept;

  void cMaskInitRGBA32(const Vec& vm) noexcept;
  void cMaskFiniRGBA32() noexcept;

  void cMaskProcRGBA32Vec(Pixel& out, PixelCount n, PixelFlags flags, PixelPredicate& predicate) noexcept;
  void vMaskProcRGBA32Vec(Pixel& out, PixelCount n, PixelFlags flags, VecArray& vm, bool mImmutable, PixelPredicate& predicate) noexcept;
  void vMaskProcRGBA32InvertMask(VecArray& vn, VecArray& vm) noexcept;
  void vMaskProcRGBA32InvertDone(VecArray& vn, bool mImmutable) noexcept;
};

} // {JIT}
} // {Pipeline}
} // {bl}

//! \}
//! \endcond

#endif // BLEND2D_PIPELINE_JIT_COMPOPPART_P_H_INCLUDED
