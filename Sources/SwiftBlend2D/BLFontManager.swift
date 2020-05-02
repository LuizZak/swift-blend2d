import blend2d

/// Font manager
public class BLFontManager: BLBaseClass<BLFontManagerCore> {
    public var faceCount: Int {
        Int(blFontManagerGetFaceCount(&object))
    }
    
    public var familyCount: Int {
        Int(blFontManagerGetFamilyCount(&object))
    }
    
    public override init() {
        super.init { pointer -> BLResult in
            blFontManagerInit(pointer)
            return blFontManagerCreate(pointer)
        }
    }
    
    public func hasFace(_ face: BLFontFace) -> Bool {
        return blFontManagerHasFace(&object, &face.object)
    }
    
    @discardableResult
    public func addFace(_ face: BLFontFace) -> BLResult {
        return blFontManagerAddFace(&object, &face.object)
    }
    
    public func queryFace(name: String, properties: BLFontQueryProperties? = nil) -> BLFontFace? {
        return withUnsafeNullablePointer(to: properties) { pointer -> BLFontFace? in
            let fontFace = BLFontFace()
            blFontManagerQueryFace(&object, name, name.utf8.count, pointer, &fontFace.object)
            
            return fontFace
        }
    }
    
    public func queryFacesByFamilyName(name: String) -> [BLFontFace] {
        let array: BLArray = BLArray<BLFontFaceCore>()
        blFontManagerQueryFacesByFamilyName(&object, name, name.utf8.count, &array.object)
        
        return array.map { BLFontFace(weakAssign: $0) }
    }
}

extension BLFontManagerCore: CoreStructure {
    public static var arrayImplementationType: BLArrayType = .init(arrayType: .arrayOfVar)
    
    public static var initializer = blFontManagerInit
    public static var assignWeak = blFontManagerAssignWeak
    public static var deinitializer = blFontManagerReset
}
