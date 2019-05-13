import blend2d

public class BLGlyphBuffer: BLBaseClass<BLGlyphBufferCore> {
    public var glyphRun: BLGlyphRun {
        return object.impl.pointee.glyphRun
    }
    
    public override init() {
        super.init()
    }
    
    public func clear() {
        blGlyphBufferClear(&object)
    }
    
    public func setText<S: StringProtocol>(_ text: S, length: Int? = nil) {
        text.withCString { pointer -> Void in
            blGlyphBufferSetText(&object,
                                 pointer,
                                 length ?? text.utf8.count,
                                 BLTextEncoding.utf8.rawValue)
        }
    }
    
    public func setGlyphIds(_ glyphIds: [BLGlyphId]) {
        glyphIds.withUnsafeBytes { pointer -> Void in
            guard let pointer = pointer.baseAddress else {
                return
            }
            
            blGlyphBufferSetGlyphIds(&object,
                                     pointer,
                                     MemoryLayout<BLGlyphId>.stride,
                                     glyphIds.count)
        }
    }
}

extension BLGlyphBufferCore: CoreStructure {
    public static var initializer = blGlyphBufferInit
    public static var deinitializer = blGlyphBufferReset
    public static var assignWeak = emptyAssignWeak(type: BLGlyphBufferCore.self)
}
