// [Blend2D]
// 2D Vector Graphics Powered by a JIT Compiler.
//
// [License]
// Zlib - See LICENSE.md file in the package.

#include "./api-build_p.h"
#include "./filesystem.h"
#include "./font_p.h"
#include "./fontmanager_p.h"
#include "./runtime_p.h"
#include "./string_p.h"
#include "./support_p.h"

// ============================================================================
// [Global Variables]
// ============================================================================

static BLWrap<BLInternalFontManagerImpl> blNullFontManagerImpl;
static BLFontManagerVirt blFontManagerVirt;

// ============================================================================
// [Constants]
// ============================================================================

enum BLFontPrecedenceBits : uint32_t {
  BL_FONT_PRECEDENCE_STYLE_VALUE_SHIFT = 20,
  BL_FONT_PRECEDENCE_STYLE_SIGN_SHIFT = 19,
  BL_FONT_PRECEDENCE_WEIGHT_VALUE_SHIFT = 9,
  BL_FONT_PRECEDENCE_WEIGHT_SIGN_SHIFT = 8
};

// ============================================================================
// [BLFontManager - Impl]
// ============================================================================

static BLResult BL_CDECL blFontManagerImplDestroy(BLFontManagerImpl* impl_) noexcept {
  BLInternalFontManagerImpl* impl = static_cast<BLInternalFontManagerImpl*>(impl_);
  impl->~BLInternalFontManagerImpl();
  return blRuntimeFreeImpl(impl, sizeof(BLInternalFontManagerImpl), impl->memPoolData);
}

static BLFontManagerImpl* blFontManagerImplNew() noexcept {
  uint16_t memPoolData;
  void* p = blRuntimeAllocImpl(sizeof(BLInternalFontManagerImpl), &memPoolData);

  if (!p)
    return nullptr;

  return new(p) BLInternalFontManagerImpl(&blFontManagerVirt, memPoolData);
}

// ============================================================================
// [BLFontManager - Init / Destroy]
// ============================================================================

BLResult blFontManagerInit(BLFontManagerCore* self) noexcept {
  self->impl = &blNullFontManagerImpl;
  return BL_SUCCESS;
}

BLResult blFontManagerInitNew(BLFontManagerCore* self) noexcept {
  BLResult result = BL_SUCCESS;
  BLFontManagerImpl* impl = blFontManagerImplNew();

  if (BL_UNLIKELY(!impl)) {
    impl = &blNullFontManagerImpl;
    result = blTraceError(BL_ERROR_OUT_OF_MEMORY);
  }

  self->impl = impl;
  return result;
}

BLResult blFontManagerDestroy(BLFontManagerCore* self) noexcept {
  BLFontManagerImpl* selfI = self->impl;
  self->impl = nullptr;
  return blImplReleaseVirt(selfI);
}

// ============================================================================
// [BLFontManager - Reset]
// ============================================================================

BLResult blFontManagerReset(BLFontManagerCore* self) noexcept {
  BLFontManagerImpl* selfI = self->impl;
  self->impl = &blNullFontManagerImpl;
  return blImplReleaseVirt(selfI);
}

// ============================================================================
// [BLFontManager - Assign]
// ============================================================================

BLResult blFontManagerAssignMove(BLFontManagerCore* self, BLFontManagerCore* other) noexcept {
  BLFontManagerImpl* selfI = self->impl;
  BLFontManagerImpl* otherI = other->impl;

  self->impl = otherI;
  other->impl = &blNullFontManagerImpl;

  return blImplReleaseVirt(selfI);
}

BLResult blFontManagerAssignWeak(BLFontManagerCore* self, const BLFontManagerCore* other) noexcept {
  BLFontManagerImpl* selfI = self->impl;
  BLFontManagerImpl* otherI = other->impl;

  self->impl = blImplIncRef(otherI);
  return blImplReleaseVirt(selfI);
}

// ============================================================================
// [BLFontManager - Equals]
// ============================================================================

bool blFontManagerEquals(const BLFontManagerCore* a, const BLFontManagerCore* b) noexcept {
  return a->impl == b->impl;
}

// ============================================================================
// [BLFontManager - Create]
// ============================================================================

