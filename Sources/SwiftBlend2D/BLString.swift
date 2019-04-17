import blend2d

// TODO: This class seems to be running into some memory corruption issues. Should
// probably check that.

public final class BLString: BLBaseClass<BLStringCore>, ExpressibleByStringLiteral {
    /// Size, in bytes, of the data of this BLString instance (minus trailing
    /// null-terminator).
    public var size: Int {
        return blStringGetSize(&object)
    }
    
    public override init() {
        super.init()
    }
    
    public init(string: String) {
        super.init { object -> BLResult in
            blStringInit(object)
            
            return string.withCString { pointer in
                blStringAssignData(object, pointer, string.utf8CString.count - 1)
            }
        }
    }
    
    public convenience init(stringLiteral value: String) {
        self.init(string: value)
    }
    
    public func toString() -> String {
        guard let data = blStringGetData(&object) else {
            return ""
        }
        
        return String(cString: data)
    }
    
    public static func += (lhs: BLString, rhs: String) {
        _ = rhs.withCString { pointer in
            blStringInsertData(&lhs.object, lhs.size, pointer, rhs.utf8CString.count)
        }
    }
    public static func += (lhs: BLString, rhs: BLString) {
        blStringInsertString(&lhs.object, lhs.size, &rhs.object)
    }
}

extension BLString: Equatable {
    public static func ==(lhs: BLString, rhs: BLString) -> Bool {
        return blStringEquals(&lhs.object, &rhs.object)
    }
}

extension BLStringCore: CoreStructure {
    public static var initializer = blStringInit
    public static var deinitializer = blStringReset
}
