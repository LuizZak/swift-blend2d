import blend2d

/// Common base class for almost all Swift-based Blend2D objects.
/// Blend2D structures that do not satisfy `CoreStructure` are implemented
/// manually without inheriting from this class.
public class BLBaseClass<T: CoreStructure> {
    /// The actual structure that this class backs.
    @usableFromInline
    final var object: T
    
    @usableFromInline
    init() {
        object = T()
        _ = T.initializer(&object)
    }
    
    @usableFromInline
    init(initializer: (UnsafeMutablePointer<T>?) throws -> BLResult) rethrows {
        object = T()
        try _ = initializer(&object)
    }
    
    @usableFromInline
    init?(initializer: (UnsafeMutablePointer<T>?) -> BLResult?) {
        object = T()
        if initializer(&object) == nil {
            return nil
        }
    }
    
    /// Initializes a new base class by performing a weak assignment of an existing
    /// backing structure.
    ///
    /// `T.assignWeak` is invoked to perform the weak assignment operation of
    /// the underlying object.
    @usableFromInline
    init(weakAssign object: T) {
        self.object = object
        _ = T.initializer(&self.object)
        
        withUnsafePointer(to: object) { pointer -> Void in
            _ = T.assignWeak(&self.object, pointer)
        }
    }
    
    /// Initializes a new base class by performing a strong assignment of an
    /// existing backing structure.
    ///
    /// The structure is simply assigned as-is without performing a reference-counting
    /// operation on Blend2D.
    ///
    /// Make sure you have sole ownership of the object passed, as it will be
    /// reset when this object deinitializes, and over-releasing the object is
    /// undefined behavior.
    @usableFromInline
    init(strongAssign object: T) {
        self.object = object
    }
    
    deinit {
        deinitialize()
    }
    
    /// Deinitializes the underlying structure.
    func deinitialize() {
        _ = T.deinitializer(&object)
    }
    
    @inlinable
    func copy() -> BLBaseClass {
        return BLBaseClass(weakAssign: object)
    }
}

/// Returns an empty 'assign-weak' function that does nothing, and returns
/// `BL_SUCCESS` every time.
///
/// Used to create empty function stubs for implementing the `CoreStructure.assignWeak`
/// conformance for types that do not have matching weak assignment functions in
/// Blend2D.
func emptyAssignWeak<T>(type: T.Type) -> (UnsafeMutablePointer<T>?, UnsafePointer<T>?) -> BLResult {
    return { _, _ in BL_SUCCESS.rawValue }
}
