import blend2d

public class BLGlyphBuffer: BLBaseClass<BLGlyphBufferCore> {
    public func clear() {
        blGlyphBufferClear(&object)
    }
    
    public func setText(_ text: String) {
        text.withCString { pointer -> Void in
            blGlyphBufferSetText(&object,
                                 UnsafeRawPointer(pointer),
                                 text.utf8CString.count,
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
