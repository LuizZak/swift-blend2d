import blend2d

public extension BLRoundRect {
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
    var size: BLSize {
        get {
            return BLSize(w: w, h: h)
        }
        set {
            (w, h) = (newValue.w, newValue.h)
        }
    }

    @inlinable
    init(rect: BLRect, radius: BLPoint) {
        self.init(x: rect.x, y: rect.y, w: rect.w, h: rect.h, rx: radius.x, ry: radius.y)
    }

    /// Returns an inset copy of this rounded rectangle, with the area inset
    /// arounds its center by a given margin.
    ///
    /// Does not affect corner radius.
    @inlinable
    func insetBy(x: Double, y: Double) -> BLRoundRect {
        return BLRoundRect(x: self.x + x / 2, y: self.y + y / 2, w: w - x, h: h - y, rx: rx, ry: ry)
    }
}

extension BLRoundRect: Equatable {
    @inlinable
    public static func ==(lhs: BLRoundRect, rhs: BLRoundRect) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
            && lhs.rx == rhs.rx
            && lhs.ry == rhs.ry
    }
}
