// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// 2D matrix operation.
public extension BLMatrix2DOp {
    /// Reset matrix to identity (argument ignored, should be nullptr).
    static let reset = BL_MATRIX2D_OP_RESET
    
    /// Assign (copy) the other matrix.
    static let assign = BL_MATRIX2D_OP_ASSIGN
    
    /// Translate the matrix by [x, y].
    static let translate = BL_MATRIX2D_OP_TRANSLATE
    
    /// Scale the matrix by [x, y].
    static let scale = BL_MATRIX2D_OP_SCALE
    
    /// Skew the matrix by [x, y].
    static let skew = BL_MATRIX2D_OP_SKEW
    
    /// Rotate the matrix by the given angle about [0, 0].
    static let rotate = BL_MATRIX2D_OP_ROTATE
    
    /// Rotate the matrix by the given angle about [x, y].
    static let rotatePt = BL_MATRIX2D_OP_ROTATE_PT
    
    /// Transform this matrix by other `BLMatrix2D`.
    static let transform = BL_MATRIX2D_OP_TRANSFORM
    
    /// Post-translate the matrix by [x, y].
    static let postTranslate = BL_MATRIX2D_OP_POST_TRANSLATE
    
    /// Post-scale the matrix by [x, y].
    static let postScale = BL_MATRIX2D_OP_POST_SCALE
    
    /// Post-skew the matrix by [x, y].
    static let postSkew = BL_MATRIX2D_OP_POST_SKEW
    
    /// Post-rotate the matrix about [0, 0].
    static let postRotate = BL_MATRIX2D_OP_POST_ROTATE
    
    /// Post-rotate the matrix about a reference BLPoint.
    static let postRotatePt = BL_MATRIX2D_OP_POST_ROTATE_PT
    
    /// Post-transform this matrix by other `BLMatrix2D`.
    static let postTransform = BL_MATRIX2D_OP_POST_TRANSFORM
    
    /// Maximum value of `BLMatrix2DOp`.
    static let maxValue = BL_MATRIX2D_OP_MAX_VALUE
}
