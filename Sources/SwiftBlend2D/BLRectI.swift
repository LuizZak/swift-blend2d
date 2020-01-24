import blend2d

public extension BLRectI {
    @inlinable
    var topLeft: BLPointI {
        return BLPointI(x: x, y: y)
    }

    @inlinable
    var topRight: BLPointI {
        return BLPointI(x: x + w, y: y)
    }

    @inlinable
    var bottomLeft: BLPointI {
        return BLPointI(x: x, y: y + h)
    }

    @inlinable
    var bottomRight: BLPointI {
        return BLPointI(x: x + w, y: y + h)
    }

    @inlinable
    var left: Int {
        return Int(x)
    }

    @inlinable
    var right: Int {
        return Int(x + w)
    }

    @inlinable
    var top: Int {
        return Int(y)
    }

    @inlinable
    var bottom: Int {
        return Int(y + h)
    }

    @inlinable
    var center: BLPointI {
        get {
            return BLPointI(x: x + w / 2, y: y + h / 2)
        }
        set {
            (x, y) = (newValue.x - w / 2, newValue.y - h / 2)
        }
    }

    @inlinable
    var size: BLSizeI {
        get {
            return BLSizeI(w: w, h: h)
        }
        set {
            (w, h) = (newValue.w, newValue.h)
        }
    }

    init(location: BLPointI, size: BLSizeI) {
        self.init(x: location.x, y: location.y, w: size.w, h: size.h)
    }

    @inlinable
    init(rounding rect: BLRect) {
        self.init(x: Int32(round(rect.x)),
                  y: Int32(round(rect.y)),
                  w: Int32(round(rect.w)),
                  h: Int32(round(rect.h)))
    }

    @inlinable
    func insetBy(x: Int, y: Int) -> BLRectI {
        return BLRectI(x: self.x + Int32(x) / 2, y: self.y + Int32(y) / 2, w: w - Int32(x), h: h - Int32(y))
    }

    @inlinable
    func resized(width: Int, height: Int) -> BLRectI {
        return BLRectI(x: x, y: y, w: Int32(width), h: Int32(height))
    }

    @inlinable
    func contains(_ x: Int, _ y: Int) -> Bool {
        return x >= self.x
            && y >= self.y
            && x < (self.x + w)
            && y < (self.y + h)
    }

    @inlinable
    func contains(_ point: BLPointI) -> Bool {
        return contains(Int(point.x), Int(point.y))
    }

    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        return contains(Int(point.x), Int(point.y))
    }

    /// Returns whether a given `BLRectI` rests completely inside the
    /// boundaries of this `BLRectI`
    func contains(_ other: BLRectI) -> Bool {
        return other.topLeft.x >= topLeft.x
            && other.topLeft.y >= topLeft.y
            && other.bottomRight.x <= bottomRight.x
            && other.bottomRight.y <= bottomRight.y
    }

    /// Returns whether a given `BLRectI` intersects this `BLRectI`
    func intersects(_ other: BLRectI) -> Bool {
        // X overlap check.
        return left <= other.right
            && right >= other.left
            && top <= other.bottom
            && bottom >= other.top
    }
}

extension BLRectI: Equatable {
    @inlinable
    public static func ==(lhs: BLRectI, rhs: BLRectI) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}

extension BLRectI: CustomStringConvertible {
    public var description: String {
        return "BLRectI(x: \(x), y: \(y), w: \(w), h: \(h))"
    }
}
