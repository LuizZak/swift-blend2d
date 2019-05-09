import blend2d

public class BLFontData: BLBaseClass<BLFontDataCore> {
    public override init() {
        super.init()
    }
    
    public init(fromFontLoader loader: BLFontLoader, faceIndex: UInt32) throws {
        try super.init { pointer in
            try resultToError(
                blFontDataInitFromLoader(pointer, &loader.object, faceIndex)
            )
        }
    }
    
    internal init(borrowing impl: UnsafeMutablePointer<BLFontDataImpl>) {
        super.init(borrowing: BLFontDataCore(impl: impl))
        ownership = .borrowed
    }
    
    public func listTags() throws -> [BLTag] {
        let array = BLArray(type: .arrayOfUInt32)
        
        try resultToError(
            object.impl.pointee.virt.pointee.listTags(object.impl, &array.object)
        )
        
        return array.asArrayOfUnsafe(type: BLTag.self)
    }
    
    public func queryTable(fontTable: inout BLFontTable, tag: BLTag) -> Int {
        var tag = tag
        
        return object.impl.pointee.virt.pointee.queryTables(object.impl, &fontTable, &tag, 1)
    }
    
    public func queryTables(fontTable: inout BLFontTable, tags: [BLTag]) -> Int {
        return object.impl.pointee.virt.pointee.queryTables(object.impl, &fontTable, tags, 1)
    }
    
}

extension BLFontDataCore: CoreStructure {
    public static var initializer = blFontDataInit
    public static var deinitializer = blFontDataReset
    public static var assignWeak = blFontDataAssignWeak
}
