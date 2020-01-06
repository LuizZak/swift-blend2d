// [Blend2D]
// 2D Vector Graphics Powered by a JIT Compiler.
//
// [License]
// Zlib - See LICENSE.md file in the package.

#include "./api-build_p.h"
#include "./array_p.h"
#include "./font_p.h"
#include "./glyphbuffer_p.h"
#include "./runtime_p.h"
#include "./string_p.h"
#include "./support_p.h"
#include "./unicode_p.h"

// ============================================================================
// [BLGlyphBuffer - Internals]
// ============================================================================

static const constexpr BLInternalGlyphBufferImpl blGlyphBufferInternalImplNone {};

template<typename T>
static BL_INLINE size_t strlenT(const T* str) noexcept {
  const T* p = str;
  while (*p)
    p++;
  return (size_t)(p - str);
}

static BL_INLINE BLResult blGlyphBufferEnsureData(BLGlyphBufferCore* self, BLInternalGlyphBufferImpl** impl) noexcept {
  *impl = blInternalCast(self->impl);
  if (*impl != &blGlyphBufferInternalImplNone)
    return BL_SUCCESS;

  *impl = BLInternalGlyphBufferImpl::create();
  if (BL_UNLIKELY(!*impl))
    return blTraceError(BL_ERROR_OUT_OF_MEMORY);

  self->impl = *impl;
  return BL_SUCCESS;
}

// ============================================================================
// [BLGlyphBuffer - Private API]
// ============================================================================

BLResult BLInternalGlyphBufferImpl::ensureBuffer(size_t bufferId, size_t copySize, size_t minCapacity) noexcept {
  size_t oldCapacity = capacity[bufferId];
  BL_ASSERT(copySize <= oldCapacity);

  if (minCapacity <= oldCapacity)
    return BL_SUCCESS;

  size_t newCapacity = minCapacity;
  if (newCapacity < BL_GLYPH_BUFFER_INITIAL_CAPACITY)
    newCapacity = BL_GLYPH_BUFFER_INITIAL_CAPACITY;
  else if (newCapacity < SIZE_MAX - 256)
    newCapacity = blAlignUp(minCapacity, 64);

  BLOverflowFlag of = 0;
  size_t dataSize = blMulOverflow<size_t>(newCapacity, BL_GLYPH_BUFFER_ANY_ITEM_SIZE, &of);

  if (BL_UNLIKELY(of))
    return BL_ERROR_OUT_OF_MEMORY;

  uint8_t* newData = static_cast<uint8_t*>(malloc(dataSize));
  if (BL_UNLIKELY(!newData))
    return BL_ERROR_OUT_OF_MEMORY;

  uint8_t* oldData = static_cast<uint8_t*>(buffer[bufferId]);
  if (copySize) {
    memcpy(newData,
           oldData,
           copySize * sizeof(uint32_t));

    memcpy(newData + newCapacity * sizeof(uint32_t),
           oldData + oldCapacity * sizeof(uint32_t),
           copySize * sizeof(BLGlyphInfo));
  }

  free(oldData);
  buffer[bufferId] = newData;
  capacity[bufferId] = newCapacity;

  if (bufferId == 0)
    getGlyphDataPtrs(0, &content, &infoData);

  return BL_SUCCESS;
}

static BL_INLINE BLGlyphInfo blGlyphInfoFromCluster(uint32_t cluster) noexcept {
  return BLGlyphInfo { cluster, { 0, 0 } };
}

template<typename T>
static BL_INLINE BLResult blInternalGlyphBufferData_setGlyphIds(BLInternalGlyphBufferImpl* d, const T* inData, intptr_t inAdvance, size_t size) noexcept {
  uint32_t* glyphData = d->content;
  BLGlyphInfo* infoData = d->infoData;

  for (size_t i = 0; i < size; i++) {
    glyphData[i] = uint32_t(inData[0]);
    infoData[i] = blGlyphInfoFromCluster(i);
    inData = blOffsetPtr(inData, inAdvance);
  }

  d->size = size;
  d->flags = 0;
  return BL_SUCCESS;
}

static BL_INLINE BLResult blInternalGlyphBufferData_setLatin1Text(BLInternalGlyphBufferImpl* d, const char* input, size_t size) noexcept {
  uint32_t* textData = d->content;
  BLGlyphInfo* infoData = d->infoData;

  for (size_t i = 0; i < size; i++) {
    textData[i] = uint8_t(input[i]);
    infoData[i] = blGlyphInfoFromCluster(i);
  }

  d->size = size;
  d->flags = 0;

  if (d->size)
    d->flags |= BL_GLYPH_RUN_FLAG_UCS4_CONTENT;

  return BL_SUCCESS;
}

template<typename Reader, typename CharType>
static BL_INLINE BLResult blInternalGlyphBufferData_setUnicodeText(BLInternalGlyphBufferImpl* d, const CharType* input, size_t size) noexcept {
  Reader reader(input, size);

  uint32_t* textData = d->content;
  BLGlyphInfo* infoData = d->infoData;

  while (reader.hasNext()) {
    uint32_t uc;
    uint32_t cluster = uint32_t(reader.nativeIndex(input));
    BLResult result = reader.next(uc);

    *textData++ = uc;
    *infoData++ = blGlyphInfoFromCluster(cluster);

    if (BL_LIKELY(result == BL_SUCCESS))
      continue;

    textData[-1] = BL_CHAR_REPLACEMENT;
    d->flags |= BL_GLYPH_RUN_FLAG_INVALID_TEXT;
    reader.skipOneUnit();
  }

  d->size = (size_t)(textData - d->content);
  d->flags = BL_GLYPH_RUN_FLAG_UCS4_CONTENT;

  if (d->size)
    d->flags |= BL_GLYPH_RUN_FLAG_UCS4_CONTENT;

  return BL_SUCCESS;
}

