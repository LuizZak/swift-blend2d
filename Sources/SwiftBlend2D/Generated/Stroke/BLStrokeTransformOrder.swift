// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

/// Stroke transform order.
public extension BLStrokeTransformOrder {
    /// Transform after stroke  => `Transform(Stroke(Input))` [default].
    static let after = BL_STROKE_TRANSFORM_ORDER_AFTER
    
    /// Transform before stroke => `Stroke(Transform(Input))`.
    static let before = BL_STROKE_TRANSFORM_ORDER_BEFORE
    
    /// Maximum value of `BLStrokeTransformOrder`.
    static let maxValue = BL_STROKE_TRANSFORM_ORDER_MAX_VALUE
}
