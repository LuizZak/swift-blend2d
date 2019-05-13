import blend2d

public extension BLRect {
    var topLeft: BLPoint {
        return BLPoint(x: x, y: y)
    }

    var topRight: BLPoint {
        return BLPoint(x: x + w, y: y)
    }

    var bottomLeft: BLPoint {
        return BLPoint(x: x, y: y + h)
    }

    var bottomRight: BLPoint {
        return BLPoint(x: x + w, y: y + h)
    }

    func insetBy(x: Double, y: Double) -> BLRect {
        return BLRect(x: self.x + x / 2, y: self.y + y / 2, w: w - x, h: h - y)
    }
}

extension BLRect: Equatable {
    @inlinable
    public static func ==(lhs: BLRect, rhs: BLRect) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}
