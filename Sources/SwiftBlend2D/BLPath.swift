import blend2d

public class BLPath {
    var path = BLPathCore()
    
    public init() {
        blPathInit(&path)
    }
    
    deinit {
        blPathReset(&path)
    }
    
    public func moveTo(x: Double, y: Double) {
        blPathMoveTo(&path, x, y)
    }
    
    public func cubicTo(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) {
        blPathCubicTo(&path, x1, y1, x2, y2, x3, y3)
    }
}
