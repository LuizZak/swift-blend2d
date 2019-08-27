import blend2d

public extension BLBox {
    @inlinable
    var topLeft: BLPoint {
        return BLPoint(x: x0, y: y0)
    }
    
    @inlinable
    var topRight: BLPoint {
        return BLPoint(x: x1, y: y0)
    }
    
    @inlinable
    var bottomLeft: BLPoint {
        return BLPoint(x: x0, y: y1)
    }
    
    @inlinable
    var bottomRight: BLPoint {
        return BLPoint(x: x1, y: y1)
    }
    
    @inlinable
    var w: Double {
        return x1 - x0
    }
    
    @inlinable
    var h: Double {
        return y1 - y0
    }

    @inlinable
    var asRectangle: BLRect {
        return BLRect(x: x0, y: y0, w: w, h: h)
    }
    
    @inlinable
    var center: BLPoint {
        get {
            return BLPoint(x: (x0 + x1) / 2, y: (y0 + y1) / 2)
        }
        set {
            (x0, y0, x1, y1) = (newValue.x - w / 2, newValue.y - h / 2,
                                newValue.x + w / 2, newValue.y + h / 2)
        }
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
    func offsetBy(x: Double, y: Double) -> BLBox {
        return BLBox(x0: x0 + x, y0: y0 + y, x1: x1 + x, y1: y1 + y)
    }

    @inlinable
    func insetBy(x: Double, y: Double) -> BLBox {
        return BLBox(x0: x0 + x / 2, y0: y0 + y / 2, x1: x1 - x / 2, y1: y1 - y / 2)
    }

    @inlinable
    func resized(width: Double, height: Double) -> BLBox {
        return BLBox(x0: x0, y0: y0, x1: x0 + width, y1: y0 + height)
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
