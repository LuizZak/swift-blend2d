// [AsmJit]
// Machine Code Generation for C++.
//
// [License]
// ZLIB - See LICENSE.md file in the package.

#ifndef _ASMJIT_X86_X86INSTDB_H
#define _ASMJIT_X86_X86INSTDB_H

#include "../x86/x86globals.h"

ASMJIT_BEGIN_SUB_NAMESPACE(x86)

//! \addtogroup asmjit_x86_db
//! \{

//! Instruction database (X86).
namespace InstDB {

// ============================================================================
// [asmjit::x86::InstDB::Mode]
// ============================================================================

//! Describes which mode is supported by an instruction or instruction signature.
enum Mode : uint32_t {
  kModeNone               = 0x00u,       //!< Invalid.
  kModeX86                = 0x01u,       //!< X86 mode supported.
  kModeX64                = 0x02u,       //!< X64 mode supported.
  kModeAny                = 0x03u        //!< Both X86 and X64 modes supported.
};

static constexpr uint32_t modeFromArchId(uint32_t archId) noexcept {
  return archId == ArchInfo::kIdX86 ? kModeX86 :
         archId == ArchInfo::kIdX64 ? kModeX64 : kModeNone;
}

// ============================================================================
// [asmjit::x86::InstDB::OpFlags]
// ============================================================================

//! Operand flags (X86).
enum OpFlags : uint32_t {
  kOpNone                 = 0x00000000u, //!< No flags.

  kOpGpbLo                = 0x00000001u, //!< Operand can be low 8-bit GPB register.
  kOpGpbHi                = 0x00000002u, //!< Operand can be high 8-bit GPB register.
  kOpGpw                  = 0x00000004u, //!< Operand can be 16-bit GPW register.
  kOpGpd                  = 0x00000008u, //!< Operand can be 32-bit GPD register.
  kOpGpq                  = 0x00000010u, //!< Operand can be 64-bit GPQ register.
  kOpXmm                  = 0x00000020u, //!< Operand can be 128-bit XMM register.
  kOpYmm                  = 0x00000040u, //!< Operand can be 256-bit YMM register.
  kOpZmm                  = 0x00000080u, //!< Operand can be 512-bit ZMM register.
  kOpMm                   = 0x00000100u, //!< Operand can be 64-bit MM register.
  kOpKReg                 = 0x00000200u, //!< Operand can be 64-bit K register.
  kOpSReg                 = 0x00000400u, //!< Operand can be SReg (segment register).
  kOpCReg                 = 0x00000800u, //!< Operand can be CReg (control register).
  kOpDReg                 = 0x00001000u, //!< Operand can be DReg (debug register).
  kOpSt                   = 0x00002000u, //!< Operand can be 80-bit ST register (X87).
  kOpBnd                  = 0x00004000u, //!< Operand can be 128-bit BND register.
  kOpAllRegs              = 0x00007FFFu, //!< Combination of all possible registers.

  kOpI4                   = 0x00010000u, //!< Operand can be unsigned 4-bit  immediate.
  kOpU4                   = 0x00020000u, //!< Operand can be unsigned 4-bit  immediate.
  kOpI8                   = 0x00040000u, //!< Operand can be signed   8-bit  immediate.
  kOpU8                   = 0x00080000u, //!< Operand can be unsigned 8-bit  immediate.
  kOpI16                  = 0x00100000u, //!< Operand can be signed   16-bit immediate.
  kOpU16                  = 0x00200000u, //!< Operand can be unsigned 16-bit immediate.
  kOpI32                  = 0x00400000u, //!< Operand can be signed   32-bit immediate.
  kOpU32                  = 0x00800000u, //!< Operand can be unsigned 32-bit immediate.
  kOpI64                  = 0x01000000u, //!< Operand can be signed   64-bit immediate.
  kOpU64                  = 0x02000000u, //!< Operand can be unsigned 64-bit immediate.
  kOpAllImm               = 0x03FF0000u, //!< Operand can be any immediate.

  kOpMem                  = 0x04000000u, //!< Operand can be a scalar memory pointer.
  kOpVm                   = 0x08000000u, //!< Operand can be a vector memory pointer.

