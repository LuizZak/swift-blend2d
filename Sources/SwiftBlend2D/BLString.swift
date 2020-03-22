import blend2d

/// Byte string.
///
/// Blend2D always uses UTF-8 encoding in public APIs so all strings are assumed
/// UTF-8 by default. However, `BLString` can hold arbitrary byte sequence and
/// act as a raw byte-string when this functionality is required.
public struct BLString: ExpressibleByStringLiteral {
    @usableFromInline
    var box: BLBaseClass<BLStringCore>
    
    /// Size, in bytes, of the data of this BLString instance, minus trailing
    /// null-terminator character.
    public var size: Int {
        return blStringGetSize(&box.object) - 1
    }
    
    public init() {
        box = BLBaseClass { object -> BLResult in
            blStringInit(object)
            
            // Insert a starting null-terminator by default
            return blStringInsertChar(object, 0, 0, 1)
        }
    }
    
    public init(string: String) {
        box = BLBaseClass { object -> BLResult in
            blStringInit(object)
            
            return string.withCString { pointer in
                // Here, we don't subtract the null-terminator to allow it to be
                // naturally inserted into the initial string data.
                //
                // On subsequent operations this null-terminator is manually
                // pushed to the end of the string data every time a mutating
                // operation occurs
                blStringAssignData(object, pointer, string.utf8CString.count)
            }
        }
    }
    
    public init(stringLiteral value: String) {
        self.init(string: value)
    }
    
    internal init(weakAssign: BLStringCore) {
        box = BLBaseClass(weakAssign: weakAssign)
    }
    
    @inlinable
    mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }
    
    public func toString() -> String {
        guard let data = blStringGetData(&box.object) else {
            return ""
        }
        
        return String(cString: data)
    }
    
    public static func += (lhs: inout BLString, rhs: String) {
        lhs.ensureUnique()
        
        rhs.withCString { pointer in
            let rhsSizeMinusNullTerminator = rhs.utf8CString.count - 1
            
            blStringInsertData(&lhs.box.object,
                               lhs.size,
                               pointer,
                               rhsSizeMinusNullTerminator)
        }
    }
    
    public static func += (lhs: inout BLString, rhs: BLString) {
        guard let data = blStringGetData(&rhs.box.object) else {
            return
        }
        
        lhs.ensureUnique()
        blStringInsertData(&lhs.box.object, lhs.size, data, rhs.size)
    }
}

extension BLString: Equatable {
    public static func == (lhs: BLString, rhs: BLString) -> Bool {
        return blStringEquals(&lhs.box.object, &rhs.box.object)
    }
}

extension BLString: CustomStringConvertible {
    public var description: String {
        return toString()
    }
}

extension BLString: Sequence {
    public func makeIterator() -> Iterator {
        return Iterator(string: self, index: 0)
    }
    
    public struct Iterator: IteratorProtocol {
        let string: BLString
        var index: Int
        
        public mutating func next() -> Int8? {
            if index == string.size {
                return nil
            }
            
            defer { index += 1 }
            
            return string[index]
        }
    }
}

extension BLString: Collection {
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return size
    }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    /// Returns the character at a given index on this string.
    ///
    /// - precondition: index < size
    public subscript(index: Int) -> Int8 {
        precondition(index < size)
        return box.object.impl.pointee.data[index]
    }
}

extension BLStringCore: CoreStructure {
    public static let initializer = blStringInit
    public static let deinitializer = blStringReset
    public static let assignWeak = blStringAssignWeak
}

internal extension BLStringCore {
    var asBLString: BLString {
        return BLString(weakAssign: self)
    }
    
    var asString: String {
        return asBLString.toString()
    }
    
    var view: BLStringView {
        return impl.pointee.view
    }
    
    var size: Int {
        return impl.pointee.size
    }
}
