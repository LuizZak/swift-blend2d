import blend2d

public class BLFont: BLBaseClass<BLFontCore> {
    public var matrix: BLFontMatrix {
        var fontMatrix = BLFontMatrix()
        blFontGetMatrix(&object, &fontMatrix)
        return fontMatrix
    }
    
    public var metrics: BLFontMetrics {
        var metrics = BLFontMetrics()
        blFontGetMetrics(&object, &metrics)
        return metrics
    }
    
    public var designMetrics: BLFontDesignMetrics {
        var metrics = BLFontDesignMetrics()
        blFontGetDesignMetrics(&object, &metrics)
        return metrics
    }
    
    public func createFromFace(_ face: BLFontFaceCore, size: Float) {
        var face = face
        blFontCreateFromFace(&object, &face, size)
    }
    
    public func shape(_ buf: inout BLGlyphBufferCore) {
        blFontShape(&object, &buf)
    }
    
    @discardableResult
    func mapTextToGlyphs(_ buf: inout BLGlyphBufferCore) -> BLGlyphMappingState {
        var state = BLGlyphMappingState()
        blFontMapTextToGlyphs(&object, &buf, &state)
        return state
    }
    
    public func positionGlyphs(_ buf: inout BLGlyphBufferCore, positioningFlags: UInt32) {
        blFontPositionGlyphs(&object, &buf, positioningFlags)
    }
    
    public func applyKerning(_ buf: inout BLGlyphBufferCore) {
        blFontApplyKerning(&object, &buf)
    }
    
    public func applyGSub(_ buf: inout BLGlyphBufferCore, index: Int, lookups: BLBitWord) {
        blFontApplyGSub(&object, &buf, index, lookups)
    }
    
    public func applyGPos(_ buf: inout BLGlyphBufferCore, index: Int, lookups: BLBitWord) {
        blFontApplyGPos(&object, &buf, index, lookups)
    }
    
    public func getTextMetrics(_ buf: BLGlyphBufferCore) -> BLTextMetrics {
        var buf = buf
        var value = BLTextMetrics()
        blFontGetTextMetrics(&object, &buf, &value)
        return value
    }
    
    // TODO: Validate these glyph methods are working correctly with these array
    // parameter pointers
    
    func getGlyphBounds(_ glyphIdData: [BLGlyphId]) -> BLBoxI {
        var out = BLBoxI()
        blFontGetGlyphBounds(&object, glyphIdData, MemoryLayout<BLGlyphId>.size, &out, glyphIdData.count)
        
        return out
    }
    
    func getGlyphAdvances(_ glyphIdData: [BLGlyphId]) -> BLGlyphPlacement {
        var out = BLGlyphPlacement()
        blFontGetGlyphAdvances(&object, glyphIdData, MemoryLayout<BLGlyphId>.size, &out, glyphIdData.count)
        
        return out
    }
    
    // TODO: Validate these two getGlyphOutline methods- specifically what the
    // omitted 'closure' argument from each one means.
    
    func getGlyphOutlines(_ glyphId: UInt32, userMatrix: BLMatrix2D? = nil, sink: BLPathSinkFunc? = nil) -> BLPath {
        let path = BLPath()
        
        withUnsafeNullablePointer(to: userMatrix) { userMatrix in
            blFontGetGlyphOutlines(&object, glyphId, userMatrix, &path.object, sink, nil)
        }
        
        return path
    }
    
    func getGlyphRunOutlines(_ glyphRun: BLGlyphRun, userMatrix: BLMatrix2D? = nil, sink: BLPathSinkFunc? = nil) -> BLPath {
        var glyphRun = glyphRun
        let path = BLPath()
        
        withUnsafeNullablePointer(to: userMatrix) { userMatrix in
            blFontGetGlyphRunOutlines(&object, &glyphRun, userMatrix, &path.object, sink, nil)
        }
        
        return path
    }
}

extension BLFont: Equatable {
    public static func ==(lhs: BLFont, rhs: BLFont) -> Bool {
        return lhs.object.impl == rhs.object.impl
    }
}

extension BLFontCore: CoreStructure {
    public static var initializer = blFontInit
    public static var deinitializer = blFontReset
}
