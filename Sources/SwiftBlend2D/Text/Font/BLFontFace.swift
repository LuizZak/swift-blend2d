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
        blFontFaceGetFaceInfo(&object, &info)
        return info
    }
    /// Gets font-face type.
    public var faceType: BLFontFaceType {
        BLFontFaceType(BLFontFaceType.RawValue(faceInfo.faceType))
    }
    /// Gets font-face type.
    public var outlineType: BLFontOutlineType {
        BLFontOutlineType(BLFontFaceType.RawValue(faceInfo.outlineType))
    }
    /// Gets a number of glyphs the face provides.
    public var glyphCount: UInt16 {
        faceInfo.glyphCount
    }
    /// Gets a zero-based index of this font-face.
    ///
    /// NOTE: Face index does only make sense if this face is part of a TrueType
    /// or OpenType font collection. In that case the returned value would be
    /// the index of this face in that collection. If the face is not part of a
    /// collection then the returned value would always be zero.
    public var faceIndex: UInt32 {
        faceInfo.faceIndex
    }
    /// Gets font-face flags.
    public var faceFlags: BLFontFaceFlags {
        BLFontFaceFlags(BLFontFaceFlags.RawValue(faceInfo.faceFlags))
    }
    /// Gets font-face diagnostics flags.
    public var diagFlags: BLFontFaceDiagFlags {
        BLFontFaceDiagFlags(BLFontFaceDiagFlags.RawValue(faceInfo.diagFlags))
    }
    /// Gets a unique identifier describing this BLFontFace.
    public var faceUniqueId: BLUniqueId {
        object.impl.uniqueId
    }

    /// Gets full name as UTF-8 null-terminated string.
    public var fullName: BLString {
        BLString(weakAssign: object.impl.fullName)
    }
    /// Gets family name as UTF-8 null-terminated string.
    public var familyName: BLString {
        BLString(weakAssign: object.impl.familyName)
    }
    /// Gets subfamily name as UTF-8 null-terminated string.
    public var subfamilyName: BLString {
        BLString(weakAssign: object.impl.subfamilyName)
    }
    /// Gets manufacturer name as UTF-8 null-terminated string.
    public var postScriptName: BLString {
        BLString(weakAssign: object.impl.postScriptName)
    }

    /// Returns design metrics of this `BLFontFace`.
    public var designMetrics: BLFontDesignMetrics {
        var metrics = BLFontDesignMetrics()
        blFontFaceGetDesignMetrics(&object, &metrics)
        return metrics
    }
    /// Returns units per em, which are part of font's design metrics.
    public var unitsPerEm: Int32 {
        designMetrics.unitsPerEm
    }
    /// Returns PANOSE classification of this `BLFontFace`.
    public var panose: BLFontPanose {
        object.impl.panose
    }
    /// Returns unicode coverage of this `BLFontFace`.
    public var unicodeCoverage: BLFontUnicodeCoverage {
        object.impl.unicodeCoverage
    }

    var info: BLFontFaceInfo {
        var info = BLFontFaceInfo()
        blFontFaceGetFaceInfo(&object, &info)
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
            blFontFaceInit(pointer)

            return try mapError { blFontFaceCreateFromFile(pointer, filePath, readFlags) }
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
        blFontFaceEquals(&lhs.object, &rhs.object)
    }
}

extension BLFontFaceCore: CoreStructure {
    public static let initializer = blFontFaceInit
    public static let deinitializer = blFontFaceReset
    public static let assignWeak = blFontFaceAssignWeak

    @usableFromInline
    var impl: BLFontFaceImpl {
        get {
            _d.impl!.load(as: BLFontFaceImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLFontFaceImpl.self)
        }
    }
}
