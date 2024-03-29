// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

/// 2D matrix type that can be obtained by calling `BLMatrix2D.type()`.
/// 
/// ```
/// Identity  Transl.  Scale     Swap    Affine
/// [1  0]   [1  0]   [.  0]   [0  .]   [.  .]
/// [0  1]   [0  1]   [0  .]   [.  0]   [.  .]
/// [0  0]   [.  .]   [.  .]   [.  .]   [.  .]
/// ```
public extension BLMatrix2DType {
    /// Identity matrix.
    static let identity = BL_MATRIX2D_TYPE_IDENTITY
    
    /// Has translation part (the rest is like identity).
    static let translate = BL_MATRIX2D_TYPE_TRANSLATE
    
    /// Has translation and scaling parts.
    static let scale = BL_MATRIX2D_TYPE_SCALE
    
    /// Has translation and scaling parts, however scaling swaps X/Y.
    static let swap = BL_MATRIX2D_TYPE_SWAP
    
    /// Generic affine matrix.
    static let affine = BL_MATRIX2D_TYPE_AFFINE
    
    /// Invalid/degenerate matrix not useful for transformations.
    static let invalid = BL_MATRIX2D_TYPE_INVALID
    
    /// Maximum value of `BLMatrix2DType`.
    static let maxValue = BL_MATRIX2D_TYPE_MAX_VALUE
}
