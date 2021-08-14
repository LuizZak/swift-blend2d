import blend2d

public extension BLLinearGradientValues {
    /// Creates a diagonal gradient from top-left to bottom-right that fills the
    /// given box's width.
    @inlinable
    init(box: BLBox) {
        self.init(x0: box.x0, y0: box.y0, x1: box.x1, y1: box.y1)
    }
    
    @inlinable
    init(start: BLPoint, end: BLPoint) {
        self.init(x0: start.x, y0: start.y, x1: end.x, y1: end.y)
    }
    
    @inlinable
    init(line: BLLine) {
        self.init(x0: line.x0, y0: line.y0, x1: line.x1, y1: line.y1)
    }
}
