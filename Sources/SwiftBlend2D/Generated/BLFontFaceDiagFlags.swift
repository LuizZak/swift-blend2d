// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Diagnostic flags offered by `BLFontFace` (or `BLFontFaceCore`).
extension BLFontFaceDiagFlags: OptionSet { }

public extension BLFontFaceDiagFlags {
    /// No flags.
    static let noFlags = BL_FONT_FACE_DIAG_NO_FLAGS
    
    /// Wrong data in 'name' table.
    static let wrongNameData = BL_FONT_FACE_DIAG_WRONG_NAME_DATA
    
    /// Fixed data read from 'name' table and possibly fixed font family/subfamily name.
    static let fixedNameData = BL_FONT_FACE_DIAG_FIXED_NAME_DATA
    
    /// Wrong data in 'kern' table [kerning disabled].
    static let wrongKernData = BL_FONT_FACE_DIAG_WRONG_KERN_DATA
    
    /// Fixed data read from 'kern' table so it can be used.
    static let fixedKernData = BL_FONT_FACE_DIAG_FIXED_KERN_DATA
    
    /// Wrong data in 'cmap' table.
    static let wrongCmapData = BL_FONT_FACE_DIAG_WRONG_CMAP_DATA
    
    /// Wrong format in 'cmap' (sub)table.
    static let wrongCmapFormat = BL_FONT_FACE_DIAG_WRONG_CMAP_FORMAT
    
    /// Wrong data in 'GDEF' table.
    static let wrongGdefData = BL_FONT_FACE_DIAG_WRONG_GDEF_DATA
    
    /// Wrong data in 'GPOS' table.
    static let wrongGposData = BL_FONT_FACE_DIAG_WRONG_GPOS_DATA
    
    /// Wrong data in 'GSUB' table.
    static let wrongGsubData = BL_FONT_FACE_DIAG_WRONG_GSUB_DATA
}
