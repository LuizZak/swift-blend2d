import blend2d

public class BLPixelConverter: BLBaseClass<BLPixelConverterCore> {
    public init(
        source: BLFormatInfo,
        destination: BLFormatInfo,
        flags: BLPixelConverterCreateFlags
    ) {

        super.init()

        var source = source
        var destination = destination
        bl_pixel_converter_create(&object, &destination, &source, flags)
    }

    @discardableResult
    public func convert(
        dstData: UnsafeMutableRawPointer,
        dstStride: Int,
        srcData: UnsafeRawPointer,
        srcStride: Int,
        width: UInt32,
        height: UInt32,
        options: BLPixelConverterOptions? = nil
    ) -> BLResult {

        withUnsafeNullablePointer(to: options) { options in
            bl_pixel_converter_convert(
                &object,
                dstData,
                dstStride,
                srcData,
                srcStride,
                width,
                height,
                options
            )
        }
    }
}

extension BLPixelConverterCore: CoreStructure {
    public static let initializer = bl_pixel_converter_init
    public static let deinitializer = bl_pixel_converter_reset
    public static let assignWeak = bl_pixel_converter_assign
}
