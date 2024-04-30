// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

/// Type of a font or font face, see `BLFontFace` (or `BLFontFaceCore`).
public extension BLFontFaceType {
    /// None or unknown font type.
    static let none = BL_FONT_FACE_TYPE_NONE
    
    /// TrueType/OpenType font type (.ttf/.otf files and font collections).
    static let opentype = BL_FONT_FACE_TYPE_OPENTYPE
    
    /// Maximum value of `BLFontFaceType`.
    static let maxValue = BL_FONT_FACE_TYPE_MAX_VALUE
}
