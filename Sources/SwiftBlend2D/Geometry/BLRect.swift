import blend2d

public extension BLRect {
    static let empty = BLRect(x: 0, y: 0, w: 0, h: 0)

    @inlinable
    var topLeft: BLPoint {
        BLPoint(x: x, y: y)
    }

    @inlinable
    var topRight: BLPoint {
        BLPoint(x: x + w, y: y)
    }

    @inlinable
    var bottomLeft: BLPoint {
        BLPoint(x: x, y: y + h)
    }

    @inlinable
    var bottomRight: BLPoint {
        BLPoint(x: x + w, y: y + h)
    }

    @inlinable
    var left: Double {
        x
    }

    @inlinable
    var right: Double {
        x + w
    }

    @inlinable
    var top: Double {
        y
    }

    @inlinable
    var bottom: Double {
        y + h
    }

    @inlinable
    var center: BLPoint {
        get {
            BLPoint(x: x + w / 2, y: y + h / 2)
        }
        set {
            (x, y) = (newValue.x - w / 2, newValue.y - h / 2)
        }
    }
    
    @inlinable
    var location: BLPoint {
        get {
            BLPoint(x: x, y: y)
        }
        set {
            (x, y) = (newValue.x, newValue.y)
        }
    }

    @inlinable
    var size: BLSize {
        get {
            BLSize(w: w, h: h)
        }
        set {
            (w, h) = (newValue.w, newValue.h)
        }
    }

    @inlinable
    var asBLBox: BLBox {
        BLBox(rect: self)
    }

    init(location: BLPoint, size: BLSize) {
        self.init(x: location.x, y: location.y, w: size.w, h: size.h)
    }

    @inlinable
    init(_ rectI: BLRectI) {
        self.init(
            x: Double(rectI.x),
            y: Double(rectI.y),
            w: Double(rectI.w),
            h: Double(rectI.h)
        )
    }

    @inlinable
    init(box: BLBox) {
        self.init(x: box.x0, y: box.y0, w: box.w, h: box.h)
    }

    @inlinable
    init(boxI: BLBoxI) {
        self.init(
            x: Double(boxI.x0),
            y: Double(boxI.y0),
            w: Double(boxI.x1 - boxI.x0),
            h: Double(boxI.y1 - boxI.y0)
        )
    }

    @inlinable
    func insetBy(x: Double, y: Double) -> BLRect {
        BLRect(x: self.x + x / 2, y: self.y + y / 2, w: w - x, h: h - y)
    }

    @inlinable
    func resized(width: Double, height: Double) -> BLRect {
        BLRect(x: x, y: y, w: width, h: height)
    }
    
    @inlinable
    func offsetBy(x: Double, y: Double) -> BLRect {
        BLRect(x: self.x + x, y: self.y + y, w: w, h: h)
    }

    @inlinable
    func contains(_ x: Double, _ y: Double) -> Bool {
        x >= self.x
            && y >= self.y
            && x < (self.x + w)
            && y < (self.y + h)
    }

    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        contains(point.x, point.y)
    }

    @inlinable
    func contains(_ point: BLPointI) -> Bool {
        contains(Double(point.x), Double(point.y))
    }

    /// Returns whether a given `BLRect` rests completely inside the
    /// boundaries of this `BLRect`
    func contains(_ other: BLRect) -> Bool {
        other.topLeft.x >= topLeft.x
            && other.topLeft.y >= topLeft.y
            && other.bottomRight.x <= bottomRight.x
            && other.bottomRight.y <= bottomRight.y
    }

    /// Returns whether a given `BLRect` intersects this `BLRect`
    func intersects(_ other: BLRect) -> Bool {
        // X overlap check.
        left <= other.right
            && right >= other.left
            && top <= other.bottom
            && bottom >= other.top
    }
}

// MARK: - CustomStringConvertible
extension BLRect: CustomStringConvertible {
    public var description: String {
        "BLRect(x: \(x), y: \(y), w: \(w), h: \(h))"
    }
}
