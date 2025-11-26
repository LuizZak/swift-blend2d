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

    static let getFromVar = bl_var_to_bool
    static let initializeVar = bl_var_init_bool
    static let assignToVar = bl_var_assign_bool
}

extension Int32: BLTypedVarElement {
    static var objectType: BLObjectType { .int64 }

    static let getFromVar = bl_var_to_int32
    static let initializeVar = bl_var_init_int32
    static let assignToVar = bl_var_assign_int32
}

extension Int64: BLTypedVarElement {
    static var objectType: BLObjectType { .int64 }

    static let getFromVar = bl_var_to_int64
    static let initializeVar = bl_var_init_int64
    static let assignToVar = bl_var_assign_int64
}

extension UInt32: BLTypedVarElement {
    static var objectType: BLObjectType { .uint64 }

    static let getFromVar = bl_var_to_uint32
    static let initializeVar = bl_var_init_uint32
    static let assignToVar = bl_var_assign_uint32
}

extension UInt64: BLTypedVarElement {
    static var objectType: BLObjectType { .uint64 }

    static let getFromVar = bl_var_to_uint64
    static let initializeVar = bl_var_init_uint64
    static let assignToVar = bl_var_assign_uint64
}

extension BLRgba32: BLTypedVarElement {
    static var objectType: BLObjectType { .rgba }

    static let getFromVar: GetterFunc = { (pointer, rgba32) in
        var value: UInt32 = 0
        defer {
            rgba32?.pointee.value = value
        }
        return bl_var_to_rgba32(pointer, &value)
    }
    static let initializeVar: InitializerFunc = { (pointer, rgba32) in
        bl_var_init_rgba32(pointer, rgba32.value)
    }
    static let assignToVar: AssignFunc = { (pointer, rgba32) in
        bl_var_assign_rgba32(pointer, rgba32.value)
    }
}

extension BLRgba64: BLTypedVarElement {
    static var objectType: BLObjectType { .rgba }

    static let getFromVar: GetterFunc = { (pointer, rgba64) in
        var value: UInt64 = 0
        defer {
            rgba64?.pointee.value = value
        }
        return bl_var_to_rgba64(pointer, &value)
    }
    static let initializeVar: InitializerFunc = { (pointer, rgba64) in
        bl_var_init_rgba64(pointer, rgba64.value)
    }
    static let assignToVar: AssignFunc = { (pointer, rgba64) in
        bl_var_assign_rgba64(pointer, rgba64.value)
    }
}

extension BLRgba: BLTypedVarElement {
    static var objectType: BLObjectType { .rgba }

    static let getFromVar: GetterFunc = bl_var_to_rgba
    static let initializeVar: InitializerFunc = { (pointer, rgba) in
        withUnsafePointer(to: rgba) {
            bl_var_init_rgba(pointer, $0)
        }
    }
    static let assignToVar: AssignFunc = { (pointer, rgba) in
        withUnsafePointer(to: rgba) {
            bl_var_assign_rgba(pointer, $0)
        }
    }
}
