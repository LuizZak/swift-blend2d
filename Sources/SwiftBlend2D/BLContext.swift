import blend2d

public class BLContext: BLBaseClass<BLContextCore> {
    private var _ended: Bool = false
    
    public override init() {
        super.init()
    }
    
    public init(image: BLImage, options: BLContextCreateOptions? = nil) {
        if var options = options {
            super.init {
                blContextInitAs($0, &image.object, &options)
            }
        } else {
            super.init {
                blContextInitAs($0, &image.object, nil)
            }
        }
    }
    
    public func setCompOp(_ op: BLCompOp) {
        ensureNotEnded()
        
        blContextSetCompOp(&object, op.rawValue)
    }
    
    /// Fills everything.
    public func fillAll() {
        ensureNotEnded()
        
        blContextFillAll(&object)
    }
    
    public func setFillStyleRgba32(_ value: UInt32) {
        ensureNotEnded()
        
        blContextSetFillStyleRgba32(&self.object, value)
    }
    
    public func fillPath(_ path: BLPath) {
        ensureNotEnded()
        
        blContextFillPathD(&object, &path.object)
    }
    
    /// Waits for completion of all render commands and detaches the rendering
    /// context from the rendering target. After `end()` completes the rendering
    /// context implementation would be released and replaced by a built-in null
    /// instance (no context).
    ///
    /// - note: After a call to `end`, no more invocations should be performed
    /// on this context instance.
    public func end() {
        blContextEnd(&object)
        
        _ended = true
    }
    
    private func ensureNotEnded() {
        if _ended {
            fatalError("Cannot manipulate BLContext after it has ended via end()")
        }
    }
}

extension BLContextCore: CoreStructure {
    public static var initializer = blContextInit
    public static var deinitializer = blContextReset
}
