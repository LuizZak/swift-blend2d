import blend2d

public class BLContext {
    var context = BLContextCore()
    
    public init() {
        blContextInit(&context)
    }
    
    public init(image: BLImage, options: BLContextCreateOptions? = nil) {
        if var options = options {
            blContextInitAs(&context, &image.image, &options)
        } else {
            blContextInitAs(&context, &image.image, nil)
        }
    }
    
    deinit {
        blContextReset(&context)
    }
    
    public func setCompOp(_ op: BLCompOp) {
        blContextSetCompOp(&context, op.rawValue)
    }
    
    public func fillAll() {
        blContextFillAll(&context)
    }
    
    public func setFillStyleRgba32(_ value: UInt32) {
        blContextSetFillStyleRgba32(&context, value)
    }
    
    public func fillPath(_ path: BLPath) {
        blContextFillPathD(&context, &path.path)
    }
    
    public func end() {
        blContextEnd(&context)
    }
}
