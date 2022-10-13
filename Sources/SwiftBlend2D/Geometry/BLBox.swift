import blend2d

public extension BLBox {
    static let empty = BLBox(x0: 0, y0: 0, x1: 0, y1: 0)

    @inlinable
    var topLeft: BLPoint {
        BLPoint(x: x0, y: y0)
    }
    
    @inlinable
    var topRight: BLPoint {
        BLPoint(x: x1, y: y0)
    }
    
    @inlinable
    var bottomLeft: BLPoint {
        BLPoint(x: x0, y: y1)
    }
    
    @inlinable
    var bottomRight: BLPoint {
        BLPoint(x: x1, y: y1)
    }
    
    @inlinable
    var w: Double {
        x1 - x0
    }
    
    @inlinable
    var h: Double {
        y1 - y0
    }

    @inlinable
    var asBLRect: BLRect {
        BLRect(box: self)
    }
    
    @inlinable
    var center: BLPoint {
        get {
            BLPoint(x: (x0 + x1) / 2, y: (y0 + y1) / 2)
        }
        set {
            (x0, y0, x1, y1) = (
                newValue.x - w / 2,
                newValue.y - h / 2,
                newValue.x + w / 2,
                newValue.y + h / 2
            )
        }
    }
    
    @inlinable
    init(_ box: BLBoxI) {
        self.init(
            x0: Double(box.x0),
            y0: Double(box.y0),
            x1: Double(box.x1),
            y1: Double(box.y1)
        )
    }

    @inlinable
    init(rect: BLRect) {
        self.init(x0: rect.x, y0: rect.y, x1: rect.right, y1: rect.bottom)
    }

    @inlinable
    init(rect: BLRectI) {
        self.init(
            x0: Double(rect.x),
            y0: Double(rect.y),
            x1: Double(rect.right),
            y1: Double(rect.bottom)
        )
    }

    @inlinable
    init(x: Double, y: Double, w: Double, h: Double) {
        self.init(x0: x, y0: y, x1: x + w, y1: y + h)
    }

    @inlinable
    init(boundsForPoints points: [BLPoint]) {
        guard let first = points.first else {
            self = BLBox.empty
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
    func contains(_ x: Double, _ y: Double) -> Bool {
        x >= self.x0
            && y >= self.y0
            && x <  self.x1
            && y <  self.y1
    }
    
    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        contains(point.x, point.y)
    }
    
    @inlinable
    func contains(_ point: BLPointI) -> Bool {
        contains(Double(point.x), Double(point.y))
    }

    @inlinable
    func offsetBy(x: Double, y: Double) -> BLBox {
        BLBox(x0: x0 + x, y0: y0 + y, x1: x1 + x, y1: y1 + y)
    }

    @inlinable
    func insetBy(x: Double, y: Double) -> BLBox {
        BLBox(
            x0: x0 + x / 2,
            y0: y0 + y / 2,
            x1: x1 - x / 2,
            y1: y1 - y / 2
        )
    }

    @inlinable
    func resized(width: Double, height: Double) -> BLBox {
        BLBox(x0: x0, y0: y0, x1: x0 + width, y1: y0 + height)
    }
    
    @inlinable
    mutating func reset() {
        self.x0 = 0
        self.y0 = 0
        self.x1 = 0
        self.y1 = 0
    }
}

// MARK: - Equatable
extension BLBox: Equatable {
    @inlinable
    public static func == (lhs: BLBox, rhs: BLBox) -> Bool {
        lhs.x0 == rhs.x0
            && lhs.y0 == rhs.y0
            && lhs.x1 == rhs.x1
            && lhs.y1 == rhs.y1
    }
}

// MARK: - Hashable
extension BLBox: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x0)
        hasher.combine(y0)
        hasher.combine(x1)
        hasher.combine(y1)
    }
}

// MARK: - CustomStringConvertible
extension BLBox: CustomStringConvertible {
    public var description: String {
        "BLBox(x0: \(x0), y0: \(y0), x1: \(x1), y1: \(y1))"
    }
}