  kOpRel8                 = 0x10000000u, //!< Operand can be relative 8-bit  displacement.
  kOpRel32                = 0x20000000u, //!< Operand can be relative 32-bit displacement.

  kOpImplicit             = 0x80000000u  //!< Operand is implicit.
};

// ============================================================================
// [asmjit::x86::InstDB::MemFlags]
// ============================================================================

//! Memory operand flags (X86).
enum MemFlags : uint32_t {
  // NOTE: Instruction uses either scalar or vector memory operands, they never
  // collide. This allows us to share bits between "M" and "Vm" enums.

  kMemOpAny               = 0x0001u,     //!< Operand can be any scalar memory pointer.
  kMemOpM8                = 0x0002u,     //!< Operand can be an 8-bit memory pointer.
  kMemOpM16               = 0x0004u,     //!< Operand can be a 16-bit memory pointer.
  kMemOpM32               = 0x0008u,     //!< Operand can be a 32-bit memory pointer.
  kMemOpM48               = 0x0010u,     //!< Operand can be a 48-bit memory pointer (FAR pointers only).
  kMemOpM64               = 0x0020u,     //!< Operand can be a 64-bit memory pointer.
  kMemOpM80               = 0x0040u,     //!< Operand can be an 80-bit memory pointer.
  kMemOpM128              = 0x0080u,     //!< Operand can be a 128-bit memory pointer.
  kMemOpM256              = 0x0100u,     //!< Operand can be a 256-bit memory pointer.
  kMemOpM512              = 0x0200u,     //!< Operand can be a 512-bit memory pointer.
  kMemOpM1024             = 0x0400u,     //!< Operand can be a 1024-bit memory pointer.

  kMemOpVm32x             = 0x0002u,     //!< Operand can be a vm32x (vector) pointer.
  kMemOpVm32y             = 0x0004u,     //!< Operand can be a vm32y (vector) pointer.
  kMemOpVm32z             = 0x0008u,     //!< Operand can be a vm32z (vector) pointer.
  kMemOpVm64x             = 0x0020u,     //!< Operand can be a vm64x (vector) pointer.
  kMemOpVm64y             = 0x0040u,     //!< Operand can be a vm64y (vector) pointer.
  kMemOpVm64z             = 0x0080u,     //!< Operand can be a vm64z (vector) pointer.

  kMemOpBaseOnly          = 0x0800u,     //!< Only memory base is allowed (no index, no offset).
  kMemOpDs                = 0x1000u,     //!< Implicit memory operand's DS segment.
  kMemOpEs                = 0x2000u,     //!< Implicit memory operand's ES segment.

  kMemOpMib               = 0x4000u      //!< Operand must be MIB (base+index) pointer.
};

// ============================================================================
// [asmjit::x86::InstDB::Flags]
// ============================================================================

//! Instruction flags (X86).
//!
//! Details about instruction encoding, operation, features, and some limitations.
enum Flags : uint32_t {
  kFlagNone               = 0x00000000u, //!< No flags.

  // Operand's Use
  // -------------
  //
  // These flags describe the use of 1st and/or 1st+2nd operands. This allows
  // to fast calculate which operands are read, written, or read and written.
  //
  // In some cases this information is not reliable, because AsmJit uses data
  // generated by a script that merges usually more than one instruction into
  // one AsmJit instruction as some X86 instructions uses more encodings to
  // describe the same operation. In such case `kFlagUseComplex` is set and
  // AsmJit will use different approach to calculate operand's use flags.

  kFlagUseA               = 0x00000001u, //!< Use flags are ambiguous as USE information couldn't be flattened.
  kFlagUseR               = 0x00000002u, //!< 1st operand is R (read), read-only if `kFlagOpW` isn't set.
  kFlagUseW               = 0x00000004u, //!< 1st operand is W (written), write-only if `kFlagOpR` isn't set.
  kFlagUseX               = 0x00000006u, //!< 1st operand is X (read-write).
  kFlagUseXX              = 0x00000008u, //!< 1st and 2nd operands are XX (read & written) (XCHG, XADD).

