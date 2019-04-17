import blend2d
#if canImport(Foundation)
import Foundation
#endif

public final class BLImageCodec: BLBaseClass<BLImageCodecCore> {
    public var name: String {
        return String(cString: object.impl.pointee.name)
    }
    
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
    
    #if canImport(Foundation)
    
    /// Initializes the image codec which is most likely capable of handling the
    /// given image data.
    ///
    /// The resulting image codec is only a candidate, and not guaranteed to be
    /// able to decode the image data fully, even if the initializer creates a
    /// non-nil object.
    ///
    /// - Parameter data: A data blob containing a binary image format.
    /// - SeeAlso: `BuiltInImageCodec`
    public init?(bestCandidateFor data: Data) {
        super.init(object: BLImageCodecCore(), ownership: .borrowed)
        
        blImageCodecInit(&object)
        
        let result: BLResult? = data.withUnsafeBytes { pointer in
            guard let pointer = pointer.baseAddress else {
                return nil
            }
            
            return blImageCodecFindByData(&object, blImageCodecBuiltInCodecs(), pointer, data.count)
        }
        
        if result != BL_SUCCESS.rawValue {
            return nil
        }
    }
    
    #endif
    
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
