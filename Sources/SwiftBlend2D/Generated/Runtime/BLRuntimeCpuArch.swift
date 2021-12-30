// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// CPU architecture that can be queried by `BLRuntime::querySystemInfo()`.
public extension BLRuntimeCpuArch {
    /// Unknown architecture.
    static let unknown = BL_RUNTIME_CPU_ARCH_UNKNOWN
    
    /// 32-bit or 64-bit X86 architecture.
    static let x86 = BL_RUNTIME_CPU_ARCH_X86
    
    /// 32-bit or 64-bit ARM architecture.
    static let arm = BL_RUNTIME_CPU_ARCH_ARM
    
    /// 32-bit or 64-bit MIPS architecture.
    static let mips = BL_RUNTIME_CPU_ARCH_MIPS
}