  kFlagFixedReg           = 0x00000010u, //!< Some operand uses fixed register.
  kFlagFixedMem           = 0x00000020u, //!< Some operand uses fixed register to access memory (EAX|RAX, EDI|RDI, ESI|RSI).
  kFlagFixedRM            = 0x00000030u, //!< Combination of `kFlagUseFixedReg` and `kFlagUseFixedMem`.

  kFlagVolatile           = 0x00000040u,
  kFlagPrivileged         = 0x00000080u, //!< This is a privileged operation that cannot run in user mode.

  // Instruction Family
  // ------------------
  //
  // Instruction family information.

  kFlagFpu                = 0x00000100u, //!< Instruction that accesses FPU registers.
  kFlagMmx                = 0x00000200u, //!< Instruction that accesses MMX registers (including 3DNOW and GEODE) and EMMS.
  kFlagVec                = 0x00000400u, //!< Instruction that accesses XMM registers (SSE, AVX, AVX512).

  // Prefixes and Encoding Flags
  // ---------------------------
  //
  // These describe optional X86 prefixes that can be used to change the instruction's operation.

  kFlagRep                = 0x00001000u, //!< Instruction can be prefixed with using the REP/REPE/REPZ prefix.
  kFlagRepIgnored         = 0x00002000u, //!< Instruction can be prefixed with using the REPNE/REPNZ prefix.
  kFlagLock               = 0x00004000u, //!< Instruction can be prefixed with using the LOCK prefix.
  kFlagXAcquire           = 0x00008000u, //!< Instruction can be prefixed with using the XACQUIRE prefix.
  kFlagXRelease           = 0x00010000u, //!< Instruction can be prefixed with using the XRELEASE prefix.
  kFlagMib                = 0x00020000u, //!< Instruction uses MIB (BNDLDX|BNDSTX) to encode two registers.
  kFlagVsib               = 0x00040000u, //!< Instruction uses VSIB instead of legacy SIB.
  kFlagVex                = 0x00080000u, //!< Instruction can be encoded by VEX|XOP (AVX|AVX2|BMI|XOP|...).
  kFlagEvex               = 0x00100000u, //!< Instruction can be encoded by EVEX (AVX512).

  // FPU Flags
  // ---------
  //
  // Used to tell the encoder which memory operand sizes are encodable.

  kFlagFpuM16             = 0x00200000u, //!< FPU instruction can address `word_ptr` (shared with M10).
  kFlagFpuM32             = 0x00400000u, //!< FPU instruction can address `dword_ptr`.
  kFlagFpuM64             = 0x00800000u, //!< FPU instruction can address `qword_ptr`.
  kFlagFpuM80             = 0x00200000u, //!< FPU instruction can address `tword_ptr` (shared with M2).

  // AVX and AVX515 Flags
  // --------------------
  //
  // If both `kFlagPrefixVex` and `kFlagPrefixEvex` flags are specified it
  // means that the instructions can be encoded by either VEX or EVEX prefix.
  // In that case AsmJit checks global options and also instruction options
  // to decide whether to emit VEX or EVEX prefix.

  kFlagAvx512_            = 0x00000000u, //!< Internally used in tables, has no meaning.
  kFlagAvx512K            = 0x01000000u, //!< Supports masking {k1..k7}.
  kFlagAvx512Z            = 0x02000000u, //!< Supports zeroing {z}, must be used together with `kAvx512k`.
  kFlagAvx512ER           = 0x04000000u, //!< Supports 'embedded-rounding' {er} with implicit {sae},
  kFlagAvx512SAE          = 0x08000000u, //!< Supports 'suppress-all-exceptions' {sae}.
  kFlagAvx512B32          = 0x10000000u, //!< Supports 32-bit broadcast 'b32'.
  kFlagAvx512B64          = 0x20000000u, //!< Supports 64-bit broadcast 'b64'.
  kFlagAvx512T4X          = 0x80000000u, //!< Operates on a vector of consecutive registers (AVX512_4FMAPS and AVX512_4VNNIW).

