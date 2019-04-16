import blend2d

public final class BLImage: BLBaseClass<BLImageCore> {
    /// Maximum width of an image.
    static var maximumWidth: Int {
        return Int(BL_RUNTIME_MAX_IMAGE_SIZE.rawValue)
    }
    /// Maximum height of an image.
    static var maximumHeight: Int {
        return Int(BL_RUNTIME_MAX_IMAGE_SIZE.rawValue)
    }
    
    public var width: Int {
        return Int(object.impl.pointee.size.w)
    }
    public var height: Int {
        return Int(object.impl.pointee.size.h)
    }
    public var size: BLSizeI {
        return object.impl.pointee.size
    }
    
    /// The image format.
    public var format: BLFormat {
        return BLFormat(rawValue: BLFormat.RawValue(object.impl.pointee.format))
    }
    
    public override init() {
        super.init()
    }
    
    /// Initializes a new image with the given dimensions and format.
    ///
    /// - Parameters:
    ///   - width: Width of image. Must be greater than zero and less than BLImage.maximumWidth.
    ///   - height: Height of image. Must be greater than zero and less than BLImage.maximumHeight.
    ///   - format: A valid image format to use for the image.
    public init(width: Int, height: Int, format: BLFormat) {
        precondition(width > 0 && width < BLImage.maximumWidth)
        precondition(height > 0 && height < BLImage.maximumHeight)
        
        super.init {
            blImageInitAs($0, Int32(width), Int32(height), format.rawValue)
        }
    }
    
    public func equals(to other: BLImage) -> Bool {
        return blImageEquals(&object, &other.object)
    }
    
    public func scale(size: BLSizeI, filter: BLImageScaleFilter, options: BLImageScaleOptions? = nil) throws {
        var size = size
        var options = options
        
        try resultToError(
            blImageScale(&object, &object, &size, filter.rawValue, makeNullablePointer(&options))
        )
    }
    
    public func writeToFile(_ path: String, codec: BLImageCodec) throws {
        try resultToError(
            blImageWriteToFile(&object, path, &codec.object)
        )
    }
    
    func writeToData(_ buffer: BLArray, codec: BLImageCodec) throws {
        try resultToError(
            blImageWriteToData(&object, &buffer.object, &codec.object)
        )
    }
    
    public func readFromData(_ data: [UInt8], codecs: [BLImageCodec]) throws {
        let array = BLArray(type: BL_IMPL_TYPE_ARRAY_U8)
        for item in data {
            array.append(item)
        }
        
        try readFromData(array, codecs: codecs)
    }
    
    func readFromData(_ buffer: BLArray, codecs: [BLImageCodec]) throws {
        let codecsArray = BLArray(type: BL_IMPL_TYPE_ARRAY_VAR)
        for codec in codecs {
            codecsArray.append(&codec.object)
        }
        
        try resultToError(
            blImageReadFromData(&object, buffer.unsafePointer().baseAddress, buffer.count, &codecsArray.object)
        )
    }
}

extension BLImageCore: CoreStructure {
    public static var initializer = blImageInit
    public static var deinitializer = blImageReset
}
