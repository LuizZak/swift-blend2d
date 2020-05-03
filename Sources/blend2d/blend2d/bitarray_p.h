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

#ifndef BLEND2D_BITARRAY_P_H
#define BLEND2D_BITARRAY_P_H

#include "./bitarray.h"
#include "./bitops_p.h"
#include "./support_p.h"

//! \cond INTERNAL
//! \addtogroup blend2d_internal
//! \{

// ============================================================================
// [BLFixedBitArray]
// ============================================================================

template<typename T, size_t N>
class BLFixedBitArray {
public:
  enum : size_t {
    kSizeOfTInBits = blBitSizeOf<T>(),
    kFixedArraySize = (N + kSizeOfTInBits - 1) / kSizeOfTInBits
  };

  BL_INLINE bool bitAt(size_t index) const noexcept {
    BL_ASSERT(index < N);
    return bool((data[index / kSizeOfTInBits] >> (index % kSizeOfTInBits)) & 0x1);
  }

  BL_INLINE void setAt(size_t index) noexcept {
    BL_ASSERT(index < N);
    data[index / kSizeOfTInBits] |= T(1) << (index % kSizeOfTInBits);
  }

  BL_INLINE void setAt(size_t index, bool value) noexcept {
    BL_ASSERT(index < N);

    T clrMask = T(1    ) << (index % kSizeOfTInBits);
    T setMask = T(value) << (index % kSizeOfTInBits);
    data[index / kSizeOfTInBits] = (data[index / kSizeOfTInBits] & ~clrMask) | setMask;
  }

  BL_INLINE void clearAt(size_t index) noexcept {
    BL_ASSERT(index < N);
    data[index / kSizeOfTInBits] &= ~(T(1) << (index % kSizeOfTInBits));
  }

  BL_INLINE void clearAll() noexcept {
    for (size_t i = 0; i < kFixedArraySize; i++)
      data[i] = 0;
  }

  BL_INLINE void setAll() noexcept {
    for (size_t i = 0; i < kFixedArraySize; i++)
      data[i] = blBitOnes<T>();
  }

  T data[kFixedArraySize];
};

//! \}
//! \endcond

#endif // BLEND2D_BITARRAY_P_H
