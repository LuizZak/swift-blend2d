import blend2d

public final class BLImageCodec: BLBaseClass<BLImageCodecCore> {
    public override init() {
        super.init()
    }
    
    public init(builtInCodec: BuiltInImageCodec) {
        let codecCore = BLImageCodec._builtInCodecs.first {
            String(cString: $0.impl!.pointee.name) == builtInCodec.rawValue
        }
        
        if let codecCore = codecCore {
            super.init(borrowing: codecCore)
        } else {
            fatalError("Expected to find a valid built-in codec named '\(builtInCodec.rawValue)'")
        }
    }
    
    override init(borrowing object: BLImageCodecCore) {
        super.init(borrowing: object)
    }
}

extension BLImageCodec {
    static var _builtInCodecs: [BLImageCodecCore] = {
        guard let codecs = blImageCodecBuiltInCodecs() else {
            fatalError("Failed to load built in codecs.")
        }
        
        let array = BLArray(borrowing: codecs.pointee)
        
        return array.asArrayOfUnsafe(type: BLImageCodecCore.self)
    }()
}

public extension BLImageCodec {
    static var builtInCodecs: [BLImageCodec] = {
        return _builtInCodecs.map { object in
            BLImageCodec(borrowing: object)
        }
    }()
    
    enum BuiltInImageCodec: String, CaseIterable {
        case bmp = "BMP"
        case jpeg = "JPEG"
        case png = "PNG"
    }
}

extension BLImageCodecCore: CoreStructure {
    public static var initializer = blImageCodecInit
    public static var deinitializer = blImageCodecReset
}
