import blend2d

public class BLGlyphBuffer: BLBaseClass<BLGlyphBufferCore> {
    @inlinable
    public var glyphRun: BLGlyphRun {
        return object.impl.pointee.glyphRun
    }

    /// Gets the glyph ids from this buffer.
    ///
    /// - complexity: O(size)
    public var glyphIds: [UInt32] {
        var glyphs: [UInt32] = []
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

    public init(glyphIds: [UInt32]) {
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
    
    public func setGlyphIds(_ glyphIds: [UInt32]) {
        glyphIds.withUnsafeBytes { pointer -> Void in
            guard let pointer = pointer.baseAddress else {
                return
            }
            
            blGlyphBufferSetGlyphIds(&object,
                                     pointer,
                                     MemoryLayout<UInt32>.stride,
                                     glyphIds.count)
        }
    }
}

extension BLGlyphBufferCore: CoreStructure {
    public static let initializer = blGlyphBufferInit
    public static let deinitializer = blGlyphBufferReset
    public static let assignWeak = emptyAssignWeak(type: BLGlyphBufferCore.self)
}
