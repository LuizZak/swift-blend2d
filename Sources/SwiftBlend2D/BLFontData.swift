import blend2d

public class BLFontData: BLBaseClass<BLFontDataCore> {
    @inlinable
    public override init() {
        super.init()
    }

    @inlinable
    public init(fromFontLoader loader: BLFontLoader, faceIndex: UInt32) throws {
        try super.init { pointer in
            try resultToError(
                blFontDataInitFromLoader(pointer, &loader.object, faceIndex)
            )
        }
    }

    @inlinable
    internal init(weakAssign impl: UnsafeMutablePointer<BLFontDataImpl>) {
        super.init(weakAssign: BLFontDataCore(impl: impl))
    }
    
    public func listTags() throws -> [BLTag] {
        let array = BLArray<UInt32>()
        
        try resultToError(
            object.impl.pointee.virt.pointee.listTags(object.impl, &array.object)
        )
        
        return array.unsafeAsArray(of: BLTag.self)
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
