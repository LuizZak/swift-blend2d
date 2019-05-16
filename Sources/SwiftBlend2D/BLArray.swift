import blend2d

public final class BLArray<Element: BLArrayElement> {
    @usableFromInline
    var object = BLArrayCore()
    
    public var count: Int {
        return blArrayGetSize(&object)
    }
    
    public var capacity: Int {
        return blArrayGetCapacity(&object)
    }
    
    public subscript(index: Int) -> Element {
        precondition(index >= 0 && index < count)
        
        return unsafePointer()[index]
    }
    
    /// Initializes a new array object.
    @inlinable
    public init() {
        blArrayInit(&object, Element.arrayImplementationType.arrayType.rawValue)
    }
    
    @inlinable
    public init(array: [Element]) {
        blArrayInit(&object, Element.arrayImplementationType.arrayType.rawValue)
        
        array.withUnsafeBufferPointer { pointer in
            append(contentsOf: pointer)
        }
    }
    
    init(weakAssign object: BLArrayCore) {
        assert(Element.arrayImplementationType.arrayType.rawValue == object.impl.pointee.implType,
               "Cannot weak assign arrays of different types")
        
        blArrayInit(&self.object, Element.arrayImplementationType.arrayType.rawValue)
        
        withUnsafePointer(to: object) { pointer -> Void in
            blArrayAssignWeak(&self.object, pointer)
        }
    }
    
    init(object: BLArrayCore) {
        assert(Element.arrayImplementationType.arrayType.rawValue == object.impl.pointee.implType,
               "Cannot weak assign arrays of different types")
        
        self.object = object
    }
    
    deinit {
        blArrayReset(&object)
    }
    
    @usableFromInline
    func unsafePointer() -> UnsafeBufferPointer<Element> {
        let pointer = blArrayGetData(&object)?
            .bindMemory(to: Element.self, capacity: count)
        
        return UnsafeBufferPointer(start: pointer, count: count)
    }
    
    public func asArray() -> [Element] {
        return unsafeAsArray(of: Element.self)
    }
    
    @inlinable
    public func unsafeAsArray<T>(of type: T.Type) -> [T] {
        return unsafePointer().baseAddress?.withMemoryRebound(to: T.self, capacity: count) { pointer -> [T] in
            let buffer = UnsafeBufferPointer(start: pointer, count: count)
            return Array(AnyIterator(buffer.makeIterator()))
        } ?? []
    }
    
    public func shrink() {
        blArrayShrink(&object)
    }
    
    public func reserveCapacity(_ capacity: Int) {
        blArrayReserve(&object, capacity)
    }
    
    public func remove(at index: Int) {
        blArrayRemoveIndex(&object, index)
    }
    
    public func equals(to other: BLArray) -> Bool {
        return blArrayEquals(&object, &other.object)
    }
    
    @inlinable
    public func append(_ element: Element) {
        _ = withUnsafePointer(to: element) { pointer in
            blArrayAppendItem(&object, pointer)
        }
    }
    
    func append(contentsOf pointer: UnsafePointer<Element>, lengthInBytes: Int) {
        blArrayAppendView(&object, pointer, lengthInBytes)
    }
    
    @inlinable
    func append(contentsOf pointer: UnsafeBufferPointer<Element>) {
        if let base = pointer.baseAddress {
            blArrayAppendView(&object, base, pointer.count)
        }
    }
    
    public func clear() {
        blArrayClear(&object)
    }
    
    public func replaceContents(_ array: [Element]) {
        clear()
        
        array.withTemporaryView { view in
            if let pointer = view.pointee.data {
                append(contentsOf: pointer, lengthInBytes: view.pointee.size)
            }
        }
    }
}

/// A protocol that is used to parameterize `BLArray` instances.
public protocol BLArrayElement {
    /// Returns a `BLImplType` for the array of elements corresponding to `Self`
    static var arrayImplementationType: BLArrayType { get }
}

public struct BLArrayType {
    @usableFromInline
    var arrayType: BLImplType
    
    @usableFromInline
    init(arrayType: BLImplType) {
        self.arrayType = arrayType
    }
}

extension Float: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfFloat32)
    }
}
extension Double: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfFloat64)
    }
}
extension UInt8: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfUInt8)
    }
}
extension UInt16: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfUInt16)
    }
}
extension UInt32: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfUInt32)
    }
}
extension UInt64: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfUInt64)
    }
}
extension Int8: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfInt8)
    }
}
extension Int16: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfInt16)
    }
}
extension Int32: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfInt32)
    }
}
extension Int64: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfInt64)
    }
}
extension Int: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return MemoryLayout<Int>.size == MemoryLayout<Int32>.size
            ? Int32.arrayImplementationType
            : Int64.arrayImplementationType
    }
}
extension UInt: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size
            ? UInt32.arrayImplementationType
            : UInt64.arrayImplementationType
    }
}
