/// A box to wrap `CoreStructure` instances with copy-on-write semantics.
@usableFromInline
class Box<T: CoreStructure> {
    @usableFromInline
    var object: T
    
    @inlinable
    init() {
        object = T()
        _ = T.initializer(&object)
    }
    
    @inlinable
    init(_ closure: (UnsafeMutablePointer<T>?) -> Void) {
        object = T()
        closure(&object)
    }
    
    @inlinable
    init(copying box: Box) {
        object = T()
        _ = T.initializer(&object)
        
        _ = T.assignWeak(&object, &box.object)
    }
    
    deinit {
        _ = T.deinitializer(&object)
    }
    
    @inlinable
    func copy() -> Box {
        return Box(copying: self)
    }
}