BLResult blFontManagerCreate(BLFontManagerCore* self) noexcept {
  BLFontManagerImpl* oldI = blInternalCast(self->impl);
  BLFontManagerImpl* newI = blFontManagerImplNew();

  if (BL_UNLIKELY(!newI))
    return blTraceError(BL_ERROR_OUT_OF_MEMORY);

  self->impl = newI;
  return blImplReleaseVirt(oldI);
}

// ============================================================================
// [BLFontManager - Accessors]
// ============================================================================

BLResult blFontManagerGetFaceCount(const BLFontManagerCore* self) noexcept {
  BLInternalFontManagerImpl* selfI = blInternalCast(self->impl);
  BLSharedLockGuard<BLSharedMutex> guard(selfI->mutex);

  return selfI->faceCount;
}

BLResult blFontManagerGetFamilyCount(const BLFontManagerCore* self) noexcept {
  BLInternalFontManagerImpl* selfI = blInternalCast(self->impl);
  BLSharedLockGuard<BLSharedMutex> guard(selfI->mutex);

  return selfI->familiesMap.size();
}

// ============================================================================
// [BLFontManager - Internal Utilities]
// ============================================================================

static BL_INLINE BLResult blFontManagerMakeMutable(BLFontManagerCore* self) noexcept {
  if (self->impl == &blNullFontManagerImpl)
    return blFontManagerCreate(self);
  return BL_SUCCESS;
}

// ============================================================================
// [BLFontManager - Face Management]
// ============================================================================

static BL_INLINE size_t blFontManagerIndexOfFace(const BLFontFace* array, size_t size, BLFontFaceImpl* faceI) noexcept {
  for (size_t i = 0; i < size; i++)
    if (array[i].impl == faceI)
      return i;
  return SIZE_MAX;
}

static BL_INLINE uint32_t blFontManagerCalcFaceOrder(const BLFontFaceImpl* faceI) noexcept {
  uint32_t style = faceI->style;
  uint32_t weight = faceI->weight;

  return (style << BL_FONT_PRECEDENCE_STYLE_VALUE_SHIFT) |
         (weight << BL_FONT_PRECEDENCE_WEIGHT_VALUE_SHIFT);
}

static BL_INLINE size_t blFontManagerIndexForInsertion(const BLFontFace* array, size_t size, BLFontFaceImpl* faceI) noexcept {
  uint32_t faceOrder = blFontManagerCalcFaceOrder(faceI);
  size_t i;

  for (i = 0; i < size; i++) {
    BLFontFaceImpl* storedFaceI = array[i].impl;
    uint32_t storedFaceOrder = blFontManagerCalcFaceOrder(storedFaceI);
    if (storedFaceOrder >= faceOrder) {
      if (storedFaceOrder == faceOrder)
        return SIZE_MAX;
      break;
    }
  }

  return i;
}

bool blFontManagerHasFace(const BLFontManagerCore* self, const BLFontFaceCore* face) noexcept {
  BLInternalFontManagerImpl* selfI = blInternalCast(self->impl);

  BLInternalFontFaceImpl* faceI = blInternalCast(face->impl);
  uint32_t nameHash = blHashString(faceI->familyName.view());

  BLSharedLockGuard<BLSharedMutex> guard(selfI->mutex);
  BLInternalFontManagerImpl::FamiliesMapNode* familiesNode =
    selfI->familiesMap.get(BLInternalFontManagerImpl::FamilyMatcher{faceI->familyName.view(), nameHash});

  if (!familiesNode)
    return false;

  size_t index = blFontManagerIndexOfFace(familiesNode->faces.data(), familiesNode->faces.size(), faceI);
  return index != SIZE_MAX;
}

