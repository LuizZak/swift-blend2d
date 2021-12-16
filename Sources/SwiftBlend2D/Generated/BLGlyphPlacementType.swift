// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Placement of glyphs stored in a \ref BLGlyphRun.
public extension BLGlyphPlacementType {
    /// No placement (custom handling by \ref BLPathSinkFunc).
    static let none = BL_GLYPH_PLACEMENT_TYPE_NONE
    
    /// Each glyph has a BLGlyphPlacement (advance + offset).
    static let advanceOffset = BL_GLYPH_PLACEMENT_TYPE_ADVANCE_OFFSET
    
    /// Each glyph has a BLPoint offset in design-space units.
    static let designUnits = BL_GLYPH_PLACEMENT_TYPE_DESIGN_UNITS
    
    /// Each glyph has a BLPoint offset in user-space units.
    static let userUnits = BL_GLYPH_PLACEMENT_TYPE_USER_UNITS
    
    /// Each glyph has a BLPoint offset in absolute units.
    static let absoluteUnits = BL_GLYPH_PLACEMENT_TYPE_ABSOLUTE_UNITS
    
    /// Maximum value of `BLGlyphPlacementType`.
    static let maxValue = BL_GLYPH_PLACEMENT_TYPE_MAX_VALUE
}
