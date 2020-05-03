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

#include "./api-build_p.h"
#include "./scopedallocator_p.h"
#include "./support_p.h"

// ============================================================================
// [BLScopedAllocator]
// ============================================================================

void* BLScopedAllocator::alloc(size_t size, size_t alignment) noexcept {
  // First try to allocate from the local memory pool.
  uint8_t* p = blAlignUp(poolPtr, alignment);
  size_t remain = size_t(blUSubSaturate((uintptr_t)poolEnd, (uintptr_t)p));

  if (remain >= size) {
    poolPtr = p + size;
    return p;
  }

  // Bail to malloc if local pool was either not provided or didn't have the
  // required capacity.
  size_t sizeWithOverhead = size + sizeof(Link) + (alignment - 1);
  p = static_cast<uint8_t*>(malloc(sizeWithOverhead));

  if (p == nullptr)
    return nullptr;

  reinterpret_cast<Link*>(p)->next = links;
  links = reinterpret_cast<Link*>(p);

  return blAlignUp(p + sizeof(Link), alignment);
}

void BLScopedAllocator::reset() noexcept {
  Link* link = links;
  while (link) {
    Link* next = link->next;
    free(link);
    link = next;
  }

  links = nullptr;
  poolPtr = poolMem;
}