BLResult blFontManagerAddFace(BLFontManagerCore* self, const BLFontFaceCore* face) noexcept {
  if (blDownCast(face)->isNone())
    return blTraceError(BL_ERROR_FONT_NOT_INITIALIZED);

  BL_PROPAGATE(blFontManagerMakeMutable(self));

  BLInternalFontFaceImpl* faceI = blInternalCast(face->impl);
  uint32_t nameHash = blHashString(faceI->familyName.view());

  BLInternalFontManagerImpl* selfI = blInternalCast(self->impl);
  BLLockGuard<BLSharedMutex> guard(selfI->mutex);

  BLZoneAllocator::StatePtr zoneState = selfI->zone.saveState();

  BLInternalFontManagerImpl::FamiliesMapNode* familiesNode =
    selfI->familiesMap.get(BLInternalFontManagerImpl::FamilyMatcher{faceI->familyName.view(), nameHash});

  if (!familiesNode) {
    familiesNode = selfI->zone.newT<BLInternalFontManagerImpl::FamiliesMapNode>(nameHash, faceI->familyName);
    if (!familiesNode)
      return blTraceError(BL_ERROR_OUT_OF_MEMORY);

    // Reserve for only one item at the beginning. This helps to decrease
    // memory footprint when loading a lot of font-faces that don't share
    // family names.
    BLResult result = familiesNode->faces.reserve(1u);
    if (BL_UNLIKELY(result != BL_SUCCESS)) {
      blCallDtor(*familiesNode);
      selfI->zone.restoreState(zoneState);
      return result;
    }

    familiesNode->faces.append(*blDownCast(face));
    selfI->familiesMap.insert(familiesNode);
  }
  else {
    size_t index = blFontManagerIndexForInsertion(familiesNode->faces.data(), familiesNode->faces.size(), faceI);
    if (index == SIZE_MAX)
      return BL_SUCCESS;
    BL_PROPAGATE(familiesNode->faces.insert(index, *blDownCast(face)));
  }

  return BL_SUCCESS;
}

// ============================================================================
// [BLFontManager - Prepared Query]
// ============================================================================

struct BLFontPreparedQuery {
  BLStringView _name;
  uint32_t _hashCode;

  typedef BLInternalFontManagerImpl::FamiliesMapNode FamiliesMapNode;

  BL_INLINE uint32_t hashCode() const noexcept { return _hashCode; }
  BL_INLINE bool matches(const FamiliesMapNode* node) const noexcept { return node->familyName.equals(_name); }
};

static bool blFontManagerPrepareQuery(const BLInternalFontManagerImpl* impl, const char* name, size_t nameSize, BLFontPreparedQuery* out) noexcept {
  BL_UNUSED(impl);

  if (nameSize == SIZE_MAX)
    nameSize = strlen(name);

  out->_name.reset(name, nameSize);
  out->_hashCode = blHashString(name, nameSize);
  return nameSize != 0;
}

// ============================================================================
// [BLFontManager - Best Match]
// ============================================================================

class BLFontQueryBestMatch {
public:
  const BLFontQueryProperties* properties;
  const BLFontFace* face;
  uint32_t diff;

  BL_INLINE BLFontQueryBestMatch(const BLFontQueryProperties* properties) noexcept
    : properties(properties),
      face(nullptr),
      diff(0xFFFFFFFFu) {}

  BL_INLINE bool hasFace() const noexcept { return face != nullptr; }

  BL_INLINE uint32_t calcDiff(const BLFontFace& faceIn) noexcept {
    uint32_t value = 0;
    const BLFontFaceImpl* faceImpl = faceIn.impl;

    uint32_t fStyle = faceImpl->style;
    uint32_t pStyle = properties->style;

    if (fStyle != pStyle) {
      uint32_t diff = uint32_t(blAbs(int(pStyle) - int(fStyle)));
      value |= diff << BL_FONT_PRECEDENCE_STYLE_VALUE_SHIFT;
      value |= uint32_t(pStyle < fStyle) << BL_FONT_PRECEDENCE_STYLE_SIGN_SHIFT;
    }

    uint32_t fWeight = faceImpl->weight;
    uint32_t pWeight = properties->weight;

    if (fWeight != pWeight) {
      uint32_t diff = uint32_t(blAbs(int(pWeight) - int(fWeight)));
      value |= diff << BL_FONT_PRECEDENCE_WEIGHT_VALUE_SHIFT;
      value |= uint32_t(pWeight < fWeight) << BL_FONT_PRECEDENCE_WEIGHT_SIGN_SHIFT;
    }

    return value;
  }

  void check(const BLFontFace& faceIn) noexcept {
    uint32_t localDiff = calcDiff(faceIn);
    if (diff > localDiff) {
      face = &faceIn;
      diff = localDiff;
    }
  }
};

// ============================================================================
// [BLFontManager - Query Utilities]
// ============================================================================

static const BLFontQueryProperties blFontFaceDefaultQueryProperties = {
  BL_FONT_STYLE_NORMAL,
  BL_FONT_WEIGHT_NORMAL
};

static bool blFontQueryCheckProperties(const BLFontQueryProperties& p) noexcept {
  return p.weight <= 1000 && p.style < BL_FONT_STYLE_COUNT;
}

