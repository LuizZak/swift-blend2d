// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Extend mode.
public extension BLExtendMode {
    /// Pad extend [default].
    static let pad = BL_EXTEND_MODE_PAD
    
    /// Repeat extend.
    static let `repeat` = BL_EXTEND_MODE_REPEAT
    
    /// Reflect extend.
    static let reflect = BL_EXTEND_MODE_REFLECT
    
    /// Alias to `BLExtendMode.pad`.
    static let padXPadY = BL_EXTEND_MODE_PAD_X_PAD_Y
    
    /// Pad X and repeat Y.
    static let padXRepeatY = BL_EXTEND_MODE_PAD_X_REPEAT_Y
    
    /// Pad X and reflect Y.
    static let padXReflectY = BL_EXTEND_MODE_PAD_X_REFLECT_Y
    
    /// Alias to `BLExtendMode.repeat`.
    static let repeatXRepeatY = BL_EXTEND_MODE_REPEAT_X_REPEAT_Y
    
    /// Repeat X and pad Y.
    static let repeatXPadY = BL_EXTEND_MODE_REPEAT_X_PAD_Y
    
    /// Repeat X and reflect Y.
    static let repeatXReflectY = BL_EXTEND_MODE_REPEAT_X_REFLECT_Y
    
    /// Alias to `BLExtendMode.reflect`.
    static let reflectXReflectY = BL_EXTEND_MODE_REFLECT_X_REFLECT_Y
    
    /// Reflect X and pad Y.
    static let reflectXPadY = BL_EXTEND_MODE_REFLECT_X_PAD_Y
    
    /// Reflect X and repeat Y.
    static let reflectXRepeatY = BL_EXTEND_MODE_REFLECT_X_REPEAT_Y
    
    /// Count of simple extend modes (that use the same value for X and Y).
    static let simpleMaxValue = BL_EXTEND_MODE_SIMPLE_MAX_VALUE
    
    /// Count of complex extend modes (that can use independent values for X and Y).
    static let complexMaxValue = BL_EXTEND_MODE_COMPLEX_MAX_VALUE
    
    /// Maximum value of `BLExtendMode`.
    static let maxValue = BL_EXTEND_MODE_MAX_VALUE
}
