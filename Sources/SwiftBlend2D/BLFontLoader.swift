import blend2d

public class BLFontLoader: BLBaseClass<BLFontLoaderCore> {
    /// Gets whether the font-loader is a built-in null instance.
    @inlinable
    public var isNone: Bool {
        return (UInt32(object.impl.pointee.implTraits) & BLImplTraits.null.rawValue) != 0
    }
    
    /// Gets whether the font-loader is empty (which the same as `isNone` in this
    /// case).
    @inlinable
    public var isEmpty: Bool {
        return isNone
    }
    
    /// Type of font-face of the loader content.
    ///
    /// It doesn't matter if the content is a single font or a collection. In
    /// any case the `faceType` would always return the type of the font-face
    /// that will be created by `BLFontFace(fromLoader:)`.
    @inlinable
    public var faceType: UInt32 {
        return UInt32(object.impl.pointee.faceType)
    }
    
    /// Returns the number of faces this loader provides.
    ///
    /// If the loader is not initialized the result would be always zero. If the
    /// loader is initialized to a single font it would be 1, and if the loader
    /// is initialized to a font collection then the return would correspond to
    /// the number of font-faces within that collection.
    @inlinable
    public var faceCount: UInt32 {
        return object.impl.pointee.faceCount
    }
    
    /// Returns loader flags.
    @inlinable
    public var loaderFlags: BLFontLoaderFlags {
        return BLFontLoaderFlags(object.impl.pointee.loaderFlags)
    }
    
    public override init() {
        super.init()
    }
    
    override init(weakAssign object: BLFontLoaderCore) {
        super.init(weakAssign: object)
    }
    
    public init(fromFilePath path: String, readFlags: BLFileReadFlags) throws {
        try super.init { pointer in
            blFontLoaderInit(pointer)
            
            return try mapError {
                path.withCString { cString in
                    blFontLoaderCreateFromFile(pointer, cString, readFlags.rawValue)
                }
            }
                .addFileErrorMappings(filePath: path)
                .execute()
        }
    }
    
    /// Creates a `BLFontLoader` from the given `data` of the given `size`.
    ///
    /// - note: Optionally a `destroyFunc` can be used as a notifier that will be
    /// called when the data is no longer needed and `destroyData` acts as a user
    /// data passed to `destroyFunc()`. Please note that all fonts created by the
    /// loader would also reference the loader so `destroyFunc` will only be called
    /// when there are no references to the loader possibly held by fonts or other
    /// objects.
    public init(fromData data: UnsafeRawBufferPointer,
                destroyFunction: BLDestroyImplFunc? = nil,
                destroyData: UnsafeMutableRawPointer? = nil) throws {
        
        try super.init { pointer in
            blFontLoaderInit(pointer)
            
            return try resultToError(
                blFontLoaderCreateFromData(pointer, data.baseAddress, data.count, destroyFunction, destroyData)
            )
        }
    }
    
    /// Returns `BLFontData` instance that matches the given `faceIndex`.
    ///
    /// Please note that this function never fails. If the `faceIndex` is out
    /// of bounds then a default constructed instance of `BLFontData` will be
    /// returned.
    ///
    /// Alternatively you can use `BLFontData::createFromLoader()`, which would
    /// call virtual function `BLFontLoaderVirt::dataByFaceIndex()` behind the
    /// scenes and return the appropriate error if `faceIndex` is invalid or if
    /// the loader is not initialized.
    public func dataByFaceIndex(_ faceIndex: UInt32) throws -> BLFontData {
        guard let data = object.impl.pointee.virt.pointee.dataByFaceIndex(object.impl, faceIndex) else {
            throw Error.noDataForFaceIndex(faceIndex)
        }
        
        return BLFontData(weakAssign: data)
    }
    
    public enum Error: Swift.Error {
        case noDataForFaceIndex(UInt32)
        
        public var localizedDescription: String {
            switch self {
            case .noDataForFaceIndex(let faceIndex):
                return "No data for face index \(faceIndex)"
            }
        }
    }
}

extension BLFontLoader: Equatable {
    @inlinable
    public static func ==(lhs: BLFontLoader, rhs: BLFontLoader) -> Bool {
        return blFontLoaderEquals(&lhs.object, &rhs.object)
    }
}

extension BLFontLoaderCore: CoreStructure {
    public static let initializer = blFontLoaderInit
    public static let deinitializer = blFontLoaderReset
    public static let assignWeak = blFontLoaderAssignWeak
}
