// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Flags used by `BLPixelConverter::create()` function.
extension BLPixelConverterCreateFlags: OptionSet { }

public extension BLPixelConverterCreateFlags {
    /// No flags.
    static let noFlags = BL_PIXEL_CONVERTER_CREATE_NO_FLAGS
    
    /// Specifies that the source palette in `BLFormatInfo` doesn't have to by copied by `BLPixelConverter`. The caller
    /// must ensure that the palette would stay valid until the pixel converter is destroyed.
    static let dontCopyPalette = BL_PIXEL_CONVERTER_CREATE_FLAG_DONT_COPY_PALETTE
    
    /// Specifies that the source palette in `BLFormatInfo` is alterable and the pixel converter can modify it when
    /// preparing the conversion. The modification can be irreversible so only use this flag when you are sure that
    /// the palette passed to `BLPixelConverter::create()` won't be needed outside of pixel conversion.
    /// 
    /// - note: The flag `BLPixelConverterCreateFlags.dontCopyPalette` must be set as well, otherwise this flag would
    /// be ignored.
    static let alterablePalette = BL_PIXEL_CONVERTER_CREATE_FLAG_ALTERABLE_PALETTE
    
    /// When there is no built-in conversion between the given pixel formats it's possible to use an intermediate format
    /// that is used during conversion. In such case the base pixel converter creates two more converters that are then
    /// used internally.
    /// 
    /// This option disables such feature - creating a pixel converter would fail with `BLResultCode.errorNotImplemented` error
    /// if direct conversion is not possible.
    static let noMultiStep = BL_PIXEL_CONVERTER_CREATE_FLAG_NO_MULTI_STEP
}
