import blend2d

public extension BLRectI {
    static let empty = BLRect(x: 0, y: 0, w: 0, h: 0)

    @inlinable
    var topLeft: BLPointI {
        BLPointI(x: x, y: y)
    }

    @inlinable
    var topRight: BLPointI {
        BLPointI(x: x + w, y: y)
    }

    @inlinable
    var bottomLeft: BLPointI {
        BLPointI(x: x, y: y + h)
    }

    @inlinable
    var bottomRight: BLPointI {
        BLPointI(x: x + w, y: y + h)
    }

    @inlinable
    var left: Int {
        Int(x)
    }

    @inlinable
    var right: Int {
        Int(x + w)
    }

    @inlinable
    var top: Int {
        Int(y)
    }

    @inlinable
    var bottom: Int {
        Int(y + h)
    }

    @inlinable
    var center: BLPointI {
        get {
            BLPointI(x: x + w / 2, y: y + h / 2)
        }
        set {
            (x, y) = (newValue.x - w / 2, newValue.y - h / 2)
        }
    }
    
    @inlinable
    var location: BLPointI {
        get {
            BLPointI(x: x, y: y)
        }
        set {
            (x, y) = (newValue.x, newValue.y)
        }
    }

    @inlinable
    var size: BLSizeI {
        get {
            BLSizeI(w: w, h: h)
        }
        set {
            (w, h) = (newValue.w, newValue.h)
        }
    }

    @inlinable
    var asBLBoxI: BLBoxI {
        BLBoxI(rectI: self)
    }

    init(location: BLPointI, size: BLSizeI) {
        self.init(x: location.x, y: location.y, w: size.w, h: size.h)
    }

    @inlinable
    init(rounding rect: BLRect) {
        self.init(
            x: Int32(rect.x.rounded()),
            y: Int32(rect.y.rounded()),
            w: Int32(rect.w.rounded()),
            h: Int32(rect.h.rounded())
        )
    }

    @inlinable
    init(roundingBox box: BLBox) {
        self.init(
            x: Int32(box.x0.rounded()),
            y: Int32(box.y0.rounded()),
            w: Int32(box.w.rounded()),
            h: Int32(box.h.rounded())
        )
    }

    @inlinable
    init(boxI: BLBoxI) {
        self.init(
            x: boxI.x0,
            y: boxI.y0,
            w: boxI.x1 - boxI.x0,
            h: boxI.y1 - boxI.y0
        )
    }

    @inlinable
    func insetBy(x: Int, y: Int) -> BLRectI {
        BLRectI(
            x: self.x + Int32(x) / 2,
            y: self.y + Int32(y) / 2,
            w: w - Int32(x),
            h: h - Int32(y)
        )
    }

    @inlinable
    func resized(width: Int, height: Int) -> BLRectI {
        BLRectI(x: x, y: y, w: Int32(width), h: Int32(height))
    }
    
    @inlinable
    func offsetBy(x: Int, y: Int) -> BLRectI {
        BLRectI(x: self.x + Int32(x), y: self.y + Int32(y), w: w, h: h)
    }

    @inlinable
    func contains(_ x: Int, _ y: Int) -> Bool {
        x >= self.x
            && y >= self.y
            && x < (self.x + w)
            && y < (self.y + h)
    }

    @inlinable
    func contains(_ point: BLPointI) -> Bool {
        contains(Int(point.x), Int(point.y))
    }

    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        contains(Int(point.x), Int(point.y))
    }

    /// Returns whether a given `BLRectI` rests completely inside the
    /// boundaries of this `BLRectI`
    func contains(_ other: BLRectI) -> Bool {
        other.topLeft.x >= topLeft.x
            && other.topLeft.y >= topLeft.y
            && other.bottomRight.x <= bottomRight.x
            && other.bottomRight.y <= bottomRight.y
    }

    /// Returns whether a given `BLRectI` intersects this `BLRectI`
    func intersects(_ other: BLRectI) -> Bool {
        // X overlap check.
        left <= other.right
            && right >= other.left
            && top <= other.bottom
            && bottom >= other.top
    }
}

// MARK: - Equatable
extension BLRectI: Equatable {
    @inlinable
    public static func == (lhs: BLRectI, rhs: BLRectI) -> Bool {
        lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}

// MARK: - Hashable
extension BLRectI: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(w)
        hasher.combine(h)
    }
}

// MARK: - CustomStringConvertible
extension BLRectI: CustomStringConvertible {
    public var description: String {
        "BLRectI(x: \(x), y: \(y), w: \(w), h: \(h))"
    }
}
