import blend2d

final class BLArray {
    var object = BLArrayCore()
    
    var count: Int {
        return blArrayGetSize(&object)
    }
    
    var capacity: Int {
        return blArrayGetCapacity(&object)
    }
    
    init(type: BLImplType) {
        blArrayInit(&object, type.rawValue)
    }
    
    init(borrowing object: BLArrayCore) {
        blArrayInit(&self.object, UInt32(object.impl.pointee.implType))
        
        withUnsafePointer(to: object) { pointer -> Void in
            blArrayAssignWeak(&self.object, pointer)
        }
    }
    
    init(array: [Double]) {
        blArrayInit(&object, BLImplType.arrayOfFloat64.rawValue)
        
        array.withUnsafeBytes { pointer in
            guard let pointer = pointer.baseAddress else {
                return
            }
            
            append(contentsOf: pointer, lengthInBytes: array.count * MemoryLayout<Double>.size)
        }
    }
    
    deinit {
        blArrayReset(&object)
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
    
    func append(_ item: UInt32) {
        blArrayAppendU32(&object, item)
    }
    
    func append(_ item: Int8) {
        blArrayAppendU8(&object, UInt8(bitPattern: item))
    }
    
    func append(_ item: Int16) {
        blArrayAppendU16(&object, UInt16(bitPattern: item))
    }
    
    func append(_ item: Int32) {
        blArrayAppendU32(&object, UInt32(bitPattern: item))
    }
    
    func append(_ item: UnsafeRawPointer) {
        blArrayAppendItem(&object, item)
    }
    
    func append(contentsOf pointer: UnsafeRawPointer, lengthInBytes: Int) {
        blArrayAppendView(&object, pointer, lengthInBytes)
    }
    
    func clear() {
        blArrayClear(&object)
    }
    
    func replaceContents(_ array: [Double]) {
        clear()
        
        BLArray.withTemporaryArrayView(for: array) { pointer, size in
            if let pointer = pointer {
                append(contentsOf: pointer, lengthInBytes: size)
            }
        }
    }
}

extension BLArray {
    /// Executes a closure passing in a context for a temporary BLArrayView-
    /// compatible pointer+count arguments that can be provided for Blend2D
    /// methods that accept a pair of (void*, size_t) values for representing
    /// Blend2D arrays of `Double` elements.
    ///
    /// Returns the result from the closure invocation, or any error thrown by
    /// the closure during the execution of this method.
    ///
    /// The pointer value is short-lived and should not be stored or used beyond
    /// the duration of the closure's execution.
    static func withTemporaryArrayView<T>(for array: [Double],
                                          _ closure: (_ pointer: UnsafeRawPointer?, _ arraySizeInBytes: Int) throws -> T) rethrows -> T {
        
        return try array.withUnsafeBytes { pointer in
            let pointer = pointer.baseAddress
            
            return try closure(pointer, array.count * MemoryLayout<Double>.size)
        }
    }
}
