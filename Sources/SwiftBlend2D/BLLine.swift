import blend2d

public extension BLLine {
    @inlinable
    var start: BLPoint {
        get {
            return BLPoint(x: x0, y: y0)
        }
        set {
            (x0, y0) = (newValue.x, newValue.y)
        }
    }

    @inlinable
    var end: BLPoint {
        get {
            return BLPoint(x: x1, y: y1)
        }
        set {
            (x1, y1) = (newValue.x, newValue.y)
        }
    }

    @inlinable
    init(start: BLPoint, end: BLPoint) {
        self.init(x0: start.x, y0: start.y, x1: end.x, y1: end.y)
    }

    /// Rotates the line 90º counter-clockwise around its mid-point.
    @inlinable
    mutating func rotateLeft() {
        let cx = (x0 + x1) / 2
        let cy = (y0 + y1) / 2

        x0 -= cx
        y0 -= cy
        x1 -= cx
        y1 -= cy

        (x0, y0) = (y0, -x0)
        (x1, y1) = (y1, -x1)

        x0 += cx
        y0 += cy
        x1 += cx
        y1 += cy
    }

    /// Rotates the line 90º clockwise around its mid-point.
    @inlinable
    mutating func rotateRight() {
        let cx = (x0 + x1) / 2
        let cy = (y0 + y1) / 2

        x0 -= cx
        y0 -= cy
        x1 -= cx
        y1 -= cy

        (x0, y0) = (-y0, x0)
        (x1, y1) = (-y1, x1)

        x0 += cx
        y0 += cy
        x1 += cx
        y1 += cy
    }

    /// Returns this line, rotated 90º counter-clockwise around its mid-point.
    @inlinable
    func leftRotated() -> BLLine {
        var new = self
        new.rotateLeft()
        return new
    }

    /// Returns this line, rotated 90º clockwise around its mid-point.
    @inlinable
    func rightRotated() -> BLLine {
        var new = self
        new.rotateRight()
        return new
    }
}

extension BLLine: Equatable {
    @inlinable
    public static func == (lhs: BLLine, rhs: BLLine) -> Bool {
        return lhs.x0 == rhs.x0
            && lhs.y0 == rhs.y0
            && lhs.x1 == rhs.x1
            && lhs.y1 == rhs.y1
    }
}

extension BLLine: CustomStringConvertible {
    public var description: String {
        return "BLLine(x0: \(x0), y0: \(x0), x1: \(x1), y1: \(y1))"
    }
}
