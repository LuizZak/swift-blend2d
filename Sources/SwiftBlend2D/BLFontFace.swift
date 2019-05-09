import blend2d

public class BLFontFace: BLBaseClass<BLFontFaceCore> {
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
    public init(fromFile fileName: String, readFlags: BLFileReadFlags = []) throws {
        try super.init { pointer -> BLResult in
            blFontFaceInit(pointer)
            
            return try resultToError(
                blFontFaceCreateFromFile(pointer, fileName, readFlags.rawValue)
            )
        }
    }
    
    /// Creates a new `BLFontFace` from `BLFontLoader`.
    public init(fromLoader loader: BLFontLoader, faceIndex: UInt32) throws {
        try super.init { pointer -> BLResult in
            blFontFaceInit(pointer)
            
            return try resultToError(
                blFontFaceCreateFromLoader(pointer, &loader.object, faceIndex)
            )
        }
    }
    
    public override init(borrowing object: BLFontFaceCore) {
        super.init(borrowing: object)
    }

    // MARK: Font Data & Loader
    
    /// Gets `BLFontData` associated with this font-face.
    public var data: BLFontData {
        return BLFontData(borrowing: object.impl.pointee.data.impl)
    }
    /// Gets `BLFontLoader` associated with this font-face.
    public var loader: BLFontLoader {
        return BLFontLoader(borrowing: object.impl.pointee.loader)
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
    public var faceUniqueId: UInt64 {
        return object.impl.pointee.faceUniqueId
    }
    /// Gets full name as UTF-8 null-terminated string.
    public var fullName: String {
        return object.impl.pointee.fullName.asString
    }
    /// Gets size of string returned by `fullName`, in bytes.
    public var fullNameSize: Int {
        return object.impl.pointee.fullName.size
    }
    
    /// Gets family name as UTF-8 null-terminated string.
    public var familyName: String {
        return object.impl.pointee.familyName.asString
    }
    /// Gets size of string returned by `familyName`, in bytes.
    public var familyNameSize: Int {
        return object.impl.pointee.familyName.size
    }
    /// Gets subfamily name as UTF-8 null-terminated string.
    public var subfamilyName: String {
        return object.impl.pointee.subfamilyName.asString
    }
    /// Gets size of string returned by `subfamilyName`, in bytes.
    public var subfamilyNameSize: Int {
        return object.impl.pointee.subfamilyName.size
    }
    /// Gets manufacturer name as UTF-8 null-terminated string.
    public var postScriptName: String {
        return object.impl.pointee.postScriptName.asString
    }
    /// Gets size of string returned by `postScriptName`, in bytes.
    public var postScriptNameSize: Int {
        return object.impl.pointee.postScriptName.size
    }
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
}

extension BLFontFaceCore: CoreStructure {
    public static var initializer = blFontFaceInit
    public static var deinitializer = blFontFaceReset
    public static var assignWeak = blFontFaceAssignWeak
}
