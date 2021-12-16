// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Pixel format flags.
extension BLFormatFlags: OptionSet { }

public extension BLFormatFlags {
    /// No flags.
    static let noFlags = BL_FORMAT_NO_FLAGS
    
    /// Pixel format provides RGB components.
    static let rgb = BL_FORMAT_FLAG_RGB
    
    /// Pixel format provides only alpha component.
    static let alpha = BL_FORMAT_FLAG_ALPHA
    
    /// A combination of `BL_FORMAT_FLAG_RGB | BL_FORMAT_FLAG_ALPHA`.
    static let rgba = BL_FORMAT_FLAG_RGBA
    
    /// Pixel format provides LUM component (and not RGB components).
    static let lum = BL_FORMAT_FLAG_LUM
    
    /// A combination of `BL_FORMAT_FLAG_LUM | BL_FORMAT_FLAG_ALPHA`.
    static let luma = BL_FORMAT_FLAG_LUMA
    
    /// Indexed pixel format the requres a palette (I/O only).
    static let indexed = BL_FORMAT_FLAG_INDEXED
    
    /// RGB components are premultiplied by alpha component.
    static let premultiplied = BL_FORMAT_FLAG_PREMULTIPLIED
    
    /// Pixel format doesn't use native byte-order (I/O only).
    static let byteSwap = BL_FORMAT_FLAG_BYTE_SWAP
    
    /// Pixel components are byte aligned (all 8bpp).
    static let byteAligned = BL_FORMAT_FLAG_BYTE_ALIGNED
    
    /// Pixel has some undefined bits that represent no information.
    /// 
    /// For example a 32-bit XRGB pixel has 8 undefined bits that are usually set to all ones so the format can be
    /// interpreted as premultiplied RGB as well. There are other formats like 16_0555 where the bit has no information
    /// and is usually set to zero. Blend2D doesn't rely on the content of such bits.
    static let undefinedBits = BL_FORMAT_FLAG_UNDEFINED_BITS
    
    /// Convenience flag that contains either zero or `BL_FORMAT_FLAG_BYTE_SWAP` depending on host byte order. Little
    /// endian hosts have this flag set to zero and big endian hosts to `BL_FORMAT_FLAG_BYTE_SWAP`.
    /// 
    /// \note This is not a real flag that you can test, it's only provided for convenience to define little endian
    /// pixel formats.
    static let le = BL_FORMAT_FLAG_LE
    
    /// Convenience flag that contains either zero or `BL_FORMAT_FLAG_BYTE_SWAP` depending on host byte order. Big
    /// endian hosts have this flag set to zero and little endian hosts to `BL_FORMAT_FLAG_BYTE_SWAP`.
    /// 
    /// \note This is not a real flag that you can test, it's only provided for convenience to define big endian
    /// pixel formats.
    static let be = BL_FORMAT_FLAG_BE
}
