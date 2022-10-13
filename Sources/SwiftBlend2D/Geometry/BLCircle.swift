import blend2d

public extension BLCircle {
    /// A circle with diameter 1 with center at (0, 0)
    static let unitCircle = BLCircle(cx: 0, cy: 0, r: 0.5)
    
    @inlinable
    var center: BLPoint {
        get {
            BLPoint(x: cx, y: cy)
        }
        set {
            (cx, cy) = (newValue.x, newValue.y)
        }
    }
    
    @inlinable
    var boundingBox: BLBox {
        BLBox(x0: cx - r, y0: cy - r, x1: cx + r, y1: cy + r)
    }
    
    /// The diameter of this circle (r * 2)
    @inlinable
    var diameter: Double {
        get { r * 2 }
        set { r = newValue / 2 }
    }
    
    @inlinable
    init(center: BLPoint, radius: Double) {
        self.init(cx: center.x, cy: center.y, r: radius)
    }

    @inlinable
    func expanded(by value: Double) -> BLCircle {
        BLCircle(cx: cx, cy: cy, r: r + value)
    }

    @inlinable
    func contains(x: Double, y: Double) -> Bool {
        let dx = x - cx
        let dy = y - cy

        return dx * dx + dy * dy < r * r
    }

    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        contains(x: point.x, y: point.y)
    }
}

// MARK: - Equatable
extension BLCircle: Equatable {
    @inlinable
    public static func == (lhs: BLCircle, rhs: BLCircle) -> Bool {
        lhs.cx == rhs.cx
            && lhs.cy == rhs.cy
            && lhs.r == rhs.r
    }
}

// MARK: - Hashable
extension BLCircle: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cx)
        hasher.combine(cy)
        hasher.combine(r)
    }
}

// MARK: - CustomStringConvertible
extension BLCircle: CustomStringConvertible {
    public var description: String {
        return "BLCircle(cx: \(cx), cy: \(cy), r: \(r))"
    }
}
