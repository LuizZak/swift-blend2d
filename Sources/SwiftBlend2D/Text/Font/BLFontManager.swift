import blend2d

/// Font manager
public class BLFontManager: BLBaseClass<BLFontManagerCore> {
    public var faceCount: Int {
        Int(bl_font_manager_get_face_count(&object))
    }

    public var familyCount: Int {
        Int(bl_font_manager_get_family_count(&object))
    }

    public override init() {
        super.init { pointer -> BLResult in
            bl_font_manager_init(pointer)
            return bl_font_manager_create(pointer)
        }
    }

    public func hasFace(_ face: BLFontFace) -> Bool {
        bl_font_manager_has_face(&object, &face.object)
    }

    @discardableResult
    public func addFace(_ face: BLFontFace) -> BLResult {
        bl_font_manager_add_face(&object, &face.object)
    }

    public func queryFace(name: String, properties: BLFontQueryProperties? = nil) -> BLFontFace? {
        return withUnsafeNullablePointer(to: properties) { pointer -> BLFontFace? in
            let fontFace = BLFontFace()
            bl_font_manager_query_face(&object, name, name.utf8.count, pointer, &fontFace.object)

            return fontFace
        }
    }

    public func queryFacesByFamilyName(name: String) -> [BLFontFace] {
        let array: BLArray = BLArray<BLFontFaceCore>()
        bl_font_manager_query_faces_by_family_name(&object, name, name.utf8.count, &array.object)

        return array.map { BLFontFace(weakAssign: $0) }
    }
}

extension BLFontManagerCore: CoreStructure {
    public static var initializer = bl_font_manager_init
    public static var assignWeak = bl_font_manager_assign_weak
    public static var deinitializer = bl_font_manager_reset
}
