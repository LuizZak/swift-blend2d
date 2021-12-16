// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Flags used by \ref BLFontFace (or \ref BLFontFaceCore)
extension BLFontFaceFlags: OptionSet { }

public extension BLFontFaceFlags {
    /// No flags.
    static let noFlags = BL_FONT_FACE_NO_FLAGS
    
    /// Font uses typographic family and subfamily names.
    static let typographicNames = BL_FONT_FACE_FLAG_TYPOGRAPHIC_NAMES
    
    /// Font uses typographic metrics.
    static let typographicMetrics = BL_FONT_FACE_FLAG_TYPOGRAPHIC_METRICS
    
    /// Character to glyph mapping is available.
    static let charToGlyphMapping = BL_FONT_FACE_FLAG_CHAR_TO_GLYPH_MAPPING
    
    /// Horizontal glyph metrics (advances, side bearings) is available.
    static let horizontalMetircs = BL_FONT_FACE_FLAG_HORIZONTAL_METIRCS
    
    /// Vertical glyph metrics (advances, side bearings) is available.
    static let verticalMetrics = BL_FONT_FACE_FLAG_VERTICAL_METRICS
    
    /// Legacy horizontal kerning feature ('kern' table with horizontal kerning data).
    static let horizontalKerning = BL_FONT_FACE_FLAG_HORIZONTAL_KERNING
    
    /// Legacy vertical kerning feature ('kern' table with vertical kerning data).
    static let verticalKerning = BL_FONT_FACE_FLAG_VERTICAL_KERNING
    
    /// OpenType features (GDEF, GPOS, GSUB) are available.
    static let opentypeFeatures = BL_FONT_FACE_FLAG_OPENTYPE_FEATURES
    
    /// Panose classification is available.
    static let panoseData = BL_FONT_FACE_FLAG_PANOSE_DATA
    
    /// Unicode coverage information is available.
    static let unicodeCoverage = BL_FONT_FACE_FLAG_UNICODE_COVERAGE
    
    /// Baseline for font at `y` equals 0.
    static let baselineYEquals0 = BL_FONT_FACE_FLAG_BASELINE_Y_EQUALS_0
    
    /// Left sidebearing point at `x == 0` (TT only).
    static let lsbPointXEquals0 = BL_FONT_FACE_FLAG_LSB_POINT_X_EQUALS_0
    
    /// Unicode variation sequences feature is available.
    static let variationSequences = BL_FONT_FACE_FLAG_VARIATION_SEQUENCES
    
    /// OpenType Font Variations feature is available.
    static let opentypeVariations = BL_FONT_FACE_FLAG_OPENTYPE_VARIATIONS
    
    /// This is a symbol font.
    static let symbolFont = BL_FONT_FACE_FLAG_SYMBOL_FONT
    
    /// This is a last resort font.
    static let lastResortFont = BL_FONT_FACE_FLAG_LAST_RESORT_FONT
}
