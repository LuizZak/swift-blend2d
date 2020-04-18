import blend2d

public class BLStyle: BLBaseClass<BLStyleCore> {
    public override init() {
        super.init()
    }
    
    public init(gradient: BLGradient) {
        super.init { pointer in
            blStyleInitObject(pointer, &gradient.box.object)
        }
    }
    
    public init(pattern: BLPattern) {
        super.init { pointer in
            blStyleInitObject(pointer, &pattern.box.object)
        }
    }
    
    public init(rgba: BLRgba) {
        super.init { pointer in
            withUnsafePointer(to: rgba) { rgbPtr in
                blStyleInitRgba(pointer, rgbPtr)
            }
        }
    }
}

extension BLStyleCore: CoreStructure {
    public static var arrayImplementationType: BLArrayType = .init(arrayType: .arrayOfVar)
    
    public static var initializer = blStyleInit
    public static var deinitializer = blStyleReset
    public static var assignWeak = blStyleInitWeak
}
