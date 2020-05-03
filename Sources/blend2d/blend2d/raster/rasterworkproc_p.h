// Copyright (c) 2017-2020 The Blend2D Authors
//
// This software is provided 'as-is', without any express or implied
// warranty. In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software
//    in a product, an acknowledgment in the product documentation would be
//    appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#ifndef BLEND2D_RASTER_RASTERWORKPROC_P_H
#define BLEND2D_RASTER_RASTERWORKPROC_P_H

#include "../threading/thread_p.h"

//! \cond INTERNAL
//! \addtogroup blend2d_internal_raster
//! \{

BL_HIDDEN void blRasterWorkProc(BLRasterWorkData* workData) noexcept;

BL_HIDDEN void BL_CDECL blRasterWorkThreadEntry(BLThread* thread, void* data) noexcept;
BL_HIDDEN void BL_CDECL blRasterWorkThreadDone(BLThread* thread, void* data) noexcept;

//! \}
//! \endcond

#endif // BLEND2D_RASTER_RASTERWORKPROC_P_H