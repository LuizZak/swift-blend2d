// This file is part of Blend2D project <https://blend2d.com>
//
// See blend2d.h or LICENSE.md for license and copyright information
// SPDX-License-Identifier: Zlib

#include "../../api-build_p.h"
#if defined(BL_JIT_ARCH_X86)

#include "../../pipeline/jit/fetchpixelptrpart_p.h"
#include "../../pipeline/jit/pipecompiler_p.h"

namespace bl {
namespace Pipeline {
namespace JIT {

// bl::Pipeline::JIT::FetchPixelPtrPart - Construction & Destruction
// =================================================================

FetchPixelPtrPart::FetchPixelPtrPart(PipeCompiler* pc, FetchType fetchType, FormatExt format) noexcept
  : FetchPart(pc, fetchType, format) {

  _partFlags |= PipePartFlags::kAdvanceXIsSimple;
  _maxSimdWidthSupported = SimdWidth::k512;
  _maxPixels = kUnlimitedMaxPixels;

  if (pc->hasMaskedAccessOf(bpp()))
    _partFlags |= PipePartFlags::kMaskedAccess;
}

// bl::Pipeline::JIT::FetchPixelPtrPart - Fetch
// ============================================

void FetchPixelPtrPart::fetch(Pixel& p, PixelCount n, PixelFlags flags, PixelPredicate& predicate) noexcept {
  pc->x_fetch_pixel(p, n, flags, format(), x86::ptr(_ptr), _alignment, predicate);
}

} // {JIT}
} // {Pipeline}
} // {bl}

#endif
