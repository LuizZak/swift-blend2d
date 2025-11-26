import blend2d

public class BLFont: BLBaseClass<BLFontCore> {
    /// Returns a 2x2 matrix of the font.
    ///
    /// The returned `BLFontMatrix` is used to scale fonts from design units
    /// into user units. The matrix usually has a negative `m11` member as
    /// fonts use a different coordinate system than Blend2D.
    public var matrix: BLFontMatrix {
        var fontMatrix = BLFontMatrix()
        bl_font_get_matrix(&object, &fontMatrix)
        return fontMatrix
    }

    /// Returns the scaled metrics of the font.
    ///
    /// The returned metrics is a scale of design metrics that match the font
    /// size and its options.
    public var metrics: BLFontMetrics {
        var metrics = BLFontMetrics()
        bl_font_get_metrics(&object, &metrics)
        return metrics
    }

    /// Returns the design metrics of the font.
    ///
    /// The returned metrics is compatible with the metrics of `BLFontFace`
    /// associated with this font.
    public var designMetrics: BLFontDesignMetrics {
        var metrics = BLFontDesignMetrics()
        bl_font_get_design_metrics(&object, &metrics)
        return metrics
    }

    /// Returns the type of the font's associated font-face, see `BLFontFaceType`.
    public var faceType: BLFontFaceType {
        face.faceType
    }
    /// Returns the flags of the font, see `BLFontFaceFlags`.
    public var faceFlags: BLFontFaceFlags {
        face.faceFlags
    }
    /// Gets the size of the font (as float).
    public var size: Float {
        metrics.size
    }
    /// Gets the "units per em" (UPEM) of the font's associated font-face.
    public var unitsPerEm: Int32 {
        face.unitsPerEm
    }

    /// Returns the font's associated font-face.
    ///
    /// Returns the same font-face, which was passed to `init(fromFace:size:)`.
    public var face: BLFontFace {
        BLFontFace(weakAssign: object.impl.face)
    }

    /// Gets font-features of the font.
    public var features: BLFontFeatureSettings {
        BLFontFeatureSettings(weakAssign: object.impl.feature_settings)
    }
    /// Gets font-variations used by this font.
    public var variations: BLFontVariationSettings {
        BLFontVariationSettings(weakAssign: object.impl.variation_settings)
    }

    /// Gets the weight of the font.
    public var weight: BLFontWeight {
        BLFontWeight(BLFontWeight.RawValue(object.impl.weight))
    }
    /// Gets the stretch of the font.
    public var stretch: BLFontStretch {
        BLFontStretch(BLFontStretch.RawValue(object.impl.stretch))
    }
    /// Gets the style of the font.
    public var style: BLFontStyle {
        BLFontStyle(BLFontStyle.RawValue(object.impl.style))
    }

    public init(fromFace face: BLFontFace, size: Float) {
        super.init { pointer -> BLResult in
            bl_font_init(pointer)
            return bl_font_create_from_face(pointer, &face.object, size)
        }
    }

    public func shape(_ buf: BLGlyphBuffer) {
        bl_font_shape(&object, &buf.object)
    }

    @discardableResult
    public func mapTextToGlyphs(_ buffer: BLGlyphBuffer) -> BLGlyphMappingState {
        var state = BLGlyphMappingState()
        bl_font_map_text_to_glyphs(&object, &buffer.object, &state)
        return state
    }

    public func positionGlyphs(_ buf: BLGlyphBuffer) {
        bl_font_position_glyphs(&object, &buf.object)
    }

    public func applyKerning(_ buf: BLGlyphBuffer) {
        bl_font_apply_kerning(&object, &buf.object)
    }

    public func applyGSub(_ buf: BLGlyphBuffer, lookups: BLBitArray) {
        bl_font_apply_gsub(&object, &buf.object, &lookups.box.object)
    }

    public func applyGPos(_ buf: BLGlyphBuffer, lookups: BLBitArray) {
        bl_font_apply_gpos(&object, &buf.object, &lookups.box.object)
    }

    @inlinable
    public func getTextMetrics<S: StringProtocol>(_ string: S) -> BLTextMetrics {
        let buffer = BLGlyphBuffer()
        buffer.setText(string)
        return getTextMetrics(buffer)
    }

