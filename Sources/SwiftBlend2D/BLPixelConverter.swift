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
        blPixelConverterCreate(&object, &destination, &source, flags)
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
            blPixelConverterConvert(
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
    public static let initializer = blPixelConverterInit
    public static let deinitializer = blPixelConverterReset
    public static let assignWeak = blPixelConverterAssign
}
