import blend2d

public extension BLBox {
    @inlinable
    var width: Double {
        return x1 - x0
    }
    
    @inlinable
    var height: Double {
        return y1 - y0
    }
    
    @inlinable
    init(x: Double, y: Double, width: Double, height: Double) {
        self.init(x0: x, y0: y, x1: x + width, y1: y + height)
    }
    
    @inlinable
    func contains(_ x: Double, _ y: Double) -> Bool {
        return x >= self.x0
            && y >= self.y0
            && x <  self.x1
            && y <  self.y1
    }
    
    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        return contains(point.x, point.y)
    }
    
    @inlinable
    func contains(_ point: BLPointI) -> Bool {
        return contains(Double(point.x), Double(point.y))
    }
    
    @inlinable
    mutating func reset() {
        self.x0 = 0
        self.y0 = 0
        self.x1 = 0
        self.y1 = 0
    }
}

extension BLBox: Equatable {
    @inlinable
    public static func ==(lhs: BLBox, rhs: BLBox) -> Bool {
        return lhs.x0 == rhs.x0
            && lhs.y0 == rhs.y0
            && lhs.x1 == rhs.x1
            && lhs.y1 == rhs.y1
    }
}
