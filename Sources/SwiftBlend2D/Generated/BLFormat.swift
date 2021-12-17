// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Pixel format.
/// 
/// Compatibility Table
/// -------------------
/// 
/// ```
/// +---------------------+---------------------+-----------------------------+
/// | Blend2D Format      | Cairo Format        | QImage::Format              |
/// +---------------------+---------------------+-----------------------------+
/// | BL_FORMAT_PRGB32    | CAIRO_FORMAT_ARGB32 | Format_ARGB32_Premultiplied |
/// | BL_FORMAT_XRGB32    | CAIRO_FORMAT_RGB24  | Format_RGB32                |
/// | BL_FORMAT_A8        | CAIRO_FORMAT_A8     | n/a                         |
/// +---------------------+---------------------+-----------------------------+
/// ```
public extension BLFormat {
    /// None or invalid pixel format.
    static let none = BL_FORMAT_NONE
    
    /// 32-bit premultiplied ARGB pixel format (8-bit components).
    static let prgb32 = BL_FORMAT_PRGB32
    
    /// 32-bit (X)RGB pixel format (8-bit components, alpha ignored).
    static let xrgb32 = BL_FORMAT_XRGB32
    
    /// 8-bit alpha-only pixel format.
    static let a8 = BL_FORMAT_A8
    
    static let maxValue = BL_FORMAT_MAX_VALUE
    
    /// Count of pixel formats (reserved for future use).
    static let reservedCount = BL_FORMAT_RESERVED_COUNT
}