import blend2d

public final class BLArray<Element: BLArrayElement> {
    @usableFromInline
    var object = BLArrayCore()
    
    /// Returns the size of the array (number of items).
    public var count: Int {
        return blArrayGetSize(&object)
    }
    
    /// Returns the capacity of the array (number of items).
    public var capacity: Int {
        return blArrayGetCapacity(&object)
    }
    
    /// Returns whether the array is empty.
    public var isEmpty: Bool {
        return count == 0
    }
    
    public subscript(index: Int) -> Element {
        precondition(index >= 0 && index < count)
        
        return unsafePointer()[index]
    }
    
    /// Initializes a new array object.
    @inlinable
    public init() {
        blArrayInit(&object, Element.arrayImplementationType.arrayType)
    }
    
    @inlinable
    public convenience init(array: [Element]) {
        self.init()
        
        array.withUnsafeBufferPointer { pointer in
            append(contentsOf: pointer)
        }
    }

    @inlinable
    init(weakAssign object: BLArrayCore) {
        blArrayInit(&self.object, Element.arrayImplementationType.arrayType)

        var object = object
        withUnsafeMutablePointer(to: &object) { pointer in
            assert(
                blArrayGetItemSize(pointer) == blArrayGetItemSize(&self.object),
                "Cannot weak assign arrays of different item sizes"
            )

            blArrayAssignWeak(&self.object, pointer)
        }
    }

    @inlinable
    init(object: BLArrayCore) {
        let check = BLArray<Element>()

        var object = object
        withUnsafeMutablePointer(to: &object) { pointer in
            assert(
                blArrayGetItemSize(pointer) == blArrayGetItemSize(&check.object),
                "Cannot assign arrays of different item sizes"
            )
        }
        
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
        return Array(unsafePointer())
    }
    
    /// Returns an array of `T`-typed elements extracted from the raw buffer of
    /// this array.
    ///
    /// Note that the count of elements of the returned array is the same as
    /// `self.count`, so passing an element that with a stride greater than
    /// `self.count * MemoryLayout<Element>.stride` is a programming error.
    @inlinable
    public func unsafeAsArray<T>(of type: T.Type) -> [T] {
        return unsafePointer().baseAddress?.withMemoryRebound(to: T.self, capacity: count) { pointer -> [T] in
            let buffer = UnsafeBufferPointer(start: pointer, count: count)
            return Array(buffer)
        } ?? []
    }
    
    /// Clears the content of the array.
    ///
    /// - note: If the array used dynamically allocated memory and the instance
    /// is mutable the memory won't be released, instead, it will be ready for
    /// reuse.
    public func clear() {
        blArrayClear(&object)
    }
    
    /// Shrinks the capacity of the array to fit its length.
    ///
    /// Some array operations like `append()` may grow the array more than necessary
    /// to make it faster when such manipulation operations are called consecutively.
    /// When you are done with modifications and you know the lifetime of the array
    /// won't be short you can use `shrink()` to fit its memory requirements to the
    /// number of items it stores, which could optimize the application's memory
    /// requirements.
    public func shrink() {
        blArrayShrink(&object)
    }
    
    /// Reserves the array capacity to hold at least `capacity` items.
    public func reserveCapacity(_ capacity: Int) {
        blArrayReserve(&object, capacity)
    }
    
    /// Removes an item at the given `index`.
    public func remove(at index: Int) {
        blArrayRemoveIndex(&object, index)
    }
    
    /// Returns whether the content of this array and `other` matches.
    public func equals(to other: BLArray) -> Bool {
        return blArrayEquals(&object, &other.object)
    }
    
    @inlinable
    public func append(_ element: Element) {
        _ = withUnsafePointer(to: element) { pointer in
            blArrayAppendItem(&object, pointer)
        }
    }
    
    func append(contentsOf pointer: UnsafePointer<Element>, count: Int) {
        blArrayAppendData(&object, pointer, count)
    }
    
    @inlinable
    func append(contentsOf pointer: UnsafeBufferPointer<Element>) {
        if let base = pointer.baseAddress {
            blArrayAppendData(&object, base, pointer.count)
        }
    }
    
    public func replaceContents(_ array: [Element]) {
        clear()
        
        array.withTemporaryView { view in
            if let pointer = view.pointee.data {
                append(contentsOf: pointer, count: array.count)
            }
        }
    }
}

extension BLArray: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: Element...) {
        self.init(array: elements)
    }
}

extension BLArray: Sequence {
    public __consuming func makeIterator() -> AnyIterator<Element> {
        var index = 0

        return AnyIterator {
            if index >= self.count {
                return nil
            }
            defer {
                index += 1
            }

            return self[index]
        }
    }
}

extension BLArrayCore {
    @usableFromInline
    var impl: BLArrayImpl {
        get {
            _d.impl!.load(as: BLArrayImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLArrayImpl.self)
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
    var arrayType: BLObjectType
    
    @usableFromInline
    init(arrayType: BLObjectType) {
        self.arrayType = arrayType
    }
}

extension Float: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayFloat32)
    }
}
extension Double: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayFloat64)
    }
}
extension UInt8: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayUInt8)
    }
}
extension UInt16: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayUInt16)
    }
}
extension UInt32: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayUInt32)
    }
}
extension UInt64: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayUInt64)
    }
}
extension Int8: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayInt8)
    }
}
extension Int16: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayInt16)
    }
}
extension Int32: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayInt32)
    }
}
extension Int64: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayInt64)
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
extension BLFontFeature: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayStruct8)
    }
}
extension BLFontVariation: BLArrayElement {
    @inlinable
    public static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayStruct8)
    }
}
