import blend2d

public extension BLLine {
    @inlinable
    var start: BLPoint {
        get {
            BLPoint(x: x0, y: y0)
        }
        set {
            (x0, y0) = (newValue.x, newValue.y)
        }
    }

    @inlinable
    var end: BLPoint {
        get {
            BLPoint(x: x1, y: y1)
        }
        set {
            (x1, y1) = (newValue.x, newValue.y)
        }
    }
    
    /// The center point of this line
    @inlinable
    var center: BLPoint {
        get {
            BLPoint(x: (x0 + x1) / 2, y: (y0 + y1) / 2)
        }
        set {
            let old = center
            
            start = start - old + newValue
            end = end - old + newValue
        }
    }
    
    /// Returns the length of this line.
    @inlinable
    var length: Double {
        let dx = x0 - x1
        let dy = y0 - y1
        
        return (dx * dx + dy * dy).squareRoot()
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
    
    /// Returns this line, rotated by a certain radian angle around its center.
    func rotated(by angle: Double) -> BLLine {
        rotated(around: center, by: angle)
    }
    
    /// Returns this line, rotated around a given center point by a certain radian
    /// angle.
    func rotated(around center: BLPoint, by angle: Double) -> BLLine {
        BLLine(
            start: start.rotated(around: center, by: angle),
            end: end.rotated(around: center, by: angle)
        )
    }
}
