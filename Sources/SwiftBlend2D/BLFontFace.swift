import blend2d

public class BLFontFace: BLBaseClass<BLFontFaceCore> {
    // MARK: Font Data & Loader

    /// Gets `BLFontData` associated with this font-face.
    public var data: BLFontData {
        return BLFontData(weakAssign: object.impl.pointee.data.impl)
    }
    
    // MARK: Properties

    /// Returns font weight (returns default weight in case this is a variable font).
    public var weight: UInt16 {
        return object.impl.pointee.weight
    }
    /// Returns font stretch (returns default weight in case this is a variable font).
    public var stretch: UInt8 {
        return object.impl.pointee.stretch
    }
    /// Returns font style.
    public var style: UInt8 {
        return object.impl.pointee.style
    }
    /// Returns font-face information as `BLFontFaceInfo`.
    public var faceInfo: BLFontFaceInfo {
        return object.impl.pointee.faceInfo
    }
    /// Gets font-face type.
    public var faceType: BLFontFaceType {
        return BLFontFaceType(UInt32(object.impl.pointee.faceInfo.faceType))
    }
    /// Gets font-face type.
    public var outlineType: BLFontOutlineType {
        return BLFontOutlineType(UInt32(object.impl.pointee.faceInfo.outlineType))
    }
    /// Gets a number of glyphs the face provides.
    public var glyphCount: UInt16 {
        return object.impl.pointee.faceInfo.glyphCount
    }
    /// Gets a zero-based index of this font-face.
    ///
    /// NOTE: Face index does only make sense if this face is part of a TrueType
    /// or OpenType font collection. In that case the returned value would be
    /// the index of this face in that collection. If the face is not part of a
    /// collection then the returned value would always be zero.
    public var faceIndex: UInt32 {
        return object.impl.pointee.faceInfo.faceIndex
    }
    /// Gets font-face flags.
    public var faceFlags: BLFontFaceFlags {
        return BLFontFaceFlags(object.impl.pointee.faceInfo.faceFlags)
    }
    /// Gets font-face diagnostics flags.
    public var diagFlags: BLFontFaceDiagFlags {
        return BLFontFaceDiagFlags(object.impl.pointee.faceInfo.diagFlags)
    }
    /// Gets a unique identifier describing this BLFontFace.
    public var faceUniqueId: BLUniqueId {
        return object.impl.pointee.uniqueId
    }

    /// Gets full name as UTF-8 null-terminated string.
    public var fullName: BLString {
        return BLString(weakAssign: object.impl.pointee.fullName)
    }
    /// Gets family name as UTF-8 null-terminated string.
    public var familyName: BLString {
        return BLString(weakAssign: object.impl.pointee.familyName)
    }
    /// Gets subfamily name as UTF-8 null-terminated string.
    public var subfamilyName: BLString {
        return BLString(weakAssign: object.impl.pointee.subfamilyName)
    }
    /// Gets manufacturer name as UTF-8 null-terminated string.
    public var postScriptName: BLString {
        return BLString(weakAssign: object.impl.pointee.postScriptName)
    }

    // TODO: This property is commented out in Blend2D's source code
    /// Returns feature-set of this `BLFontFace`.
    //    public var featureSet: FontFeatureSet {
    //        return object.impl.pointee.featureSet
    //    }

    /// Returns design metrics of this `BLFontFace`.
    public var designMetrics: BLFontDesignMetrics {
        return object.impl.pointee.designMetrics
    }
    /// Returns units per em, which are part of font's design metrics.
    public var unitsPerEm: Int32 {
        return object.impl.pointee.designMetrics.unitsPerEm
    }
    /// Returns PANOSE classification of this `BLFontFace`.
    public var panose: BLFontPanose {
        return object.impl.pointee.panose
    }
    /// Returns unicode coverage of this `BLFontFace`.
    public var unicodeCoverage: BLFontUnicodeCoverage {
        return object.impl.pointee.unicodeCoverage
    }

    // MARK: - Initializers
    
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

            return try mapError { blFontFaceCreateFromFile(pointer, filePath, readFlags.rawValue) }
                .addFileErrorMappings(filePath: filePath)
                .execute()
        }
    }
    
    public override init(weakAssign object: BLFontFaceCore) {
        super.init(weakAssign: object)
    }
}

extension BLFontFaceCore: CoreStructure {
    public static let initializer = blFontFaceInit
    public static let deinitializer = blFontFaceReset
    public static let assignWeak = blFontFaceAssignWeak
}
