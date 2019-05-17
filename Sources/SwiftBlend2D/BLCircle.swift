import blend2d

public extension BLCircle {
    @inlinable
    var center: BLPoint {
        get {
            return BLPoint(x: cx, y: cy)
        }
        set {
            (cx, cy) = (newValue.x, newValue.y)
        }
    }
    
    @inlinable
    var boundingBox: BLBox {
        get {
            return BLBox(x0: cx - r, y0: cy - r, x1: cx + r, y1: cy + r)
        }
    }
    
    @inlinable
    init(center: BLPoint, radius: Double) {
        self.init(cx: center.x, cy: center.y, r: radius)
    }

    @inlinable
    func expanding(by value: Double) -> BLCircle {
        return BLCircle(cx: cx, cy: cy, r: r + value)
    }
}

extension BLCircle: Equatable {
    @inlinable
    public static func ==(lhs: BLCircle, rhs: BLCircle) -> Bool {
        return lhs.cx == rhs.cx
            && lhs.cy == rhs.cy
            && lhs.r == rhs.r
    }
}
