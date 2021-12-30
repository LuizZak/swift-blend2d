// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Flags used by `BLGlyphRun`.
extension BLGlyphRunFlags: OptionSet { }

public extension BLGlyphRunFlags {
    /// No flags.
    static let noFlags = BL_GLYPH_RUN_NO_FLAGS
    
    /// Glyph-run contains UCS-4 string and not glyphs (glyph-buffer only).
    static let ucs4Content = BL_GLYPH_RUN_FLAG_UCS4_CONTENT
    
    /// Glyph-run was created from text that was not a valid unicode.
    static let invalidText = BL_GLYPH_RUN_FLAG_INVALID_TEXT
    
    /// Not the whole text was mapped to glyphs (contains undefined glyphs).
    static let undefinedGlyphs = BL_GLYPH_RUN_FLAG_UNDEFINED_GLYPHS
    
    /// Encountered invalid font-data during text / glyph processing.
    static let invalidFontData = BL_GLYPH_RUN_FLAG_INVALID_FONT_DATA
}