  // Combinations used by instruction tables to make AVX512 definitions more compact.
  kFlagAvx512KZ            = kFlagAvx512K         | kFlagAvx512Z,
  kFlagAvx512ER_SAE        = kFlagAvx512ER        | kFlagAvx512SAE,
  kFlagAvx512KZ_SAE        = kFlagAvx512KZ        | kFlagAvx512SAE,
  kFlagAvx512KZ_SAE_B32    = kFlagAvx512KZ_SAE    | kFlagAvx512B32,
  kFlagAvx512KZ_SAE_B64    = kFlagAvx512KZ_SAE    | kFlagAvx512B64,

  kFlagAvx512KZ_ER_SAE     = kFlagAvx512KZ        | kFlagAvx512ER_SAE,
  kFlagAvx512KZ_ER_SAE_B32 = kFlagAvx512KZ_ER_SAE | kFlagAvx512B32,
  kFlagAvx512KZ_ER_SAE_B64 = kFlagAvx512KZ_ER_SAE | kFlagAvx512B64,

  kFlagAvx512K_B32         = kFlagAvx512K         | kFlagAvx512B32,
  kFlagAvx512K_B64         = kFlagAvx512K         | kFlagAvx512B64,
  kFlagAvx512KZ_B32        = kFlagAvx512KZ        | kFlagAvx512B32,
  kFlagAvx512KZ_B64        = kFlagAvx512KZ        | kFlagAvx512B64
};

// ============================================================================
// [asmjit::x86::InstDB::SpecialCases]
// ============================================================================

//! Cases that require special handling.
enum SpecialCases : uint32_t {
  //! `MOV REG <-> CREG|DREG` - Defined/Undefined flags, L0/L3 privilege levels.
  kSpecialCaseMovCrDr = 0x00000001u,
  //! `MOVSS|MOVSD XMM, [MEM]` - Destination operand is completely overwritten.
  kSpecialCaseMovSsSd = 0x00000002u
};

// ============================================================================
// [asmjit::x86::InstDB::OperationFlags]
// ============================================================================

//! Used to describe what the instruction does and some of its quirks.
enum OperationFlags : uint32_t {
  //! Hint for instruction schedulers to never reorder this instruction (side effects, memory barrier, etc).
  kOperationVolatile = 0x00000001u
};

// ============================================================================
// [asmjit::x86::InstDB::SingleRegCase]
// ============================================================================

enum SingleRegCase : uint32_t {
  //! No special handling.
  kSingleRegNone = 0,
  //! Operands become read-only  - `REG & REG` and similar.
  kSingleRegRO = 1,
  //! Operands become write-only - `REG ^ REG` and similar.
  kSingleRegWO = 2
};

ASMJIT_VARAPI const char _nameData[];

// ============================================================================
// [asmjit::x86::InstDB::OpSignature]
// ============================================================================

//! Operand signature (X86).
//!
//! Contains all possible operand combinations, memory size information, and
//! a fixed register id (or `BaseReg::kIdBad` if fixed id isn't required).
struct OpSignature {
  //! Operand flags.
  uint32_t opFlags;
  //! Memory flags.
  uint16_t memFlags;
  //! Extra flags.
  uint8_t extFlags;
  //! Mask of possible register IDs.
  uint8_t regMask;
};

ASMJIT_VARAPI const OpSignature _opSignatureTable[];

// ============================================================================
// [asmjit::x86::InstDB::InstSignature]
// ============================================================================

//! Instruction signature (X86).
//!
//! Contains a sequence of operands' combinations and other metadata that defines
//! a single instruction. This data is used by instruction validator.
struct InstSignature {
  //! Count of operands in `opIndex` (0..6).
  uint8_t opCount : 3;
  //! Architecture modes supported (X86 / X64).
  uint8_t modes : 2;
  //! Number of implicit operands.
  uint8_t implicit : 3;
  //! Reserved for future use.
  uint8_t reserved;
  //! Indexes to `OpSignature` table.
  uint8_t operands[Globals::kMaxOpCount];
};

ASMJIT_VARAPI const InstSignature _instSignatureTable[];

// ============================================================================
// [asmjit::x86::InstDB::CommonInfo]
// ============================================================================

//! Instruction common information (X86)
//!
//! Aggregated information shared across one or more instruction.
struct CommonInfo {
  // --------------------------------------------------------------------------
  // [Accessors]
  // --------------------------------------------------------------------------

