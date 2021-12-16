import blend2d

/// Typed alternative to `BLVar`.
class BLTypedVar<T: BLTypedVarElement>: BLVar {
    var value: T {
        get {
            var result = T()
            _=T.getFromVar(&object, &result)
            return result
        }
        set {
            _=T.assignToVar(&object, newValue)
        }
    }

    init(_ value: T) {
        super.init { pointer in
            T.initializeVar(pointer, value)
        }
    }
    
    @usableFromInline
    override init(weakAssign object: BLVarCore) {
        super.init(weakAssign: object)

        assert(self.type == T.objectType)
    }
}

protocol BLTypedVarElement {
    typealias GetterFunc = (UnsafeRawPointer?, UnsafeMutablePointer<Self>?) -> BLResult
    typealias InitializerFunc = (UnsafeMutableRawPointer?, Self) -> BLResult
    typealias AssignFunc = (UnsafeMutableRawPointer?, Self) -> BLResult

    static var objectType: BLObjectType { get }

    static var getFromVar: GetterFunc { get }
    static var initializeVar: InitializerFunc { get }
    static var assignToVar: AssignFunc { get }

    init()
}

// MARK: - Element Types

extension Bool: BLTypedVarElement {
    static var objectType: BLObjectType { .bool }

    static let getFromVar = blVarToBool
    static let initializeVar = blVarInitBool
    static let assignToVar = blVarAssignBool
}

extension Int32: BLTypedVarElement {
    static var objectType: BLObjectType { .int64 }

    static let getFromVar = blVarToInt32
    static let initializeVar = blVarInitInt32
    static let assignToVar = blVarAssignInt32
}

extension Int64: BLTypedVarElement {
    static var objectType: BLObjectType { .int64 }

    static let getFromVar = blVarToInt64
    static let initializeVar = blVarInitInt64
    static let assignToVar = blVarAssignInt64
}

extension UInt32: BLTypedVarElement {
    static var objectType: BLObjectType { .uint64 }

    static let getFromVar = blVarToUInt32
    static let initializeVar = blVarInitUInt32
    static let assignToVar = blVarAssignUInt32
}

extension UInt64: BLTypedVarElement {
    static var objectType: BLObjectType { .uint64 }

    static let getFromVar = blVarToUInt64
    static let initializeVar = blVarInitUInt64
    static let assignToVar = blVarAssignUInt64
}

extension BLRgba32: BLTypedVarElement {
    static var objectType: BLObjectType { .rgba }

    static let getFromVar: GetterFunc = { (pointer, rgba32) in
        var value: UInt32 = 0
        defer {
            rgba32?.pointee.value = value
        }
        return blVarToRgba32(pointer, &value)
    }
    static let initializeVar: InitializerFunc = { (pointer, rgba32) in
        blVarInitRgba32(pointer, rgba32.value)
    }
    static let assignToVar: AssignFunc = { (pointer, rgba32) in
        blVarAssignRgba32(pointer, rgba32.value)
    }
}

extension BLRgba64: BLTypedVarElement {
    static var objectType: BLObjectType { .rgba }

    static let getFromVar: GetterFunc = { (pointer, rgba64) in
        var value: UInt64 = 0
        defer {
            rgba64?.pointee.value = value
        }
        return blVarToRgba64(pointer, &value)
    }
    static let initializeVar: InitializerFunc = { (pointer, rgba64) in
        blVarInitRgba64(pointer, rgba64.value)
    }
    static let assignToVar: AssignFunc = { (pointer, rgba64) in
        blVarAssignRgba64(pointer, rgba64.value)
    }
}

extension BLRgba: BLTypedVarElement {
    static var objectType: BLObjectType { .rgba }

    static let getFromVar: GetterFunc = blVarToRgba
    static let initializeVar: InitializerFunc = { (pointer, rgba) in
        withUnsafePointer(to: rgba) {
            blVarInitRgba(pointer, $0)
        }
    }
    static let assignToVar: AssignFunc = { (pointer, rgba) in
        withUnsafePointer(to: rgba) {
            blVarAssignRgba(pointer, $0)
        }
    }
}
