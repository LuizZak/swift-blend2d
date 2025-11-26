import blend2d

public class BLFontData: BLBaseClass<BLFontDataCore> {
    @inlinable
    public override init() {
        super.init()
    }

    @inlinable
    internal override init(weakAssign object: BLFontDataCore) {
        super.init(weakAssign: object)
    }

    public func tableTags(faceIndex: UInt32) throws -> [BLTag] {
        let array = BLArray<UInt32>()

        try resultToError(
            bl_font_data_get_table_tags(&object, faceIndex, &array.object)
        )

        return array.unsafeAsArray(of: BLTag.self)
    }

    public func queryTable(faceIndex: UInt32, fontTable: inout BLFontTable, tag: BLTag) -> Int {
        self.queryTables(faceIndex: faceIndex, fontTable: &fontTable, tags: [tag])
    }

    public func queryTables(faceIndex: UInt32, fontTable: inout BLFontTable, tags: [BLTag]) -> Int {
        var tags = tags

        return bl_font_data_get_tables(&object, faceIndex, &fontTable, &tags, tags.count)
    }
}

extension BLFontDataCore: CoreStructure {
    public static let initializer = bl_font_data_init
    public static let deinitializer = bl_font_data_reset
    public static let assignWeak = bl_font_data_assign_weak

    @usableFromInline
    var impl: BLFontDataImpl {
        get { UnsafeMutablePointer(_d.impl)!.pointee }
        set { UnsafeMutablePointer(_d.impl)!.pointee = newValue }
    }
}
