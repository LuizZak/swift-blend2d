import blend2d

/// Byte string.
///
/// Blend2D always uses UTF-8 encoding in public APIs so all strings are assumed
/// UTF-8 by default. However, `BLString` can hold arbitrary byte sequence and
/// act as a raw byte-string when this functionality is required.
public struct BLString: ExpressibleByStringLiteral {
    @usableFromInline
    var box: BLBaseClass<BLStringCore>

    var data: UnsafePointer<CChar> {
        bl_string_get_data(&box.object)
    }

    /// Size, in bytes, of the data of this BLString instance, minus trailing
    /// null-terminator character.
    public var size: Int {
        bl_string_get_size(&box.object) - 1
    }

    public init() {
        box = BLBaseClass { object -> BLResult in
            bl_string_init(object)

            // Insert a starting null-terminator by default
            return bl_string_insert_char(object, 0, 0, 1)
        }
    }

    public init(string: String) {
        box = BLBaseClass { object -> BLResult in
            bl_string_init(object)

            return string.withCString { pointer in
                // Here, we don't subtract the null-terminator to allow it to be
                // naturally inserted into the initial string data.
                //
                // On subsequent operations this null-terminator is manually
                // pushed to the end of the string data every time a mutating
                // operation occurs
                bl_string_assign_data(object, pointer, string.utf8CString.count)
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
        guard let data = bl_string_get_data(&box.object) else {
            return ""
        }

        return String(cString: data)
    }

    public static func += (lhs: inout BLString, rhs: String) {
        lhs.ensureUnique()

        rhs.withCString { pointer in
            let rhsSizeMinusNullTerminator = rhs.utf8CString.count - 1

            bl_string_insert_data(
                &lhs.box.object,
                lhs.size,
                pointer,
                rhsSizeMinusNullTerminator
            )
        }
    }

    public static func += (lhs: inout BLString, rhs: BLString) {
        guard let data = bl_string_get_data(&rhs.box.object) else {
            return
        }

        lhs.ensureUnique()
        bl_string_insert_data(&lhs.box.object, lhs.size, data, rhs.size)
    }
}

extension BLString: Equatable {
    public static func == (lhs: BLString, rhs: BLString) -> Bool {
        bl_string_equals(&lhs.box.object, &rhs.box.object)
    }
}

extension BLString: CustomStringConvertible {
    public var description: String {
        toString()
    }
}

extension BLString: Sequence {
    public func makeIterator() -> Iterator {
        Iterator(string: self, index: 0)
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
    public var startIndex: Int { 0 }

    public var endIndex: Int { size }

    public func index(after i: Int) -> Int {
        i + 1
    }

    /// Returns the character at a given index on this string.
    ///
    /// - precondition: index >= 0 && index < size
    public subscript(index: Int) -> Int8 {
        precondition(index >= 0 && index < size)
        return data[index]
    }
}

extension BLStringCore: CoreStructure {
    public static let initializer = bl_string_init
    public static let deinitializer = bl_string_reset
    public static let assignWeak = bl_string_assign_weak

    @usableFromInline
    var impl: BLStringImpl {
        get { UnsafeMutablePointer(_d.impl)!.pointee }
        set { UnsafeMutablePointer(_d.impl)!.pointee = newValue }
    }
}

internal extension BLStringCore {
    var asBLString: BLString {
        BLString(weakAssign: self)
    }

    var asString: String {
        asBLString.toString()
    }

    var size: Int {
        impl.size
    }
}
