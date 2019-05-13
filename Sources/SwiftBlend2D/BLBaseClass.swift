import blend2d

/// Common base class for almost all Swift-based Blend2D objects.
/// Blend2D structures that do not satisfy `CoreStructure` are implemented
/// manually without inheriting from this class.
public class BLBaseClass<T: CoreStructure> {
    /// The actual structure that this class backs.
    @usableFromInline
    final var object: T
    
    init() {
        object = T()
        _ = T.initializer(&object)
    }
    
    init(initializer: (UnsafeMutablePointer<T>?) throws -> BLResult) rethrows {
        object = T()
        try _ = initializer(&object)
    }
    
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
    init(weakAssign object: T) {
        self.object = object
        _ = T.initializer(&self.object)
        
        withUnsafePointer(to: object) { pointer -> Void in
            _ = T.assignWeak(&self.object, pointer)
        }
    }
    
    deinit {
        deinitialize()
    }
    
    /// Deinitializes the underlying structure.
    func deinitialize() {
        _ = T.deinitializer(&object)
    }
}

/// A protocol that should be refined by all `BL*Core` structures from Blend2D.
/// Must contain a default initializer and deinitializer.
///
/// In cases an initializer or deinitialzier take more parameters than 'self',
/// Swift wrapper classes must be created from scratch without inheriting from
/// 'BLBaseClass'
public protocol CoreStructure: BLArrayElement {
    static var initializer: (UnsafeMutablePointer<Self>?) -> BLResult { get }
    static var deinitializer: (UnsafeMutablePointer<Self>?) -> BLResult { get }
    static var assignWeak: (UnsafeMutablePointer<Self>?, UnsafePointer<Self>?) -> BLResult { get }
    
    init()
}

public extension CoreStructure {
    static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayOfVar)
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
