// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Describes a rendering operation type - fill or stroke.
/// 
/// The rendering context allows to get and set fill & stroke options directly or via "style" functions that take
/// the rendering operation type (`opType`) and dispatch the call to the right function.
public extension BLContextOpType {
    /// Fill operation type.
    static let fill = BL_CONTEXT_OP_TYPE_FILL
    
    /// Stroke operation type.
    static let stroke = BL_CONTEXT_OP_TYPE_STROKE
    
    /// Maximum value of `BLContextOpType`
    static let maxValue = BL_CONTEXT_OP_TYPE_MAX_VALUE
}
