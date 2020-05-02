// [Blend2D]
// 2D Vector Graphics Powered by a JIT Compiler.
//
// [License]
// Zlib - See LICENSE.md file in the package.

#ifndef BLEND2D_FONTMANAGER_P_H
#define BLEND2D_FONTMANAGER_P_H

#include "./api-internal_p.h"
#include "./fontmanager.h"
#include "./zoneallocator_p.h"
#include "./zonehash_p.h"
#include "./threading/mutex_p.h"

//! \cond INTERNAL
//! \addtogroup blend2d_internal
//! \{

// ============================================================================
// [BLFontManager - Internal]
// ============================================================================

class BLInternalFontManagerImpl : public BLFontManagerImpl {
public:
  BL_NONCOPYABLE(BLInternalFontManagerImpl)

  class FamiliesMapNode : public BLZoneHashNode {
  public:
    BL_NONCOPYABLE(FamiliesMapNode)

    BLString familyName;
    BLArray<BLFontFace> faces;

    BL_INLINE FamiliesMapNode(uint32_t hashCode, const BLString& familyName) noexcept
      : BLZoneHashNode(hashCode),
        familyName(familyName),
        faces() {}
    BL_INLINE ~FamiliesMapNode() noexcept {}
  };

  struct FamilyMatcher {
    BLStringView _family;
    uint32_t _hashCode;

    BL_INLINE uint32_t hashCode() const noexcept { return _hashCode; }
    BL_INLINE bool matches(const FamiliesMapNode* node) const noexcept { return node->familyName.equals(_family); }
  };

  class SubstitutionMapNode : public BLZoneHashNode {
  public:
    BL_NONCOPYABLE(SubstitutionMapNode)

    BLString from;
    BLString to;

    BL_INLINE SubstitutionMapNode(uint32_t hashCode, const BLString& from, const BLString& to) noexcept
      : BLZoneHashNode(hashCode),
        from(from),
        to(to) {}
    BL_INLINE ~SubstitutionMapNode() noexcept {}
  };

  BLSharedMutex mutex;
  BLZoneAllocator zone;
  BLZoneHashMap<FamiliesMapNode> familiesMap;
  BLZoneHashMap<SubstitutionMapNode> substitutionMap;
  size_t faceCount;

  BL_INLINE BLInternalFontManagerImpl(const BLFontManagerVirt* virt_, uint16_t memPoolData_) noexcept
    : mutex(),
      zone(8192 - BLZoneAllocator::kBlockOverhead),
      familiesMap(),
      substitutionMap() {
    virt = virt_;
    refCount = 1;
    implType = uint8_t(BL_IMPL_TYPE_FONT_MANAGER);
    implTraits = uint8_t(BL_IMPL_TRAIT_MUTABLE | BL_IMPL_TRAIT_VIRT);
    memPoolData = memPoolData_;
    memset(reserved, 0, sizeof(reserved));
    faceCount = 0;
  }

  BL_INLINE ~BLInternalFontManagerImpl() noexcept {}
};

template<>
struct BLInternalCastImpl<BLFontManagerImpl> { typedef BLInternalFontManagerImpl Type; };

//! \}
//! \endcond

#endif // BLEND2D_FONTMANAGER_P_H