  //! Gets all instruction flags, see `InstInfo::Flags`.
  inline uint32_t flags() const noexcept { return _flags; }
  //! Gets whether the instruction has a `flag`, see `InstInfo::Flags`.
  inline bool hasFlag(uint32_t flag) const noexcept { return (_flags & flag) != 0; }

  //! Gets whether the instruction is FPU instruction.
  inline bool isFpu() const noexcept { return hasFlag(kFlagFpu); }
  //! Gets whether the instruction is MMX/3DNOW instruction that accesses MMX registers (includes EMMS and FEMMS).
  inline bool isMmx() const noexcept { return hasFlag(kFlagMmx); }
  //! Gets whether the instruction is SSE|AVX|AVX512 instruction that accesses XMM|YMM|ZMM registers.
  inline bool isVec() const noexcept { return hasFlag(kFlagVec); }
  //! Gets whether the instruction is SSE+ (SSE4.2, AES, SHA included) instruction that accesses XMM registers.
  inline bool isSse() const noexcept { return (flags() & (kFlagVec | kFlagVex | kFlagEvex)) == kFlagVec; }
  //! Gets whether the instruction is AVX+ (FMA included) instruction that accesses XMM|YMM|ZMM registers.
  inline bool isAvx() const noexcept { return isVec() && isVexOrEvex(); }

  //! Gets whether the instruction can be prefixed with LOCK prefix.
  inline bool hasLockPrefix() const noexcept { return hasFlag(kFlagLock); }
  //! Gets whether the instruction can be prefixed with REP (REPE|REPZ) prefix.
  inline bool hasRepPrefix() const noexcept { return hasFlag(kFlagRep); }
  //! Gets whether the instruction can be prefixed with XACQUIRE prefix.
  inline bool hasXAcquirePrefix() const noexcept { return hasFlag(kFlagXAcquire); }
  //! Gets whether the instruction can be prefixed with XRELEASE prefix.
  inline bool hasXReleasePrefix() const noexcept { return hasFlag(kFlagXRelease); }

  //! Gets whether the rep prefix is supported by the instruction, but ignored (has no effect).
  inline bool isRepIgnored() const noexcept { return hasFlag(kFlagRepIgnored); }
  //! Gets whether the instruction uses MIB.
  inline bool isMibOp() const noexcept { return hasFlag(kFlagMib); }
  //! Gets whether the instruction uses VSIB.
  inline bool isVsibOp() const noexcept { return hasFlag(kFlagVsib); }
  //! Gets whether the instruction uses VEX (can be set together with EVEX if both are encodable).
  inline bool isVex() const noexcept { return hasFlag(kFlagVex); }
  //! Gets whether the instruction uses EVEX (can be set together with VEX if both are encodable).
  inline bool isEvex() const noexcept { return hasFlag(kFlagEvex); }
  //! Gets whether the instruction uses EVEX (can be set together with VEX if both are encodable).
  inline bool isVexOrEvex() const noexcept { return hasFlag(kFlagVex | kFlagEvex); }

  //! Gets whether the instruction supports AVX512 masking {k}.
  inline bool hasAvx512K() const noexcept { return hasFlag(kFlagAvx512K); }
  //! Gets whether the instruction supports AVX512 zeroing {k}{z}.
  inline bool hasAvx512Z() const noexcept { return hasFlag(kFlagAvx512Z); }
  //! Gets whether the instruction supports AVX512 embedded-rounding {er}.
  inline bool hasAvx512ER() const noexcept { return hasFlag(kFlagAvx512ER); }
  //! Gets whether the instruction supports AVX512 suppress-all-exceptions {sae}.
  inline bool hasAvx512SAE() const noexcept { return hasFlag(kFlagAvx512SAE); }
  //! Gets whether the instruction supports AVX512 broadcast (either 32-bit or 64-bit).
  inline bool hasAvx512B() const noexcept { return hasFlag(kFlagAvx512B32 | kFlagAvx512B64); }
  //! Gets whether the instruction supports AVX512 broadcast (32-bit).
  inline bool hasAvx512B32() const noexcept { return hasFlag(kFlagAvx512B32); }
  //! Gets whether the instruction supports AVX512 broadcast (64-bit).
  inline bool hasAvx512B64() const noexcept { return hasFlag(kFlagAvx512B64); }

