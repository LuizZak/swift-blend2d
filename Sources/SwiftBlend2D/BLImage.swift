import blend2d

public class BLImage: BLBaseClass<BLImageCore> {
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
    
    public func writeToFile(_ path: String, codec: BLImageCodec) throws {
        try handleErrorResults(
            blImageWriteToFile(&object, path, &codec.object)
        )
    }
    
    func writeToData(_ buffer: BLArray, codec: BLImageCodec) throws {
        try handleErrorResults(
            blImageWriteToData(&object, &buffer.object, &codec.object)
        )
    }
}

extension BLImageCore: CoreStructure {
    public static var initializer = blImageInit
    public static var deinitializer = blImageReset
}
