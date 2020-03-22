import blend2d

public extension BLRect {
    @inlinable
    static var empty: BLRect {
        return BLRect(x: 0, y: 0, w: 0, h: 0)
    }

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

    @inlinable
    var asBLBox: BLBox {
        return BLBox(rect: self)
    }

    init(location: BLPoint, size: BLSize) {
        self.init(x: location.x, y: location.y, w: size.w, h: size.h)
    }

    @inlinable
    init(_ rectI: BLRectI) {
        self.init(x: Double(rectI.x), y: Double(rectI.y), w: Double(rectI.w), h: Double(rectI.h))
    }

    @inlinable
    init(box: BLBox) {
        self.init(x: box.x0, y: box.y0, w: box.w, h: box.h)
    }

    @inlinable
    init(boxI: BLBoxI) {
        self.init(x: Double(boxI.x0),
                  y: Double(boxI.y0),
                  w: Double(boxI.x1 - boxI.x0),
                  h: Double(boxI.y1 - boxI.y0))
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
    func offsetBy(x: Double, y: Double) -> BLRect {
        return BLRect(x: self.x + x, y: self.y + y, w: w, h: h)
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

// MARK: - Equatable
extension BLRect: Equatable {
    @inlinable
    public static func == (lhs: BLRect, rhs: BLRect) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}

// MARK: - Hashable
extension BLRect: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(w)
        hasher.combine(h)
    }
}

// MARK: - CustomStringConvertible
extension BLRect: CustomStringConvertible {
    public var description: String {
        return "BLRect(x: \(x), y: \(y), w: \(w), h: \(h))"
    }
}
