import blend2d

public class BLImage {
    var image = BLImageCore()
    
    public init() {
        blImageInit(&image)
    }
    
    public init(width: Int, height: Int, format: BLFormat) {
        blImageInitAs(&image, Int32(width), Int32(height), format.rawValue)
    }
    
    deinit {
        blImageReset(&image)
    }
    
    public func writeToFile(_ path: String, codec: BLImageCodec) throws {
        try handleErrorResults(
            blImageWriteToFile(&image, path, &codec.codec)
        )
    }
}
