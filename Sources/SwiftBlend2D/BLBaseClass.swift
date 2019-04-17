import blend2d

/// Common base class for almost all Swift-based Blend2D objects.
/// Blend2D structures that do not satisfy `CoreStructure` are implemented
/// manually without inheriting from this class.
public class BLBaseClass<T: CoreStructure> {
    /// The actual structure that this class backs.
    final var object: T
    final var ownership: PointerOwnership
    
    init() {
        object = T()
        _ = T.initializer(&object)
        ownership = .owner
    }
    
    init(initializer: (UnsafeMutablePointer<T>?) throws -> BLResult) rethrows {
        object = T()
        try _ = initializer(&object)
        ownership = .owner
    }
    
    init?(initializer: (UnsafeMutablePointer<T>?) -> BLResult?) {
        object = T()
        if initializer(&object) == nil {
            return nil
        }
        ownership = .owner
    }
    
    init(object: T, ownership: PointerOwnership) {
        self.object = object
        self.ownership = ownership
    }
    
    /// Initializes a new base class borrowing the backing structure from an
    /// existing structure.
    ///
    /// This is an unsafe operation (as the backing structure might be reset
    /// while this object is alive), and should not be performed for structures
    /// that are not long-lived.
    init(borrowing object: T) {
        self.object = object
        ownership = .borrowed
    }
    
    deinit {
        deinitialize()
    }
    
    /// Deinitializes the underlying structure.
    /// Is a no-op in case this class is not the owner of the backing structure.
    func deinitialize() {
        if ownership == .owner {
            _ = T.deinitializer(&object)
        }
    }
}

/// A protocol that should be refined by all `BL*Core` structures from Blend2D.
/// Must contain a default initializer and deinitializer.
///
/// In cases an initializer or deinitialzier take more parameters than 'self', Swift wrapper classes must be created from scratch without inheriting from 'BLBaseClass'
public protocol CoreStructure {
    static var initializer: (UnsafeMutablePointer<Self>?) -> BLResult { get }
    static var deinitializer: (UnsafeMutablePointer<Self>?) -> BLResult { get }
    
    init()
}
