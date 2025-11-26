import blend2d

public class BLFontFace: BLBaseClass<BLFontFaceCore> {
    // MARK: Font Data & Loader

    /// Gets `BLFontData` associated with this font-face.
    public var data: BLFontData {
        BLFontData(weakAssign: object.impl.data)
    }

    // MARK: Properties

    /// Returns font weight (returns default weight in case this is a variable font).
    public var weight: UInt16 {
        object.impl.weight
    }
    /// Returns font stretch (returns default weight in case this is a variable font).
    public var stretch: UInt8 {
        object.impl.stretch
    }
    /// Returns font style.
    public var style: UInt8 {
        object.impl.style
    }
    /// Returns font-face information as `BLFontFaceInfo`.
    public var faceInfo: BLFontFaceInfo {
        var info = BLFontFaceInfo()
        bl_font_face_get_face_info(&object, &info)
        return info
    }
    /// Gets font-face type.
    public var faceType: BLFontFaceType {
        BLFontFaceType(BLFontFaceType.RawValue(faceInfo.face_type))
    }
    /// Gets font-face type.
    public var outlineType: BLFontOutlineType {
        BLFontOutlineType(BLFontFaceType.RawValue(faceInfo.outline_type))
    }
    /// Gets a number of glyphs the face provides.
    public var glyphCount: UInt32 {
        faceInfo.glyph_count
    }
    /// Gets a zero-based index of this font-face.
    ///
    /// NOTE: Face index does only make sense if this face is part of a TrueType
    /// or OpenType font collection. In that case the returned value would be
    /// the index of this face in that collection. If the face is not part of a
    /// collection then the returned value would always be zero.
    public var faceIndex: UInt32 {
        faceInfo.face_index
    }
    /// Gets font-face flags.
    public var faceFlags: BLFontFaceFlags {
        BLFontFaceFlags(BLFontFaceFlags.RawValue(faceInfo.face_flags))
    }
    /// Gets font-face diagnostics flags.
    public var diagFlags: BLFontFaceDiagFlags {
        BLFontFaceDiagFlags(BLFontFaceDiagFlags.RawValue(faceInfo.diag_flags))
    }
    /// Gets a unique identifier describing this BLFontFace.
    public var faceUniqueId: BLUniqueId {
        object.impl.unique_id
    }

    /// Gets full name as UTF-8 null-terminated string.
    public var fullName: BLString {
        BLString(weakAssign: object.impl.full_name)
    }
    /// Gets family name as UTF-8 null-terminated string.
    public var familyName: BLString {
        BLString(weakAssign: object.impl.family_name)
    }
    /// Gets subfamily name as UTF-8 null-terminated string.
    public var subfamilyName: BLString {
        BLString(weakAssign: object.impl.subfamily_name)
    }
    /// Gets manufacturer name as UTF-8 null-terminated string.
    public var postScriptName: BLString {
        BLString(weakAssign: object.impl.post_script_name)
    }

    /// Returns design metrics of this `BLFontFace`.
    public var designMetrics: BLFontDesignMetrics {
        var metrics = BLFontDesignMetrics()
        bl_font_face_get_design_metrics(&object, &metrics)
        return metrics
    }
    /// Returns units per em, which are part of font's design metrics.
    public var unitsPerEm: Int32 {
        designMetrics.units_per_em
    }
    /// Returns PANOSE classification of this `BLFontFace`.
    public var panose: BLFontPanoseInfo {
        object.impl.panose_info
    }
    /// Returns coverage info of this `BLFontFace`.
    public var coverageInfo: BLFontCoverageInfo {
        object.impl.coverage_info
    }

    var info: BLFontFaceInfo {
        var info = BLFontFaceInfo()
        bl_font_face_get_face_info(&object, &info)
        return info
    }

    // MARK: - Initializers

    override init() {
        super.init()
    }

    /// Create Functionality
    /// Creates a new `BLFontFace` from file specified by `fileName`.
    ///
    /// This is a utility initializer that first creates a `BLFontLoader` and then
    /// calls `init(fromLoader: loader, faceIndex: 0)`.
    ///
    /// NOTE: This function offers a simplified creation of `BLFontFace` directly
    /// from a file, but doesn't provide as much flexibility as `init(fromLoader:faceIndex:)`
    /// as it allows to specify a `faceIndex`, which can be used to load multiple
    /// font faces from TrueType/OpenType collections. The use of `init(fromLoader:faceIndex:)`
    /// is recommended for any serious font handling.
    public init(fromFile filePath: String, readFlags: BLFileReadFlags = []) throws {
        try super.init { pointer -> BLResult in
            bl_font_face_init(pointer)

            return try mapError { bl_font_face_create_from_file(pointer, filePath, readFlags) }
                .addFileErrorMappings(filePath: filePath)
                .execute()
        }
    }

    public override init(weakAssign object: BLFontFaceCore) {
        super.init(weakAssign: object)
    }
}

extension BLFontFace: Equatable {
    public static func == (lhs: BLFontFace, rhs: BLFontFace) -> Bool {
        bl_font_face_equals(&lhs.object, &rhs.object)
    }
}

extension BLFontFaceCore: CoreStructure {
    public static let initializer = bl_font_face_init
    public static let deinitializer = bl_font_face_reset
    public static let assignWeak = bl_font_face_assign_weak

    @usableFromInline
    var impl: BLFontFaceImpl {
        get { UnsafeMutablePointer(_d.impl)!.pointee }
        set { UnsafeMutablePointer(_d.impl)!.pointee = newValue }
    }
}
