import blend2d

public final class BLString: BLBaseClass<BLStringCore>, ExpressibleByStringLiteral {
    /// Size, in bytes, of the data of this BLString instance, minus trailing
    /// null-terminator character.
    public var size: Int {
        return blStringGetSize(&object) - 1
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
                // operation occures
                blStringAssignData(object, pointer, string.utf8CString.count)
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
    public static func ==(lhs: BLString, rhs: BLString) -> Bool {
        return blStringEquals(&lhs.object, &rhs.object)
    }
}

extension BLStringCore: CoreStructure {
    public static let initializer = blStringInit
    public static let deinitializer = blStringReset
}
