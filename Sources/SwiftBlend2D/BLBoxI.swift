import blend2d

public extension BLBoxI {
    @inlinable
    var topLeft: BLPointI {
        return BLPointI(x: x0, y: y0)
    }
    
    @inlinable
    var topRight: BLPointI {
        return BLPointI(x: x1, y: y0)
    }
    
    @inlinable
    var bottomLeft: BLPointI {
        return BLPointI(x: x0, y: y1)
    }
    
    @inlinable
    var bottomRight: BLPointI {
        return BLPointI(x: x1, y: y1)
    }
    
    @inlinable
    var w: Int {
        return Int(x1 - x0)
    }
    
    @inlinable
    var h: Int {
        return Int(y1 - y0)
    }

    @inlinable
    var asRectangle: BLRectI {
        return BLRectI(x: x0, y: y0, w: x1 - x0, h: y1 - y0)
    }
    
    @inlinable
    var center: BLPointI {
        get {
            return BLPointI(x: (x0 + x1) / 2, y: (y0 + y1) / 2)
        }
        set {
            (x0, y0, x1, y1) = (newValue.x - Int32(w) / 2, newValue.y - Int32(h) / 2,
                                newValue.x + Int32(w) / 2, newValue.y + Int32(h) / 2)
        }
    }

    @inlinable
    init(x: Int, y: Int, width: Int, height: Int) {
        self.init(x0: Int32(x), y0: Int32(y), x1: Int32(x + width), y1: Int32(y + height))
    }
    
    @inlinable
    func contains(_ x: Int, _ y: Int) -> Bool {
        return x >= self.x0
            && y >= self.y0
            && x <  self.x1
            && y <  self.y1
    }
    
    @inlinable
    func contains(_ point: BLPointI) -> Bool {
        return point.x >= self.x0
            && point.y >= self.y0
            && point.x <  self.x1
            && point.y <  self.y1
    }

    @inlinable
    func offsetBy(x: Int, y: Int) -> BLBoxI {
        let x = Int32(x)
        let y = Int32(y)
        return BLBoxI(x0: x0 + x, y0: y0 + y, x1: x1 + x, y1: y1 + y)
    }

    @inlinable
    func insetBy(x: Int, y: Int) -> BLBoxI {
        let x = Int32(x)
        let y = Int32(y)
        return BLBoxI(x0: x0 + x / 2, y0: y0 + y / 2, x1: x1 - x / 2, y1: y1 - y / 2)
    }

    @inlinable
    func resized(width: Int, height: Int) -> BLBoxI {
        return BLBoxI(x0: x0, y0: y0, x1: x0 + Int32(width), y1: y0 + Int32(height))
    }
    
    @inlinable
    mutating func reset() {
        self.x0 = 0
        self.y0 = 0
        self.x1 = 0
        self.y1 = 0
    }
}

extension BLBoxI: Equatable {
    @inlinable
    public static func ==(lhs: BLBoxI, rhs: BLBoxI) -> Bool {
        return lhs.x0 == rhs.x0
            && lhs.y0 == rhs.y0
            && lhs.x1 == rhs.x1
            && lhs.y1 == rhs.y1
    }
}
