import blend2d

public class BLPath: BLBaseClass<BLPathCore> {
    var capacity: Int {
        return blPathGetCapacity(&object)
    }
    
    public override init() {
        super.init()
    }
    
    public func moveTo(x: Double, y: Double) {
        blPathMoveTo(&object, x, y)
    }
    
    public func cubicTo(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) {
        blPathCubicTo(&object, x1, y1, x2, y2, x3, y3)
    }
    
    public func quadTo(x1: Double, y1: Double, x2: Double, y2: Double) {
        blPathQuadTo(&object, x1, y1, x2, y2)
    }
    
    public func clear() {
        blPathClear(&object)
    }
    
    public func shrink() {
        blPathShrink(&object)
    }
    
    public func equals(to other: BLPath) -> Bool {
        return blPathEquals(&object, &other.object)
    }
}

extension BLPathCore: CoreStructure {
    public static var initializer = blPathInit
    public static var deinitializer = blPathReset
}
