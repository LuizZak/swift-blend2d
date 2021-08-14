import blend2d

public class BLFontData: BLBaseClass<BLFontDataCore> {
    @inlinable
    public override init() {
        super.init()
    }

    @inlinable
    internal init(weakAssign impl: UnsafeMutablePointer<BLFontDataImpl>) {
        super.init(weakAssign: BLFontDataCore(impl: impl))
    }
    
    public func listTags(faceIndex: UInt32) throws -> [BLTag] {
        let array = BLArray<UInt32>()
        
        try resultToError(
            object.impl.pointee.virt.pointee.listTags(object.impl, faceIndex, &array.object)
        )
        
        return array.unsafeAsArray(of: BLTag.self)
    }
    
    public func queryTable(faceIndex: UInt32, fontTable: inout BLFontTable, tag: BLTag) -> Int {
        var tag = tag
        
        return object.impl.pointee.virt.pointee.queryTables(object.impl, faceIndex, &fontTable, &tag, 1)
    }
    
    public func queryTables(faceIndex: UInt32, fontTable: inout BLFontTable, tags: [BLTag]) -> Int {
        return object.impl.pointee.virt.pointee.queryTables(object.impl, faceIndex, &fontTable, tags, tags.count)
    }
}

extension BLFontDataCore: CoreStructure {
    public static let initializer = blFontDataInit
    public static let deinitializer = blFontDataReset
    public static let assignWeak = blFontDataAssignWeak
}
