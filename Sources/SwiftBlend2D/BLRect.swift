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
    var location: BLPoint {
        get {
            return BLPoint(x: x, y: y)
        }
        set {
            (x, y) = (newValue.x, newValue.y)
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

    init(location: BLPoint, size: BLSize) {
        self.init(x: location.x, y: location.y, w: size.w, h: size.h)
    }

    @inlinable
    func insetBy(x: Double, y: Double) -> BLRect {
        return BLRect(x: self.x + x / 2, y: self.y + y / 2, w: w - x, h: h - y)
    }

    @inlinable
    func resized(width: Double, height: Double) -> BLRect {
        return BLRect(x: x, y: y, w: width, h: height)
    }

    @inlinable
    func contains(_ x: Double, _ y: Double) -> Bool {
        return x >= self.x
            && y >= self.y
            && x < (self.x + w)
            && y < (self.y + h)
    }

    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        return contains(point.x, point.y)
    }

    @inlinable
    func contains(_ point: BLPointI) -> Bool {
        return contains(Double(point.x), Double(point.y))
    }

    /// Returns whether a given `BLRect` rests completely inside the
    /// boundaries of this `BLRect`
    func contains(_ other: BLRect) -> Bool {
        return other.topLeft.x >= topLeft.x
            && other.topLeft.y >= topLeft.y
            && other.bottomRight.x <= bottomRight.x
            && other.bottomRight.y <= bottomRight.y
    }

    /// Returns whether a given `BLRect` intersects this `BLRect`
    func intersects(_ other: BLRect) -> Bool {
        // X overlap check.
        return left <= other.right
            && right >= other.left
            && top <= other.bottom
            && bottom >= other.top
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

extension BLRect: CustomStringConvertible {
    public var description: String {
        return "BLRect(x: \(x), y: \(y), w: \(w), h: \(h))"
    }
}
