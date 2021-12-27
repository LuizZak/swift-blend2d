// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Defines a mask of each field of the object info.
/// 
/// \note This is part of the official documentation, however, users should not use these enumerations in any context.
public extension BLObjectInfoBits {
    /// Flag describing a reference counted object, which means it has a valid reference count that must be increased/decreased.
    static let refCountedFlag = BL_OBJECT_INFO_REF_COUNTED_FLAG
    
    /// Flag describing an immutable object, which holds immutable data (immutable data is always external).
    static let immutableFlag = BL_OBJECT_INFO_IMMUTABLE_FLAG
    
    /// Flag describing 'X' payload value (it's a payload that has a single bit).
    static let xFlag = BL_OBJECT_INFO_X_FLAG
    
    /// Mask describing 'P' payload (7 bits).
    static let pMask = BL_OBJECT_INFO_P_MASK
    
    /// Mask describing 'C' payload (4 bits).
    static let cMask = BL_OBJECT_INFO_C_MASK
    
    /// Mask describing 'B' payload (4 bits).
    static let bMask = BL_OBJECT_INFO_B_MASK
    
    /// Mask describing 'A' payload (4 bits).
    static let aMask = BL_OBJECT_INFO_A_MASK
    
    /// Mask describing object type (8 bits), see \ref BLObjectType.
    static let typeMask = BL_OBJECT_INFO_TYPE_MASK
    
    /// Flag describing a virtual object.
    static let virtualFlag = BL_OBJECT_INFO_VIRTUAL_FLAG
    
    /// Flag describing the first most significant bit of \ref BLObjectType.
    static let tMsbFlag = BL_OBJECT_INFO_T_MSB_FLAG
    
    /// Flag describing a dynamic object - if this flag is not set, it means the object is in SSO mode.
    static let dynamicFlag = BL_OBJECT_INFO_DYNAMIC_FLAG
    
    /// Flag describing a valid object compatible with \ref BLObjectCore interface (otherwise it's most likely \ref BLRgba).
    static let markerFlag = BL_OBJECT_INFO_MARKER_FLAG
    
    /// Reference count initializer (combines \ref BL_OBJECT_INFO_REF_COUNTED_FLAG and \ref BL_OBJECT_INFO_IMMUTABLE_FLAG).
    static let rcInitMask = BL_OBJECT_INFO_RC_INIT_MASK
}
