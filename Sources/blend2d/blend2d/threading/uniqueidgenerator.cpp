// [Blend2D]
// 2D Vector Graphics Powered by a JIT Compiler.
//
// [License]
// Zlib - See LICENSE.md file in the package.

#include "../api-build_p.h"
#include "../threading/mutex_p.h"
#include "../threading/uniqueidgenerator_p.h"

// ============================================================================
// [blGenerateUniqueId]
// ============================================================================

#if BL_TARGET_HAS_ATOMIC_64B
struct alignas(BL_CACHE_LINE_SIZE) BLUniqueIdGlobalState {
  std::atomic<uint64_t> index;

  BL_INLINE uint64_t fetchAdd(uint32_t n) noexcept {
    return index.fetch_add(uint64_t(n));
  }
};
#else
struct alignas(BL_CACHE_LINE_SIZE) BLUniqueIdGlobalState {
  std::atomic<uint32_t> _hi;
  std::atomic<uint32_t> _lo;

  BL_INLINE uint64_t fetchAdd(uint32_t n) noexcept {
    // This implementation doesn't always return an incrementing value as it's
    // not the point. The requirement is to never return the same value, so it
    // sacrifices one bit in `_lo` counter that would tell us to increment `_hi`
    // counter and try again.
    const uint32_t kThresholdLo32 = 0x80000000u;

    for (;;) {
      uint32_t hiValue = _hi.load();
      uint32_t loValue = _lo.fetch_add(n);

      // This MUST support even cases when the thread executing this function
      // right now is terminated. When we reach the threshold we increment
      // `_hi`, which would contain a new HIGH value that will be used
      // immediately, then we remove the threshold mark from LOW value and try
      // to get a new LOW and HIGH values to return.
      if (BL_UNLIKELY(loValue & kThresholdLo32)) {
        _hi++;

        // If the thread is interrupted here we only incremented the HIGH value.
        // In this case another thread that might call `next()` would end up
        // right here trying to clear `kThresholdLo32` from LOW value as well,
        // which is fine.
        _lo.fetch_and(uint32_t(~kThresholdLo32));
        continue;
      }

      return (uint64_t(hiValue) << 32) | loValue;
    }
  }
};
#endif

static BLUniqueIdGlobalState blUniqueIdGlobalState[BL_UNIQUE_ID_DOMAIN_COUNT];

#ifdef BL_NO_THREAD_LOCAL
BLUniqueId blGenerateUniqueId(uint32_t domain) noexcept {
  BL_ASSERT(domain < BL_UNIQUE_ID_DOMAIN_COUNT);

  return blUniqueIdGlobalState[domain].fetchAdd(1) + 1;
}
#else
static constexpr uint32_t BL_UNIQUE_ID_LOCAL_CACHE_COUNT = 256;
static thread_local uint64_t blUniqueIdLocalState[BL_UNIQUE_ID_DOMAIN_COUNT];

BLUniqueId blGenerateUniqueId(uint32_t domain) noexcept {
  BL_ASSERT(domain < BL_UNIQUE_ID_DOMAIN_COUNT);

  if ((blUniqueIdLocalState[domain] & (BL_UNIQUE_ID_LOCAL_CACHE_COUNT - 1)) == 0)
    blUniqueIdLocalState[domain] = blUniqueIdGlobalState[domain].fetchAdd(BL_UNIQUE_ID_LOCAL_CACHE_COUNT);

  return ++blUniqueIdLocalState[domain];
}
#endif
