// [Blend2D]
// 2D Vector Graphics Powered by a JIT Compiler.
//
// [License]
// Zlib - See LICENSE.md file in the package.

#ifndef BLEND2D_THREADING_UNIQUEIDGENERATOR_P_H
#define BLEND2D_THREADING_UNIQUEIDGENERATOR_P_H

#include "../threading/atomic_p.h"

//! \cond INTERNAL
//! \addtogroup blend2d_internal
//! \{

// ============================================================================
// [blGenerateUniqueId]
// ============================================================================

enum BLUniqueIdDomain : uint32_t {
  BL_UNIQUE_ID_DOMAIN_ANY = 0,
  BL_UNIQUE_ID_DOMAIN_CONTEXT = 1,
  BL_UNIQUE_ID_DOMAIN_COUNT
};

BL_HIDDEN BLUniqueId blGenerateUniqueId(uint32_t domain) noexcept;

//! \}
//! \endcond

#endif // BLEND2D_THREADING_UNIQUEIDGENERATOR_P_H
