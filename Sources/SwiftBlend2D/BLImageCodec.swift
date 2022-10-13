import blend2d
import Foundation

public final class BLImageCodec: BLBaseClass<BLImageCodecCore> {
    /// Returns image codec name (i.e, "PNG", "JPEG", etc...).
    public var name: String {
        BLString(weakAssign: object.impl.name).toString()
    }
    
    /// Returns the image codec vendor (i.e. "Blend2D" for all built-in codecs).
    public var vendor: String {
        BLString(weakAssign: object.impl.vendor).toString()
    }
    
    /// Returns a mime-type associated with the image codec's format.
    public var mimeType: String {
        BLString(weakAssign: object.impl.mimeType).toString()
    }

    /// Known file extensions used by this image codec separated by "|".
    public var extensions: [String] {
        BLString(weakAssign: object.impl.extensions).toString().split(separator: "|").map(String.init)
    }
    
    /// Returns image codec flags, see `BLImageCodecFeatures`.
    public var features: BLImageCodecFeatures {
        BLImageCodecFeatures(BLImageCodecFeatures.RawValue(object.impl.features))
    }
    
    public override init() {
        super.init()
    }
    
    public init(builtInCodec: BuiltInImageCodec) {
        let codecCore = BLImageCodec._builtInCodecs.first {
            BLString(weakAssign: $0.impl.name).toString() == builtInCodec.rawValue
        }
        
        if let codecCore = codecCore {
            super.init(weakAssign: codecCore)
        } else {
            fatalError("Expected to find a valid built-in codec named '\(builtInCodec.rawValue)'")
        }
    }
    
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
        super.init(initializer: blImageCodecInit)
        
        let result: BLResult? = data.withUnsafeBytes { pointer in
            guard let pointer = pointer.baseAddress else {
                return nil
            }
            
            return blImageCodecFindByData(&object, pointer, data.count, nil)
        }
        
        guard let result = result else {
            return nil
        }

        if result != BL_SUCCESS.rawValue {
            return nil
        }
    }
    
    override init(weakAssign object: BLImageCodecCore) {
        super.init(weakAssign: object)
    }
    
    public func inspectData(_ data: Data) -> Int {
        data.withUnsafeBytes { pointer in
            inspectData(pointer)
        }
    }
    
    func inspectData(_ pointer: UnsafeRawBufferPointer) -> Int {
        guard let dataAddress = pointer.baseAddress else {
            return 0
        }
        
        return Int(blImageCodecInspectData(&object, dataAddress, pointer.count))
    }
    
    func createDecoder(dst: BLImageDecoderCore) -> BLResult {
        var dst = dst
        return blImageCodecCreateDecoder(&object, &dst)
    }
    
    func createEncoder(dst: BLImageEncoderCore) -> BLResult {
        var dst = dst
        return blImageCodecCreateEncoder(&object, &dst)
    }
}

extension BLImageCodec {
    static var _builtInCodecs: [BLImageCodecCore] = {
        let array = BLArray<BLImageCodecCore>()
        
        blImageCodecArrayInitBuiltInCodecs(&array.object)
        
        return array.unsafeAsArray(of: BLImageCodecCore.self)
    }()
}

public extension BLImageCodec {
    static var builtInCodecs: [BLImageCodec] = {
        _builtInCodecs.map { object in
            BLImageCodec(weakAssign: object)
        }
    }()
    
    enum BuiltInImageCodec: String, CaseIterable {
        case bmp = "BMP"
        case jpeg = "JPEG"
        case png = "PNG"
    }
}

extension BLImageCodec: Equatable {
    public static func == (lhs: BLImageCodec, rhs: BLImageCodec) -> Bool {
        lhs.object._d.impl == rhs.object._d.impl
    }
}

extension BLImageCodecCore: CoreStructure {
    public static let initializer = blImageCodecInit
    public static let deinitializer = blImageCodecReset
    public static let assignWeak = blImageCodecAssignWeak

    @usableFromInline
    var impl: BLImageCodecImpl {
        get {
            _d.impl!.load(as: BLImageCodecImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLImageCodecImpl.self)
        }
    }
}
