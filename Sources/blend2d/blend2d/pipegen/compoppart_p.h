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

#ifndef BLEND2D_PIPEGEN_COMPOPPART_P_H
#define BLEND2D_PIPEGEN_COMPOPPART_P_H

#include "../pipegen/fetchpart_p.h"
#include "../pipegen/pipepart_p.h"

//! \cond INTERNAL
//! \addtogroup blend2d_internal_pipegen
//! \{

namespace BLPipeGen {

// ============================================================================
// [BLPipeGen::CompOpPart]
// ============================================================================

//! Pipeline combine part.
class CompOpPart : public PipePart {
public:
  BL_NONCOPYABLE(CompOpPart)

  enum : uint32_t {
    kIndexDstPart = 0,
    kIndexSrcPart = 1
  };

  //! Composition operator.
  uint32_t _compOp;
  //! Pixel type of the composition, see `Pixel::Type`.
  uint8_t _pixelType;
  //! The current span mode.
  uint8_t _cMaskLoopType;
  //! Maximum pixels the compositor can handle at a time.
  uint8_t _maxPixels;
  //! Pixel granularity.
  uint8_t _pixelGranularity;
  //! Minimum alignment required to process `_maxPixels`.
  uint8_t _minAlignment;

  uint8_t _isInPartialMode : 1;
  //! Whether the destination format has an alpha component.
  uint8_t _hasDa : 1;
  //! Whether the source format has an alpha component.
  uint8_t _hasSa : 1;

  //! A hook that is used by the current loop.
  asmjit::BaseNode* _cMaskLoopHook;
  //! Optimized solid pixel for operators that allow it.
  SolidPixel _solidOpt;
  //! Pre-processed solid pixel for TypeA operators that always use `vMaskProc?()`.
  Pixel _solidPre;
  //! Partial fetch that happened at the end of the scanline (border case).
  Pixel _partialPixel;
  //! Const mask.
  BLWrap<PipeCMask> _mask;

  CompOpPart(PipeCompiler* pc, uint32_t compOp, FetchPart* dstPart, FetchPart* srcPart) noexcept;

  BL_INLINE FetchPart* dstPart() const noexcept { return reinterpret_cast<FetchPart*>(_children[kIndexDstPart]); }
  BL_INLINE FetchPart* srcPart() const noexcept { return reinterpret_cast<FetchPart*>(_children[kIndexSrcPart]); }

  //! Returns the composition operator id, see `BLCompOp`.
  BL_INLINE uint32_t compOp() const noexcept { return _compOp; }
  //! Returns the composition operator flags, see `BLCompOpFlags`.
  BL_INLINE uint32_t compOpFlags() const noexcept { return blCompOpInfo[_compOp].flags; }

  //! Tests whether the destination pixel format has an alpha component.
  BL_INLINE bool hasDa() const noexcept { return _hasDa != 0; }
  //! Tests whether the source pixel format has an alpha component.
  BL_INLINE bool hasSa() const noexcept { return _hasSa != 0; }

  BL_INLINE uint32_t pixelType() const noexcept { return _pixelType; }
  BL_INLINE bool isAlphaType() const noexcept { return _pixelType == Pixel::kTypeAlpha; }
  BL_INLINE bool isRGBAType() const noexcept { return _pixelType == Pixel::kTypeRGBA; }

  //! Returns the current loop mode.
  BL_INLINE uint32_t cMaskLoopType() const noexcept { return _cMaskLoopType; }
  //! Tests whether the current loop is fully opaque (no mask).
  BL_INLINE bool isLoopOpaque() const noexcept { return _cMaskLoopType == kCMaskLoopTypeOpaque; }
  //! Tests whether the current loop is `CMask` (constant mask).
  BL_INLINE bool isLoopCMask() const noexcept { return _cMaskLoopType == kCMaskLoopTypeMask; }

  //! Returns the maximum pixels the composite part can handle at a time.
  //!
  //! \note This value is configured in a way that it's always one if the fetch
  //! part doesn't support more. This makes it easy to use it in loop compilers.
  //! In other words, the value doesn't describe the real implementation of the
  //! composite part.
  BL_INLINE uint32_t maxPixels() const noexcept { return _maxPixels; }
  //! Returns the maximum pixels the children of this part can handle.
  BL_INLINE uint32_t maxPixelsOfChildren() const noexcept { return blMin(dstPart()->maxPixels(), srcPart()->maxPixels()); }