  //! Gets the destination index of WRITE operation.
  inline uint32_t writeIndex() const noexcept { return _writeIndex; }
  //! Gets the number of bytes that will be written by a WRITE operation.
  //!
  //! This information is required by a liveness analysis to mark virtual
  //! registers dead even if the instruction doesn't completely overwrite
  //! the whole register. If the analysis keeps which bytes are completely
  //! overwritten by the instruction it can find the where a register becomes
  //! dead by simply checking if the instruction overwrites all remaining
  //! bytes.
  inline uint32_t writeSize() const noexcept { return _writeSize; }

  inline uint32_t signatureIndex() const noexcept { return _iSignatureIndex; }
  inline uint32_t signatureCount() const noexcept { return _iSignatureCount; }

  inline const InstSignature* signatureData() const noexcept { return _instSignatureTable + _iSignatureIndex; }
  inline const InstSignature* signatureEnd() const noexcept { return _instSignatureTable + _iSignatureIndex + _iSignatureCount; }

  //! Gets the control-flow type of the instruction.
  inline uint32_t controlType() const noexcept { return _controlType; }

  inline uint32_t singleRegCase() const noexcept { return _singleRegCase; }
  inline uint32_t specialCases() const noexcept { return _specialCases; }

  // --------------------------------------------------------------------------
  // [Members]
  // --------------------------------------------------------------------------

  //! Instruction flags.
  uint32_t _flags;
  //! First DST byte of a WRITE operation (default 0).
  uint32_t _writeIndex : 8;
  //! Number of bytes to be written in DST.
  uint32_t _writeSize : 24;

  //! First `InstSignature` entry in the database.
  uint32_t _iSignatureIndex : 11;
  //! Number of relevant `ISignature` entries.
  uint32_t _iSignatureCount : 5;
  //! Control type, see `ControlType`.
  uint32_t _controlType : 3;
  //! Specifies what happens if all source operands share the same register.
  uint32_t _singleRegCase : 2;
  //! Special cases.
  uint32_t _specialCases : 4;
  //! Reserved for future use.
  uint32_t _reserved : 7;
};

ASMJIT_VARAPI const CommonInfo _commonInfoTable[];

// ============================================================================
// [asmjit::x86::InstDB::ExecutionInfo]
// ============================================================================

//! Detailed data about instruction's operation, requirements, and side-effects.
struct ExecutionInfo {
  // --------------------------------------------------------------------------
  // [Accessors]
  // --------------------------------------------------------------------------

  ASMJIT_INLINE bool hasFeature(uint32_t feature) const noexcept {
    for (uint32_t i = 0; i < ASMJIT_ARRAY_SIZE(_features); i++)
      if (feature == _features[i])
        return true;
    return false;
  }

  inline uint32_t specialRegsR() const noexcept { return _specialRegsR; }
  inline uint32_t specialRegsW() const noexcept { return _specialRegsW; }

  inline const uint8_t* featuresData() const noexcept { return _features; }
  inline const uint8_t* featuresEnd() const noexcept { return _features + ASMJIT_ARRAY_SIZE(_features); }

  // --------------------------------------------------------------------------
  // [Members]
  // --------------------------------------------------------------------------

  //! Operation flags.
  uint16_t _flags;
  //! Features vector.
  uint8_t _features[6];
  //! Special registers read.
  uint32_t _specialRegsR;
  //! Special registers written.
  uint32_t _specialRegsW;
};

ASMJIT_VARAPI const ExecutionInfo _executionInfoTable[];

// ============================================================================
// [asmjit::x86::InstDB::InstInfo]
// ============================================================================

//! Instruction information (X86).
struct InstInfo {
  // --------------------------------------------------------------------------
  // [Accessors]
  // --------------------------------------------------------------------------

