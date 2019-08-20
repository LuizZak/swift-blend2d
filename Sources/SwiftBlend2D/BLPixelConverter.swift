import blend2d

public class BLPixelConverter: BLBaseClass<BLPixelConverterCore> {
    public init(source: BLFormatInfo, destination: BLFormatInfo) {
        super.init()
        
        var source = source
        var destination = destination
        blPixelConverterCreate(&object, &destination, &source)
    }
    
    @discardableResult
    public func convert(dstData: UnsafeMutableRawPointer,
                        dstStride: Int,
                        srcData: UnsafeRawPointer,
                        srcStride: Int,
                        width: UInt32,
                        height: UInt32,
                        options: BLPixelConverterOptions? = nil) -> BLResult {
        
        return withUnsafeNullablePointer(to: options) { options in
            return blPixelConverterConvert(&object, dstData, dstStride, srcData,
                                           srcStride, width, height, options)
        }
    }
}

extension BLPixelConverterCore: CoreStructure {
    public static var initializer = blPixelConverterInit
    public static var deinitializer = blPixelConverterReset
    public static var assignWeak = blPixelConverterAssign
}
