import blend2d

public extension BLRect {
    @inlinable
    var topLeft: BLPoint {
        return BLPoint(x: x, y: y)
    }

    @inlinable
    var topRight: BLPoint {
        return BLPoint(x: x + w, y: y)
    }

    @inlinable
    var bottomLeft: BLPoint {
        return BLPoint(x: x, y: y + h)
    }

    @inlinable
    var bottomRight: BLPoint {
        return BLPoint(x: x + w, y: y + h)
    }

    @inlinable
    var left: Double {
        return x
    }

    @inlinable
    var right: Double {
        return x + w
    }

    @inlinable
    var top: Double {
        return y
    }

    @inlinable
    var bottom: Double {
        return y + h
    }

    @inlinable
    var center: BLPoint {
        get {
            return BLPoint(x: x + w / 2, y: y + h / 2)
        }
        set {
            (x, y) = (newValue.x - w / 2, newValue.y - h / 2)
        }
    }

    @inlinable
    var size: BLSize {
        get {
            return BLSize(w: w, h: h)
        }
        set {
            (w, h) = (newValue.w, newValue.h)
        }
    }

    @inlinable
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
