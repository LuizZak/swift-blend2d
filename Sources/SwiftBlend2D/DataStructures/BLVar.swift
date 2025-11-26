class BLVar {
    @usableFromInline
    final var object: BLVarCore

    var type: BLObjectType {
        bl_var_get_type(&object)
    }

    @usableFromInline
    init(type: BLObjectType) {
        object = BLVarCore()
        _ = bl_var_init_type(&object, type)
    }

    @usableFromInline
    init(initializer: (UnsafeMutablePointer<BLVarCore>) throws -> BLResult) rethrows {
        object = BLVarCore()
        try _ = initializer(&object)
    }

    @usableFromInline
    init?(initializer: (UnsafeMutablePointer<BLVarCore>) -> BLResult?) {
        object = BLVarCore()
        if initializer(&object) == nil {
            return nil
        }
    }

    @usableFromInline
    init(weakAssign object: BLVarCore) {
        self.object = BLVarCore()
        var object = object
        _ = bl_var_init_weak(&self.object, &object)
    }

    @usableFromInline
    init(strongAssign object: BLVarCore) {
        self.object = object
    }

    deinit {
        bl_var_reset(&object)
    }

    @inlinable
    func copy() -> BLVar {
        BLVar(weakAssign: object)
    }

    /// Returns a typed variant of this var object with a given type.
    func typed<T: BLTypedVarElement>(as type: T.Type = T.self) -> BLTypedVar<T> {
        BLTypedVar<T>(weakAssign: object)
    }

    /// Performs an unsafe cast of the underlying object reference to a specified
    /// core structure type.
    func unsafeCast<T: CoreStructure>(to type: T.Type = T.self) -> T {
        withUnsafePointer(to: object) { pointer in
            pointer.withMemoryRebound(to: T.self, capacity: 1) {
                $0.pointee
            }
        }
    }
}
