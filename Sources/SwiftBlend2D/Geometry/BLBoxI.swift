import blend2d

public extension BLBoxI {
    static let empty = BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0)

    @inlinable
    var topLeft: BLPointI {
        BLPointI(x: x0, y: y0)
    }
    
    @inlinable
    var topRight: BLPointI {
        BLPointI(x: x1, y: y0)
    }
    
    @inlinable
    var bottomLeft: BLPointI {
        BLPointI(x: x0, y: y1)
    }
    
    @inlinable
    var bottomRight: BLPointI {
        BLPointI(x: x1, y: y1)
    }
    
    @inlinable
    var w: Int {
        Int(x1 - x0)
    }
    
    @inlinable
    var h: Int {
        Int(y1 - y0)
    }

    @inlinable
    var asBLRectI: BLRectI {
        BLRectI(boxI: self)
    }
    
    @inlinable
    var center: BLPointI {
        get {
            BLPointI(x: (x0 + x1) / 2, y: (y0 + y1) / 2)
        }
        set {
            (x0, y0, x1, y1) = (
                newValue.x - Int32(w) / 2,
                newValue.y - Int32(h) / 2,
                newValue.x + Int32(w) / 2,
                newValue.y + Int32(h) / 2
            )
        }
    }

    @inlinable
    init(x: Int, y: Int, w: Int, h: Int) {
        self.init(
            x0: Int32(x),
            y0: Int32(y),
            x1: Int32(x + w),
            y1: Int32(y + h)
        )
    }

    @inlinable
    init(rectI: BLRectI) {
        self.init(
            x0: rectI.x,
            y0: rectI.y,
            x1: rectI.x + rectI.w,
            y1: rectI.y + rectI.h
        )
    }

    @inlinable
    init(rounding box: BLBox) {
        self.init(
            x0: Int32(box.x0.rounded()),
            y0: Int32(box.y0.rounded()),
            x1: Int32(box.x1.rounded()),
            y1: Int32(box.y1.rounded())
        )
    }

    @inlinable
    init(roundingRect rect: BLRect) {
        self.init(
            x0: Int32(rect.x.rounded()),
            y0: Int32(rect.y.rounded()),
            x1: Int32(rect.right.rounded()),
            y1: Int32(rect.bottom.rounded())
        )
    }

    @inlinable
    init(boundsForPoints points: [BLPointI]) {
        guard let first = points.first else {
            self = BLBoxI.empty
            return
        }

        var min = first
        var max = first

        for point in points {
            min = min.pointwiseMin(point)
            max = max.pointwiseMax(point)
        }

        self.init(x0: min.x, y0: min.y, x1: max.x, y1: max.y)
    }
    
    @inlinable
    func contains(_ x: Int, _ y: Int) -> Bool {
        x >= self.x0
            && y >= self.y0
            && x <  self.x1
            && y <  self.y1
    }
    
    @inlinable
    func contains(_ point: BLPointI) -> Bool {
        point.x >= self.x0
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
        BLBoxI(x0: x0, y0: y0, x1: x0 + Int32(width), y1: y0 + Int32(height))
    }
    
    @inlinable
    mutating func reset() {
        self.x0 = 0
        self.y0 = 0
        self.x1 = 0
        self.y1 = 0
    }
}
