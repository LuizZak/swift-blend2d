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
            // TODO: Transform into a throwable error here
            fatalError("No data for face index \(faceIndex)")
        }
        
        return BLFontData(weakAssign: data)
    }
    
    // TODO: Re-enable this back again once we figure out what destroyFunc and
    // destroyData parameters to pass to `blFontLoaderCreateFromData`, if at all.
    #if false
    
    public init(fromData data: UnsafeRawBufferPointer) throws {
        try super.init { pointer in
            blFontLoaderInit(pointer)
            
            return try resultToError(
                blFontLoaderCreateFromData(pointer, data.baseAddress, data.count, nil, nil)
            )
        }
    }
    
    #endif
}

extension BLFontLoader: Equatable {
    @inlinable
    public static func ==(lhs: BLFontLoader, rhs: BLFontLoader) -> Bool {
        return blFontLoaderEquals(&lhs.object, &rhs.object)
    }
}

extension BLFontLoaderCore: CoreStructure {
    public static var initializer = blFontLoaderInit
    public static var deinitializer = blFontLoaderReset
    public static var assignWeak = blFontLoaderAssignWeak
}