// ============================================================================
// [BLGlyphBuffer - Init / Reset]
// ============================================================================

BLResult blGlyphBufferInit(BLGlyphBufferCore* self) noexcept {
  self->impl = const_cast<BLInternalGlyphBufferImpl*>(&blGlyphBufferInternalImplNone);
  return BL_SUCCESS;
}

BLResult blGlyphBufferInitMove(BLGlyphBufferCore* self, BLGlyphBufferCore* other) noexcept {
  BLInternalGlyphBufferImpl* impl = blInternalCast(self->impl);
  other->impl = const_cast<BLInternalGlyphBufferImpl*>(&blGlyphBufferInternalImplNone);
  self->impl = impl;
  return BL_SUCCESS;
}

BLResult blGlyphBufferReset(BLGlyphBufferCore* self) noexcept {
  BLInternalGlyphBufferImpl* impl = blInternalCast(self->impl);
  if (impl == &blGlyphBufferInternalImplNone)
    return BL_SUCCESS;

  impl->destroy();
  self->impl = const_cast<BLInternalGlyphBufferImpl*>(&blGlyphBufferInternalImplNone);
  return BL_SUCCESS;
}

// ============================================================================
// [BLGlyphBuffer - Content]
// ============================================================================

BLResult blGlyphBufferClear(BLGlyphBufferCore* self) noexcept {
  BLInternalGlyphBufferImpl* selfI = blInternalCast(self->impl);

  // Would be true if the glyph-buffer is built-in 'none' instance or the data
  // is allocated, but empty.
  if (selfI->size == 0)
    return BL_SUCCESS;

  selfI->clear();
  return BL_SUCCESS;
}

size_t blGlyphBufferGetSize(const BLGlyphBufferCore* self) noexcept {
  BLInternalGlyphBufferImpl* selfI = blInternalCast(self->impl);
  return selfI->size;
}

uint32_t blGlyphBufferGetFlags(const BLGlyphBufferCore* self) noexcept {
  BLInternalGlyphBufferImpl* selfI = blInternalCast(self->impl);
  return selfI->flags;
}

const BLGlyphRun* blGlyphBufferGetGlyphRun(const BLGlyphBufferCore* self) noexcept {
  BLInternalGlyphBufferImpl* selfI = blInternalCast(self->impl);
  return &selfI->glyphRun;
}

const uint32_t* blGlyphBufferGetContent(const BLGlyphBufferCore* self) noexcept {
  BLInternalGlyphBufferImpl* selfI = blInternalCast(self->impl);
  return selfI->content;
}

const BLGlyphInfo* blGlyphBufferGetInfoData(const BLGlyphBufferCore* self) noexcept {
  BLInternalGlyphBufferImpl* selfI = blInternalCast(self->impl);
  return selfI->infoData;
}

const BLGlyphPlacement* blGlyphBufferGetPlacementData(const BLGlyphBufferCore* self) noexcept {
  BLInternalGlyphBufferImpl* selfI = blInternalCast(self->impl);
  return selfI->placementData;
}

BLResult blGlyphBufferSetText(BLGlyphBufferCore* self, const void* text, size_t size, uint32_t encoding) noexcept {
  if (BL_UNLIKELY(encoding >= BL_TEXT_ENCODING_COUNT))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  BLInternalGlyphBufferImpl* d;
  BL_PROPAGATE(blGlyphBufferEnsureData(self, &d));

  switch (encoding) {
    case BL_TEXT_ENCODING_LATIN1:
      if (size == SIZE_MAX)
        size = strlen(static_cast<const char*>(text));

      BL_PROPAGATE(d->ensureBuffer(0, 0, size));
      return blInternalGlyphBufferData_setLatin1Text(d, static_cast<const char*>(text), size);

    case BL_TEXT_ENCODING_UTF8:
      if (size == SIZE_MAX)
        size = strlen(static_cast<const char*>(text));

      BL_PROPAGATE(d->ensureBuffer(0, 0, size));
      return blInternalGlyphBufferData_setUnicodeText<BLUtf8Reader>(d, static_cast<const uint8_t*>(text), size);

    case BL_TEXT_ENCODING_UTF16:
      if (size == SIZE_MAX)
        size = strlenT(static_cast<const uint16_t*>(text));

      BL_PROPAGATE(d->ensureBuffer(0, 0, size));
      return blInternalGlyphBufferData_setUnicodeText<BLUtf16Reader>(d, static_cast<const uint16_t*>(text), size * 2u);

    case BL_TEXT_ENCODING_UTF32:
      if (size == SIZE_MAX)
        size = strlenT(static_cast<const uint32_t*>(text));

      BL_PROPAGATE(d->ensureBuffer(0, 0, size));
      return blInternalGlyphBufferData_setUnicodeText<BLUtf32Reader>(d, static_cast<const uint32_t*>(text), size * 4u);

    default:
      // Avoids a compile-time warning, should never be reached.
      return blTraceError(BL_ERROR_INVALID_VALUE);
  }
}

BLResult blGlyphBufferSetGlyphIds(BLGlyphBufferCore* self, const void* glyphData, intptr_t glyphAdvance, size_t size) noexcept {
  BLInternalGlyphBufferImpl* d;

  BL_PROPAGATE(blGlyphBufferEnsureData(self, &d));
  BL_PROPAGATE(d->ensureBuffer(0, 0, size));

  return blInternalGlyphBufferData_setGlyphIds(d, static_cast<const uint16_t*>(glyphData), glyphAdvance, size);
}
