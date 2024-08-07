// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

/// The type of a text rendering operation.
/// 
/// This value specifies the type of the parameter passed to the text rendering API.
/// 
/// - note: In most cases this should not be required to use by Blend2D users. The C API provides functions that
/// wrap all of the text operations and C++ API provides functions that use `BLContextRenderTextOp` internally.
public extension BLContextRenderTextOp {
    /// UTF-8 text rendering operation - UTF-8 string passed as `BLStringView` or `BLArrayView<uint8_t>`.
    static let utf8 = BL_CONTEXT_RENDER_TEXT_OP_UTF8
    
    /// UTF-16 text rendering operation - UTF-16 string passed as `BLArrayView<uint16_t>`.
    static let utf16 = BL_CONTEXT_RENDER_TEXT_OP_UTF16
    
    /// UTF-32 text rendering operation - UTF-32 string passed as `BLArrayView<uint32_t>`.
    static let utf32 = BL_CONTEXT_RENDER_TEXT_OP_UTF32
    
    /// LATIN1 text rendering operation - LATIN1 string is passed as `BLStringView` or `BLArrayView<uint8_t>`.
    static let latin1 = BL_CONTEXT_RENDER_TEXT_OP_LATIN1
    
    /// `wchar_t` text rendering operation - wchar_t string is passed as `BLArrayView<wchar_t>`.
    static let wchar = BL_CONTEXT_RENDER_TEXT_OP_WCHAR
    
    /// Glyph run text rendering operation - the `BLGlyphRun` parameter is passed.
    static let glyphRun = BL_CONTEXT_RENDER_TEXT_OP_GLYPH_RUN
    
    /// Maximum value of `BLContextRenderTextInputType`
    static let maxValue = BL_CONTEXT_RENDER_TEXT_OP_MAX_VALUE
}
