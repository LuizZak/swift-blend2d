import blend2d

final class BLArray {
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
    
    init(array: [Double]) {
        blArrayInit(&object, BL_IMPL_TYPE_ARRAY_F64.rawValue)
        ownership = .owner
        
        array.withUnsafeBytes { pointer in
            guard let pointer = pointer.baseAddress else {
                return
            }
            
            append(contentsOf: pointer, byteCount: array.count * MemoryLayout<Double>.size)
        }
    }
    
    deinit {
        if ownership == .owner {
            blArrayReset(&object)
        }
    }
    
    func unsafePointer() -> UnsafeRawBufferPointer {
        let pointer = blArrayGetData(&object)
        
        return UnsafeRawBufferPointer(start: pointer!, count: count)
    }
    
    func asArrayOfUnsafe<T>(type: T.Type) -> [T] {
        guard let pointer = blArrayGetData(&object)?.bindMemory(to: T.self, capacity: count) else {
            return []
        }
        
        let buffer = UnsafeBufferPointer(start: pointer, count: count)
        return Array(AnyIterator(buffer.makeIterator()))
    }
    
    func asArrayOfUInt8() -> [UInt8] {
        return asArrayOfUnsafe(type: UInt8.self)
    }
    func asArrayOfDouble() -> [Double] {
        return asArrayOfUnsafe(type: Double.self)
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
    
    func append(contentsOf pointer: UnsafeRawPointer, byteCount: Int) {
        blArrayAppendView(&object, pointer, byteCount)
    }
    
    func clear() {
        blArrayClear(&object)
    }
    
    func replaceContentsUnsafe<T>(_ contents: [T]) {
        let elementSize = MemoryLayout<T>.size
        
        clear()
        
        contents.withUnsafeBytes { pointer in
            guard let pointer = pointer.baseAddress else {
                return
            }
            
            append(contentsOf: pointer, byteCount: elementSize * contents.count)
        }
    }
}
