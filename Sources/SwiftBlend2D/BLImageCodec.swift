import blend2d

public class BLImageCodec {
    var codec = BLImageCodecCore()
    
    public init() {
        blImageCodecInit(&codec)
    }
    
    deinit {
        blImageCodecReset(&codec)
    }
    
    public func findByName(_ codecs: UnsafePointer<BLArrayCore>, name: String) throws {
        try handleErrorResults(
            blImageCodecFindByName(&codec, codecs, name)
        )
    }
}

public extension BLImageCodec {
    static var buildInCodecs: UnsafeMutablePointer<BLArrayCore> {
        return blImageCodecBuiltInCodecs()
    }
}