// ============================================================================
// [BLFontManager - Query API]
// ============================================================================

BLResult blFontManagerQueryFacesByFamilyName(const BLFontManagerCore* self, const char* name, size_t nameSize, BLArrayCore* out) noexcept {
  if (BL_UNLIKELY(out->impl->implType != BL_IMPL_TYPE_ARRAY_VAR))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  BLInternalFontManagerImpl* selfI = blInternalCast(self->impl);
  BLSharedLockGuard<BLSharedMutex> guard(selfI->mutex);

  BLFontPreparedQuery query;
  if (blFontManagerPrepareQuery(selfI, name, nameSize, &query)) {
    BLInternalFontManagerImpl::FamiliesMapNode* familiesNode = selfI->familiesMap.get(query);
    if (familiesNode)
      return out->dcast<BLArray<BLFontFace>>().assign(familiesNode->faces);
  }

  // This is not considered to be an error, thus don't use blTraceError().
  out->dcast<BLArray<BLFontFace>>().clear();
  return BL_ERROR_FONT_NO_MATCH;
}

BLResult blFontManagerQueryFace(
  const BLFontManagerCore* self,
  const char* name, size_t nameSize,
  const BLFontQueryProperties* properties,
  BLFontFaceCore* out) noexcept {

  if (!properties)
    properties = &blFontFaceDefaultQueryProperties;

  if (!blFontQueryCheckProperties(*properties))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  BLInternalFontManagerImpl* selfI = blInternalCast(self->impl);
  BLSharedLockGuard<BLSharedMutex> guard(selfI->mutex);

  BLFontPreparedQuery query;
  BLFontQueryBestMatch bestMatch(properties);

  if (blFontManagerPrepareQuery(selfI, name, nameSize, &query)) {
    BLInternalFontManagerImpl::FamiliesMapNode* familiesNode = selfI->familiesMap.get(query);
    if (familiesNode) {
      for (const BLFontFace& face : familiesNode->faces.dcast<BLArray<BLFontFace>>())
        bestMatch.check(face);
    }
  }

  if (bestMatch.hasFace())
    return blDownCast(out)->assign(*bestMatch.face);

  // This is not considered to be an error, thus don't use blTraceError().
  blDownCast(out)->reset();
  return BL_ERROR_FONT_NO_MATCH;
}

BLResult blFontManagerQueryFont(
  const BLFontManagerCore* self,
  const char* name, size_t nameSize,
  const BLFontQueryProperties* properties,
  BLFontFaceCore* out) noexcept {

  if (!properties)
    properties = &blFontFaceDefaultQueryProperties;

  if (!blFontQueryCheckProperties(*properties))
    return blTraceError(BL_ERROR_INVALID_VALUE);

  BLInternalFontManagerImpl* selfI = blInternalCast(self->impl);
  BLSharedLockGuard<BLSharedMutex> guard(selfI->mutex);

  BLFontPreparedQuery query;
  BLFontQueryBestMatch bestMatch(properties);

  if (blFontManagerPrepareQuery(selfI, name, nameSize, &query)) {
    BLInternalFontManagerImpl::FamiliesMapNode* familiesNode = selfI->familiesMap.get(query);
    if (familiesNode) {
      for (const BLFontFace& face : familiesNode->faces.dcast<BLArray<BLFontFace>>())
        bestMatch.check(face);
    }
  }

  if (bestMatch.hasFace())
    return blDownCast(out)->assign(*bestMatch.face);

  // This is not considered to be an error, thus don't use blTraceError().
  blDownCast(out)->reset();
  return BL_ERROR_FONT_NO_MATCH;
}

// ============================================================================
// [BLFontManager - Runtime Init]
// ============================================================================

void blFontManagerRtInit(BLRuntimeContext* rt) noexcept {
  BL_UNUSED(rt);

  // Initialize BLFontManager virtual functions.
  blFontManagerVirt.destroy = blFontManagerImplDestroy;

  // Initialize BLFontManager built-in null instance.
  BLFontManagerImpl* fontManagerI = new (&blNullFontManagerImpl) BLInternalFontManagerImpl(&blFontManagerVirt, 0);
  blInitBuiltInNull(fontManagerI, BL_IMPL_TYPE_FONT_MANAGER, BL_IMPL_TRAIT_VIRT);
  blAssignBuiltInNull(fontManagerI);
}
