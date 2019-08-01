import blend2d

public extension BLPoint {
    /// A zero-valued BLPoint with coordinates (0, 0)
    static let zero = BLPoint(x: 0, y: 0)

    /// A one-valued BLPoint with coordinates (1, 1)
    static let one = BLPoint(x: 1, y: 1)
    
    @inlinable
    init(_ point: BLPointI) {
        self.init(x: Double(point.x), y: Double(point.y))
    }
}

// MARK: - Operators - BLPoint
public extension BLPoint {
    @inlinable
    static prefix func -(lhs: BLPoint) -> BLPoint {
        return BLPoint(x: -lhs.x, y: -lhs.y)
    }
    
    @inlinable
    static func +(lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    @inlinable
    static func -(lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    @inlinable
    static func *(lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }
    
    @inlinable
    static func /(lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }
    
    @inlinable
    static func +=(lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs + rhs
    }
    
    @inlinable
    static func -=(lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs - rhs
    }
    
    @inlinable
    static func *=(lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs * rhs
    }
    
    @inlinable
    static func /=(lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs / rhs
    }
}

// MARK: - Operators - Double
public extension BLPoint {
    @inlinable
    static func *(lhs: BLPoint, rhs: Double) -> BLPoint {
        return BLPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    @inlinable
    static func /(lhs: BLPoint, rhs: Double) -> BLPoint {
        return BLPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    
    @inlinable
    static func *(lhs: Double, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs * rhs.x, y: lhs * rhs.y)
    }
    
    @inlinable
    static func /(lhs: Double, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs / rhs.x, y: lhs / rhs.y)
    }
    
    @inlinable
    static func *=(lhs: inout BLPoint, rhs: Double) {
        lhs = lhs * rhs
    }
    
    @inlinable
    static func /=(lhs: inout BLPoint, rhs: Double) {
        lhs = lhs / rhs
    }
}

// MARK: - Equatable
extension BLPoint: Equatable {
    @inlinable
    public static func ==(lhs: BLPoint, rhs: BLPoint) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}

// MARK: - Operations
extension BLPoint {
    /// Returns a `BLPoint` where each coordinate is the minimal value between
    /// this and another `BLPoint`.
    func pointwiseMin(_ other: BLPoint) -> BLPoint {
        return BLPoint(x: min(x, other.x), y: min(y, other.y))
    }

    /// Returns a `BLPoint` where each coordinate is the maximal value between
    /// this and another `BLPoint`.
    func pointwiseMax(_ other: BLPoint) -> BLPoint {
        return BLPoint(x: max(x, other.x), y: max(y, other.y))
    }
}
