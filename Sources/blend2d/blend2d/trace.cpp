// This file is part of Blend2D project <https://blend2d.com>
//
// See blend2d.h or LICENSE.md for license and copyright information
// SPDX-License-Identifier: Zlib

#include "api-build_p.h"
#include "runtime_p.h"
#include "trace_p.h"

// BLDebugTrace - Log
// ==================

void BLDebugTrace::log(uint32_t severity, uint32_t indentation, const char* fmt, ...) noexcept {
  const char* prefix = "";
  if (indentation < 0xFFFFFFFFu) {
    switch (severity) {
      case 1: prefix = "[WARN] "; break;
      case 2: prefix = "[FAIL] "; break;
    }
    blRuntimeMessageFmt("%*s%s", indentation * 2, "", prefix);
  }

  va_list ap;
  va_start(ap, fmt);
  blRuntimeMessageVFmt(fmt, ap);
  va_end(ap);
}