    @inlinable
    public func getTextMetrics(_ buf: BLGlyphBuffer) -> BLTextMetrics {
        var value = BLTextMetrics()
        bl_font_get_text_metrics(&object, &buf.object, &value)
        return value
    }

    public func getGlyphBounds(_ glyphRun: BLGlyphRun) -> [BLBoxI] {
        var out: [BLBoxI] = .init(repeating: .empty, count: glyphRun.size)

        bl_font_get_glyph_bounds(
            &object,
            glyphRun.glyph_data?.bindMemory(to: UInt32.self, capacity: glyphRun.size),
            Int(glyphRun.glyph_advance),
            &out,
            glyphRun.size
        )

        return out
    }

    public func getGlyphAdvances(_ glyphRun: BLGlyphRun) -> [BLGlyphPlacement] {
        var out: [BLGlyphPlacement] = .init(
            repeating: BLGlyphPlacement(),
            count: glyphRun.size
        )

        bl_font_get_glyph_advances(
            &object,
            glyphRun.glyph_data?.bindMemory(to: UInt32.self, capacity: glyphRun.size),
            Int(glyphRun.glyph_advance),
            &out,
            glyphRun.size
        )

        return out
    }

    public func getGlyphOutlines(
        _ glyphId: UInt32,
        userMatrix: BLMatrix2D? = nil
    ) -> BLPath {

        getGlyphOutlines(glyphId, userMatrix: userMatrix) { (_, _) -> BLResult in
            BLResult(BL_SUCCESS.rawValue)
        }
    }

    public func getGlyphOutlines(
        _ glyphId: UInt32,
        userMatrix: BLMatrix2D? = nil,
        sink: (BLPath, BLGlyphOutlineSinkInfo) -> BLResult
    ) -> BLPath {

        return withTemporaryPathSink(sink) { (sink, closure) in
            let path = BLPath()

            withUnsafeNullablePointer(to: userMatrix) { userMatrix in
                bl_font_get_glyph_outlines(&object, glyphId, userMatrix, &path.object, sink, closure)
            }

            return path
        }
    }

    public func getGlyphRunOutlines(
        _ glyphRun: BLGlyphRun,
        userMatrix: BLMatrix2D? = nil
    ) -> BLPath {

        getGlyphRunOutlines(glyphRun, userMatrix: userMatrix) { (_, _) -> BLResult in
            BLResult(BL_SUCCESS.rawValue)
        }
    }

    public func getGlyphRunOutlines(
        _ glyphRun: BLGlyphRun,
        userMatrix: BLMatrix2D? = nil,
        sink: (BLPath, BLGlyphOutlineSinkInfo) -> BLResult
    ) -> BLPath {

        return withTemporaryPathSink(sink) { (sink, closure) in
            var glyphRun = glyphRun
            let path = BLPath()

            withUnsafeNullablePointer(to: userMatrix) { userMatrix in
                bl_font_get_glyph_run_outlines(&object, &glyphRun, userMatrix, &path.object, sink, closure)
            }

            return path
        }
    }

    private func withTemporaryPathSink<T>(
        _ original: (BLPath, BLGlyphOutlineSinkInfo) -> BLResult,
        do closure: (@escaping BLPathSinkFunc, UnsafeMutableRawPointer) -> T
    ) -> T {

        let pathSink: BLPathSinkFunc = { (path, outline, closure) -> BLResult in
            guard let glyphSinkInfo = outline?.load(as: BLGlyphOutlineSinkInfo.self) else {
                return BLResult(BL_SUCCESS.rawValue)
            }
            let castSink = closure!.load(as: ((BLPath, BLGlyphOutlineSinkInfo) -> BLResult).self)
            return castSink(BLPath(pointer: path!), glyphSinkInfo)
        }

        var original = original
        return closure(pathSink, &original)
    }
}

extension BLFont: Equatable {
    public static func == (lhs: BLFont, rhs: BLFont) -> Bool {
        lhs.object._d.impl == rhs.object._d.impl
    }
}

extension BLFontCore: CoreStructure {
    public static let initializer = bl_font_init
    public static let deinitializer = bl_font_reset
    public static let assignWeak = bl_font_assign_weak

    @usableFromInline
    var impl: BLFontImpl {
        get { UnsafeMutablePointer(_d.impl)!.pointee }
        set { UnsafeMutablePointer(_d.impl)!.pointee = newValue }
    }
}