  //! Gets instruction name (null terminated).
  //!
  //! NOTE: If AsmJit was compiled with `ASMJIT_DISABLE_TEXT` then this will
  //! return an empty string (null terminated string of zero size).
  inline const char* name() const noexcept { return _nameData + _nameDataIndex; };

  //! Gets common information, see `CommonInfo`.
  inline const CommonInfo& commonInfo() const noexcept { return _commonInfoTable[_commonInfoIndex]; }
  //! Gets execution information, see `ExecutionInfo`.
  inline const ExecutionInfo& executionInfo() const noexcept { return _executionInfoTable[_executionInfoIndex]; }

  //! Gets whether the instruction has flag `flag`, see `Flags`.
  inline bool hasFlag(uint32_t flag) const noexcept { return commonInfo().hasFlag(flag); }
  //! Gets instruction flags, see `Flags`.
  inline uint32_t flags() const noexcept { return commonInfo().flags(); }

  //! Gets whether the instruction is FPU instruction.
  inline bool isFpu() const noexcept { return commonInfo().isFpu(); }
  //! Gets whether the instruction is MMX/3DNOW instruction that accesses MMX registers (includes EMMS and FEMMS).
  inline bool isMmx() const noexcept { return commonInfo().isMmx(); }
  //! Gets whether the instruction is SSE|AVX|AVX512 instruction that accesses XMM|YMM|ZMM registers.
  inline bool isVec() const noexcept { return commonInfo().isVec(); }
  //! Gets whether the instruction is SSE+ (SSE4.2, AES, SHA included) instruction that accesses XMM registers.
  inline bool isSse() const noexcept { return commonInfo().isSse(); }
  //! Gets whether the instruction is AVX+ (FMA included) instruction that accesses XMM|YMM|ZMM registers.
  inline bool isAvx() const noexcept { return commonInfo().isAvx(); }

  //! Gets whether the instruction can be prefixed with LOCK prefix.
  inline bool hasLockPrefix() const noexcept { return commonInfo().hasLockPrefix(); }
  //! Gets whether the instruction can be prefixed with REP (REPE|REPZ) prefix.
  inline bool hasRepPrefix() const noexcept { return commonInfo().hasRepPrefix(); }
  //! Gets whether the instruction can be prefixed with XACQUIRE prefix.
  inline bool hasXAcquirePrefix() const noexcept { return commonInfo().hasXAcquirePrefix(); }
  //! Gets whether the instruction can be prefixed with XRELEASE prefix.
  inline bool hasXReleasePrefix() const noexcept { return commonInfo().hasXReleasePrefix(); }

  //! Gets whether the rep prefix is supported by the instruction, but ignored (has no effect).
  inline bool isRepIgnored() const noexcept { return commonInfo().isRepIgnored(); }
  //! Gets whether the instruction uses MIB.
  inline bool isMibOp() const noexcept { return hasFlag(kFlagMib); }
  //! Gets whether the instruction uses VSIB.
  inline bool isVsibOp() const noexcept { return hasFlag(kFlagVsib); }
  //! Gets whether the instruction uses VEX (can be set together with EVEX if both are encodable).
  inline bool isVex() const noexcept { return hasFlag(kFlagVex); }
  //! Gets whether the instruction uses EVEX (can be set together with VEX if both are encodable).
  inline bool isEvex() const noexcept { return hasFlag(kFlagEvex); }
  //! Gets whether the instruction uses EVEX (can be set together with VEX if both are encodable).
  inline bool isVexOrEvex() const noexcept { return hasFlag(kFlagVex | kFlagEvex); }

