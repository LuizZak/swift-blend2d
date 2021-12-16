// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Stroke join type.
public extension BLStrokeJoin {
    /// Miter-join possibly clipped at `miterLimit` [default].
    static let miterClip = BL_STROKE_JOIN_MITER_CLIP
    
    /// Miter-join or bevel-join depending on miterLimit condition.
    static let miterBevel = BL_STROKE_JOIN_MITER_BEVEL
    
    /// Miter-join or round-join depending on miterLimit condition.
    static let miterRound = BL_STROKE_JOIN_MITER_ROUND
    
    /// Bevel-join.
    static let bevel = BL_STROKE_JOIN_BEVEL
    
    /// Round-join.
    static let round = BL_STROKE_JOIN_ROUND
    
    /// Maximum value of `BLStrokeJoin`.
    static let maxValue = BL_STROKE_JOIN_MAX_VALUE
}
