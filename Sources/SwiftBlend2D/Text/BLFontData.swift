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
    
    public func listTags(faceIndex: UInt32) throws -> [BLTag] {
        let array = BLArray<UInt32>()
        
        try resultToError(
            blFontDataListTags(&object, faceIndex, &array.object)
        )
        
        return array.unsafeAsArray(of: BLTag.self)
    }
    
    public func queryTable(faceIndex: UInt32, fontTable: inout BLFontTable, tag: BLTag) -> Int {
        self.queryTables(faceIndex: faceIndex, fontTable: &fontTable, tags: [tag])
    }
    
    public func queryTables(faceIndex: UInt32, fontTable: inout BLFontTable, tags: [BLTag]) -> Int {
        var tags = tags

        return blFontDataQueryTables(&object, faceIndex, &fontTable, &tags, tags.count)
    }
}

extension BLFontDataCore: CoreStructure {
    public static let initializer = blFontDataInit
    public static let deinitializer = blFontDataReset
    public static let assignWeak = blFontDataAssignWeak

    @usableFromInline
    var impl: BLFontDataImpl {
        get {
            _d.impl!.load(as: BLFontDataImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLFontDataImpl.self)
        }
    }
}
