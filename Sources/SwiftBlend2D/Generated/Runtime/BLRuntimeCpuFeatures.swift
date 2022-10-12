// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// CPU features Blend2D supports.
extension BLRuntimeCpuFeatures: OptionSet { }

public extension BLRuntimeCpuFeatures {
    static let x86_sse2 = BL_RUNTIME_CPU_FEATURE_X86_SSE2
    
    static let x86_sse3 = BL_RUNTIME_CPU_FEATURE_X86_SSE3
    
    static let x86_ssse3 = BL_RUNTIME_CPU_FEATURE_X86_SSSE3
    
    static let x86_sse4_1 = BL_RUNTIME_CPU_FEATURE_X86_SSE4_1
    
    static let x86_sse4_2 = BL_RUNTIME_CPU_FEATURE_X86_SSE4_2
    
    static let x86_avx = BL_RUNTIME_CPU_FEATURE_X86_AVX
    
    static let x86_avx2 = BL_RUNTIME_CPU_FEATURE_X86_AVX2
}