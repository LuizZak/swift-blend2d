import blend2d

public final class BLString: BLBaseClass<BLStringCore>, ExpressibleByStringLiteral {
    /// Size, in bytes, of the data of this BLString instance, minus trailing
    /// null-terminator character.
    public var size: Int {
        return blStringGetSize(&object) - 1
    }
    
    /// Returns the character at a given index on this string.
    ///
    /// - precondition: index < size
    public subscript(index: Int) -> Int8 {
        precondition(index < size)
        return object.impl.pointee.data[index]
    }
    
    public override init() {
        super.init { object -> BLResult in
            blStringInit(object)
            
            // Insert a starting null-terminator by default
            return blStringInsertChar(object, 0, 0, 1)
        }
    }
    
    public init(string: String) {
        super.init { object -> BLResult in
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
    
    public convenience init(stringLiteral value: String) {
        self.init(string: value)
    }
    
    internal override init(weakAssign: BLStringCore) {
        super.init(weakAssign: weakAssign)
    }
    
    public func toString() -> String {
        guard let data = blStringGetData(&object) else {
            return ""
        }
        
        return String(cString: data)
    }
    
    public static func += (lhs: BLString, rhs: String) {
        rhs.withCString { pointer in
            let rhsSizeMinusNullTerminator = rhs.utf8CString.count - 1
            
            blStringInsertData(&lhs.object,
                               lhs.size,
                               pointer,
                               rhsSizeMinusNullTerminator)
        }
    }
    
    public static func += (lhs: BLString, rhs: BLString) {
        guard let data = blStringGetData(&rhs.object) else {
            return
        }
        
        blStringInsertData(&lhs.object, lhs.size, data, rhs.size)
    }
}

extension BLString: Equatable {
    public static func == (lhs: BLString, rhs: BLString) -> Bool {
        return blStringEquals(&lhs.object, &rhs.object)
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
