import blend2d

public final class BLString: BLBaseClass<BLStringCore>, ExpressibleByStringLiteral {
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
    
    public init(stringLiteral value: String) {
        super.init { object -> BLResult in
            blStringInit(object)
            
            return value.withCString { pointer in
                blStringAssignData(object, pointer, value.utf8CString.count - 1)
            }
        }
    }
    
    public func toString() -> String {
        guard let data = blStringGetData(&object) else {
            return ""
        }
        
        return data.withMemoryRebound(to: UInt8.self, capacity: size, String.init)
    }
    
    public static func += (lhs: BLString, rhs: String) {
        _ = rhs.withCString { pointer in
            blStringInsertData(&lhs.object, lhs.size, pointer, rhs.utf8CString.count - 1)
        }
    }
}

extension BLStringCore: CoreStructure {
    public static var initializer = blStringInit
    public static var deinitializer = blStringReset
}
