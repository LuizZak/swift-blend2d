import blend2d

public extension BLRoundRect {
    @inlinable
    var topLeft: BLPoint { BLPoint(x: x, y: y) }

    @inlinable
    var topRight: BLPoint { BLPoint(x: x + w, y: y) }

    @inlinable
    var bottomLeft: BLPoint { BLPoint(x: x, y: y + h) }

    @inlinable
    var bottomRight: BLPoint { BLPoint(x: x + w, y: y + h) }

    @inlinable
    var left: Double { x }

    @inlinable
    var right: Double { x + w }

    @inlinable
    var top: Double { y }

    @inlinable
    var bottom: Double { y + h }

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
    var size: BLSize {
        get {
            BLSize(w: w, h: h)
        }
        set {
            (w, h) = (newValue.w, newValue.h)
        }
    }

    @inlinable
    init(rect: BLRect, radius: BLPoint) {
        self.init(
            x: rect.x,
            y: rect.y,
            w: rect.w,
            h: rect.h,
            rx: radius.x,
            ry: radius.y
        )
    }

    /// Returns an inset copy of this rounded rectangle, with the area inset
    /// around its center by a given margin.
    ///
    /// Does not affect corner radius.
    @inlinable
    func insetBy(x: Double, y: Double) -> BLRoundRect {
        BLRoundRect(
            x: self.x + x / 2,
            y: self.y + y / 2,
            w: w - x,
            h: h - y,
            rx: rx,
            ry: ry
        )
    }
}

// MARK: - Equatable
extension BLRoundRect: Equatable {
    @inlinable
    public static func == (lhs: BLRoundRect, rhs: BLRoundRect) -> Bool {
        lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
            && lhs.rx == rhs.rx
            && lhs.ry == rhs.ry
    }
}

extension BLRoundRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(w)
        hasher.combine(h)
        hasher.combine(rx)
        hasher.combine(ry)
    }
}

// MARK: - CustomStringConvertible
extension BLRoundRect: CustomStringConvertible {
    public var description: String {
        "BLRoundRect(x: \(x), y: \(y), w: \(w), h: \(h), rx: \(rx), ry: \(ry))"
    }
}
