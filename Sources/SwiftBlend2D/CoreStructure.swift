import blend2d

/// A protocol that should be refined by all `BL*Core` structures from Blend2D.
/// Must contain a default initializer and deinitializer.
///
/// In cases an initializer or deinitialzier take more parameters than 'self',
/// Swift wrapper classes must be created from scratch without inheriting from
/// `BLBaseClass`
public protocol CoreStructure: BLArrayElement {
    static var initializer: (UnsafeMutablePointer<Self>?) -> BLResult { get }
    static var deinitializer: (UnsafeMutablePointer<Self>?) -> BLResult { get }
    static var assignWeak: (UnsafeMutablePointer<Self>?, UnsafePointer<Self>?) -> BLResult { get }
    
    init()
}

public extension CoreStructure {
    static var arrayImplementationType: BLArrayType {
        return BLArrayType(arrayType: .arrayObject)
    }
}
