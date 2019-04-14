import blend2d

class BLArray {
    var object = BLArrayCore()
    var ownership: PointerOwnership
    
    var count: Int {
        return blArrayGetSize(&object)
    }
    
    var capacity: Int {
        return blArrayGetCapacity(&object)
    }
    
    init(type: BLImplType) {
        blArrayInit(&object, type.rawValue)
        ownership = .owner
    }
    
    init(borrowing object: BLArrayCore) {
        self.object = object
        ownership = .borrowed
    }
    
    deinit {
        if ownership == .owner {
            blArrayReset(&object)
        }
    }
    
    func readStructureUnsafe<T>(type: T.Type) -> [T] {
        guard let pointer = blArrayGetData(&object)?.bindMemory(to: T.self, capacity: count) else {
            return []
        }
        
        let buffer = UnsafeBufferPointer(start: pointer, count: count)
        return Array(AnyIterator(buffer.makeIterator()))
    }
    
    func readUInt8() -> [UInt8] {
        return readStructureUnsafe(type: UInt8.self)
    }
    
    func shrink() {
        blArrayShrink(&object)
    }
    
    func reserveCapacity(_ capacity: Int) {
        blArrayReserve(&object, capacity)
    }
    
    func remove(at index: Int) {
        blArrayRemoveIndex(&object, index)
    }
    
    func equals(to other: BLArray) -> Bool {
        return blArrayEquals(&object, &other.object)
    }
    
    func append(_ item: Double) {
        blArrayAppendF64(&object, item)
    }
    
    func append(_ item: Float) {
        blArrayAppendF32(&object, item)
    }
    
    func append(_ item: UInt8) {
        blArrayAppendU8(&object, item)
    }
    
    func append(_ item: UInt16) {
        blArrayAppendU16(&object, item)
    }
    
    func append(_ item: UnsafeRawPointer) {
        blArrayAppendItem(&object, item)
    }
    
    func append(contentsOf pointer: UnsafeRawPointer, count: Int) {
        blArrayAppendView(&object, pointer, count)
    }
}
