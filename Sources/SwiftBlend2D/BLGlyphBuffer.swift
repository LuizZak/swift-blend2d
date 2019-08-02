import blend2d

public class BLGlyphBuffer: BLBaseClass<BLGlyphBufferCore> {
    @inlinable
    public var glyphRun: BLGlyphRun {
        return object.impl.pointee.glyphRun
    }

    /// Gets the glyph ids from this buffer.
    ///
    /// - complexity: O(size)
    public var glyphIds: [BLGlyphId] {
        var glyphs: [BLGlyphId] = []
        glyphs.reserveCapacity(glyphRun.size)
        var iterator = BLGlyphRunIterator(glyphRun: glyphRun)
        while !iterator.atEnd {
            if let glyphId = iterator.glyphId() {
                glyphs.append(glyphId)
            }
            iterator.advance()
        }

        return glyphs
    }
    
    public override init() {
        super.init()
    }
    
    public init<S: StringProtocol>(text: S) {
        super.init()
        setText(text)
    }

    public init(glyphIds: [BLGlyphId]) {
        super.init()
        setGlyphIds(glyphIds)
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