  //! Returns pixel granularity passed to `init()`, otherwise the result should be zero.
  BL_INLINE uint32_t pixelGranularity() const noexcept { return _pixelGranularity; }
  //! Returns the minimum destination alignment required to the maximum number of pixels `_maxPixels`.
  BL_INLINE uint32_t minAlignment() const noexcept { return _minAlignment; }

  BL_INLINE bool isUsingSolidPre() const noexcept { return !_solidPre.pc.empty() || !_solidPre.uc.empty(); }

  void init(x86::Gp& x, x86::Gp& y, uint32_t pixelGranularity) noexcept;
  void fini() noexcept;

  //! Tests whether the opaque fill should be optimized and placed into a separate
  //! loop. This means that if this function returns true two composition loops
  //! would be generated by the filler.
  bool shouldOptimizeOpaqueFill() const noexcept;

  //! Tests whether the compositor should emit a specialized loop that contains
  //! an inlined version of `memcpy()` or `memset()`.
  bool shouldJustCopyOpaqueFill() const noexcept;

  void startAtX(x86::Gp& x) noexcept;
  void advanceX(x86::Gp& x, x86::Gp& diff) noexcept;
  void advanceY() noexcept;

  // These are just wrappers that call these on both source & destination parts.
  void prefetch1() noexcept;
  void enterN() noexcept;
  void leaveN() noexcept;
  void prefetchN() noexcept;
  void postfetchN() noexcept;

  void dstFetch(Pixel& p, uint32_t flags, uint32_t n) noexcept;
  void srcFetch(Pixel& p, uint32_t flags, uint32_t n) noexcept;

  BL_INLINE bool isInPartialMode() const noexcept {
    return _isInPartialMode != 0;
  }

  void enterPartialMode(uint32_t partialFlags = 0) noexcept;
  void exitPartialMode() noexcept;
  void nextPartialPixel() noexcept;

  void cMaskInit(const x86::Mem& mem) noexcept;
  void cMaskInit(const x86::Gp& sm_, const x86::Vec& vm_) noexcept;
  void cMaskInitOpaque() noexcept;
  void cMaskFini() noexcept;

  void _cMaskLoopInit(uint32_t loopType) noexcept;
  void _cMaskLoopFini() noexcept;

  void cMaskGenericLoop(x86::Gp& i) noexcept;
  void cMaskGenericLoopXmm(x86::Gp& i) noexcept;

  void cMaskGranularLoop(x86::Gp& i) noexcept;
  void cMaskGranularLoopXmm(x86::Gp& i) noexcept;

  void cMaskMemcpyOrMemsetLoop(x86::Gp& i) noexcept;
  void cMaskCompositeAndStore(const x86::Mem& dPtr, uint32_t n, uint32_t alignment = 1) noexcept;
  void vMaskProc(Pixel& out, uint32_t flags, x86::Gp& msk, bool mImmutable) noexcept;

  void cMaskInitA8(const x86::Gp& sm_, const x86::Vec& vm_) noexcept;
  void cMaskFiniA8() noexcept;

  void cMaskProcA8Gp(Pixel& out, uint32_t flags) noexcept;
  void vMaskProcA8Gp(Pixel& out, uint32_t flags, x86::Gp& msk, bool mImmutable) noexcept;

  void cMaskProcA8Xmm(Pixel& out, uint32_t n, uint32_t flags) noexcept;
  void vMaskProcA8Xmm(Pixel& out, uint32_t n, uint32_t flags, VecArray& vm, bool mImmutable) noexcept;

  void cMaskInitRGBA32(const x86::Vec& vm) noexcept;
  void cMaskFiniRGBA32() noexcept;

  void cMaskProcRGBA32Xmm(Pixel& out, uint32_t n, uint32_t flags) noexcept;
  void vMaskProcRGBA32Xmm(Pixel& out, uint32_t n, uint32_t flags, VecArray& vm, bool mImmutable) noexcept;
  void vMaskProcRGBA32InvertMask(VecArray& vn, VecArray& vm) noexcept;
  void vMaskProcRGBA32InvertDone(VecArray& vn, bool mImmutable) noexcept;
};

} // {BLPipeGen}

//! \}
//! \endcond

#endif // BLEND2D_PIPEGEN_COMPOPPART_P_H
