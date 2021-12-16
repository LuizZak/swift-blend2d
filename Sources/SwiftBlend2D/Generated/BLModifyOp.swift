// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// \ingroup blend2d_api_globals
/// 
/// Modification operation applied to Blend2D containers.
public extension BLModifyOp {
    /// Assign operation, which reserves space only to fit the requested input.
    static let assignFit = BL_MODIFY_OP_ASSIGN_FIT
    
    /// Assign operation, which takes into consideration successive appends.
    static let assignGrow = BL_MODIFY_OP_ASSIGN_GROW
    
    /// Append operation, which reserves space only to fit the current and appended content.
    static let appendFit = BL_MODIFY_OP_APPEND_FIT
    
    /// Append operation, which takes into consideration successive appends.
    static let appendGrow = BL_MODIFY_OP_APPEND_GROW
    
    /// Maximum value of `BLModifyOp`.
    static let maxValue = BL_MODIFY_OP_MAX_VALUE
}
