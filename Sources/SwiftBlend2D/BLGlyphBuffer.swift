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

    public init(glyphs: [UInt32]) {
        super.init()
        setGlyphs(glyphs)
    }
    
    public func clear() {
        blGlyphBufferClear(&object)
    }

    /// Sets a text in this glyph buffer.
    ///
    /// - Parameter text: A textual string
    /// - Parameter length: The length, in bytes, of the text value to set.
    /// Passing `nil` to indicate the entire text string should be used.
    public func setText<S: StringProtocol>(_ text: S, length: Int? = nil) {
        text.withCString { pointer -> Void in
            blGlyphBufferSetText(&object,
                                 pointer,
                                 length ?? text.utf8.count,
                                 BLTextEncoding.utf8.rawValue)
        }
    }
    
    public func setGlyphs(_ glyphs: [UInt32]) {
        glyphs.withUnsafeBufferPointer { pointer -> Void in
            guard let pointer = pointer.baseAddress else {
                return
            }
            
            blGlyphBufferSetGlyphs(&object,
                                   pointer,
                                   glyphs.count)
        }
    }
}

extension BLGlyphBufferCore: CoreStructure {
    public static let initializer = blGlyphBufferInit
    public static let deinitializer = blGlyphBufferReset
    public static let assignWeak = emptyAssignWeak(type: BLGlyphBufferCore.self)
}