  //! Gets whether the instruction supports AVX512 masking {k}.
  inline bool hasAvx512K() const noexcept { return hasFlag(kFlagAvx512K); }
  //! Gets whether the instruction supports AVX512 zeroing {k}{z}.
  inline bool hasAvx512Z() const noexcept { return hasFlag(kFlagAvx512Z); }
  //! Gets whether the instruction supports AVX512 embedded-rounding {er}.
  inline bool hasAvx512ER() const noexcept { return hasFlag(kFlagAvx512ER); }
  //! Gets whether the instruction supports AVX512 suppress-all-exceptions {sae}.
  inline bool hasAvx512SAE() const noexcept { return hasFlag(kFlagAvx512SAE); }
  //! Gets whether the instruction supports AVX512 broadcast (either 32-bit or 64-bit).
  inline bool hasAvx512B() const noexcept { return hasFlag(kFlagAvx512B32 | kFlagAvx512B64); }
  //! Gets whether the instruction supports AVX512 broadcast (32-bit).
  inline bool hasAvx512B32() const noexcept { return hasFlag(kFlagAvx512B32); }
  //! Gets whether the instruction supports AVX512 broadcast (64-bit).
  inline bool hasAvx512B64() const noexcept { return hasFlag(kFlagAvx512B64); }

  //! Gets whether 1st operand is read-only.
  inline bool isUseR() const noexcept { return (flags() & kFlagUseX) == kFlagUseR; }
  //! Gets whether 1st operand is write-only.
  inline bool isUseW() const noexcept { return (flags() & kFlagUseX) == kFlagUseW; }
  //! Gets whether 1st operand is read-write.
  inline bool isUseX() const noexcept { return (flags() & kFlagUseX) == kFlagUseX; }
  //! Gets whether 1st and 2nd operands are read-write.
  inline bool isUseXX() const noexcept { return hasFlag(kFlagUseXX); }

  inline bool hasFixedReg() const noexcept { return hasFlag(kFlagFixedReg); }
  inline bool hasFixedMem() const noexcept { return hasFlag(kFlagFixedMem); }
  inline bool hasFixedRM() const noexcept { return hasFlag(kFlagFixedRM); }

  //! Gets the control-flow type of the instruction.
  inline uint32_t controlType() const noexcept { return commonInfo().controlType(); }
  inline uint32_t singleRegCase() const noexcept { return commonInfo().singleRegCase(); }
  inline uint32_t specialCases() const noexcept { return commonInfo().specialCases(); }

  inline uint32_t signatureIndex() const noexcept { return commonInfo().signatureIndex(); }
  inline uint32_t signatureCount() const noexcept { return commonInfo().signatureCount(); }

  inline const InstSignature* signatureData() const noexcept { return commonInfo().signatureData(); }
  inline const InstSignature* signatureEnd() const noexcept { return commonInfo().signatureEnd(); }

  // --------------------------------------------------------------------------
  // [Members]
  // --------------------------------------------------------------------------

  //!< Index to `_nameData`.
  uint32_t _nameDataIndex : 14;
  //!< Index to `_commonInfoTable`.
  uint32_t _commonInfoIndex : 10;
  //!< Index to `_executionInfoTable`.
  uint32_t _executionInfoIndex : 8;
};

ASMJIT_VARAPI const InstInfo _instInfoTable[];

#ifndef ASMJIT_DISABLE_TEXT
//! Gets an instruction ID from a given instruction `name`.
//!
//! NOTE: Instruction name MUST BE in lowercase, otherwise there will be no
//! match. If there is an exact match the instruction id is returned, otherwise
//! `Globals::kInvalidInstId` (zero) is returned instead. The given `name` does
//! not have to be null-terminated if `nameSize` is provided (not `SIZE_MAX`).
ASMJIT_API uint32_t idByName(const char* name, size_t nameSize = SIZE_MAX) noexcept;

//! Gets an instruction name from a given instruction id `instId`.
ASMJIT_API const char* nameById(uint32_t instId) noexcept;
#endif

inline const InstInfo& infoById(uint32_t instId) noexcept {
  ASMJIT_ASSERT(Inst::isDefinedId(instId));
  return _instInfoTable[instId];
}

} // {InstDB}

//! \}

ASMJIT_END_SUB_NAMESPACE

#endif // _ASMJIT_X86_X86INSTDB_H