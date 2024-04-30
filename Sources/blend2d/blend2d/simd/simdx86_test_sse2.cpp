// This file is part of Blend2D project <https://blend2d.com>
//
// See blend2d.h or LICENSE.md for license and copyright information
// SPDX-License-Identifier: Zlib

#include "../api-build_test_p.h"
#if defined(BL_TEST) && defined(BL_TARGET_OPT_SSE2)

#include "../simd/simd_test_p.h"

// SIMD - Tests - X86 - SSE2
// =========================

namespace SIMDTests {

BL_HIDDEN void simd_test_x86_sse2() noexcept {
  const char ext[] = "SSE2";
  print_cost_matrix(ext);
  test_integer<16>(ext);
}

} // {SIMDTests}

#endif // BL_TEST && BL_TARGET_OPT_SSE2
