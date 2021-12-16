// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Type of runtime information that can be queried through \ref blRuntimeQueryInfo().
public extension BLRuntimeInfoType {
    /// Blend2D build information.
    static let build = BL_RUNTIME_INFO_TYPE_BUILD
    
    /// System information (includes CPU architecture, features, core count, etc...).
    static let system = BL_RUNTIME_INFO_TYPE_SYSTEM
    
    /// Resources information (includes Blend2D memory consumption)
    static let resource = BL_RUNTIME_INFO_TYPE_RESOURCE
    
    /// Count of runtime information types.
    static let maxValue = BL_RUNTIME_INFO_TYPE_MAX_VALUE
}
