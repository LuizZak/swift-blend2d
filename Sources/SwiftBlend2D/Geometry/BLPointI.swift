import blend2d

public extension BLPointI {
    /// A zero-valued BLPointI with coordinates (0, 0)
    static let zero = BLPointI(x: 0, y: 0)

    /// A one-valued BLPoint with coordinates (1, 1)
    static let one = BLPointI(x: 1, y: 1)

    @inlinable
    init(rounding point: BLPoint) {
        self.init(x: Int32(point.x.rounded()), y: Int32(point.y.rounded()))
    }

    /// Returns the dot product between `self` and `other`.
    @inlinable
    func dot(_ other: BLPointI) -> Int {
        Int(x * other.x + y * other.y)
    }
}

// MARK: - Operators
public extension BLPointI {
    @inlinable
    static prefix func - (lhs: BLPointI) -> BLPointI {
        BLPointI(x: -lhs.x, y: -lhs.y)
    }

    @inlinable
    static func + (lhs: BLPointI, rhs: BLPointI) -> BLPointI {
        BLPointI(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    @inlinable
    static func - (lhs: BLPointI, rhs: BLPointI) -> BLPointI {
        BLPointI(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    @inlinable
    static func * (lhs: BLPointI, rhs: BLPointI) -> BLPointI {
        BLPointI(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }
    
    @inlinable
    static func / (lhs: BLPointI, rhs: BLPointI) -> BLPointI {
        BLPointI(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }

    @inlinable
    static func += (lhs: inout BLPointI, rhs: BLPointI) {
        lhs = lhs + rhs
    }

    @inlinable
    static func -= (lhs: inout BLPointI, rhs: BLPointI) {
        lhs = lhs - rhs
    }

    @inlinable
    static func *= (lhs: inout BLPointI, rhs: BLPointI) {
        lhs = lhs * rhs
    }
    
    @inlinable
    static func /= (lhs: inout BLPointI, rhs: BLPointI) {
        lhs = lhs / rhs
    }
}

// MARK: - Operators - Int
public extension BLPointI {
    @inlinable
    static func * (lhs: BLPointI, rhs: Int) -> BLPointI {
        BLPointI(x: lhs.x * Int32(rhs), y: lhs.y * Int32(rhs))
    }
    
    @inlinable
    static func / (lhs: BLPointI, rhs: Int) -> BLPointI {
        BLPointI(x: lhs.x / Int32(rhs), y: lhs.y / Int32(rhs))
    }
    
    @inlinable
    static func * (lhs: Int, rhs: BLPointI) -> BLPointI {
        BLPointI(x: Int32(lhs) * rhs.x, y: Int32(lhs) * rhs.y)
    }
    
    @inlinable
    static func / (lhs: Int, rhs: BLPointI) -> BLPointI {
        BLPointI(x: Int32(lhs) / rhs.x, y: Int32(lhs) / rhs.y)
    }
    
    @inlinable
    static func *= (lhs: inout BLPointI, rhs: Int) {
        lhs = lhs * rhs
    }
    
    @inlinable
    static func /= (lhs: inout BLPointI, rhs: Int) {
        lhs = lhs / rhs
    }
}

// MARK: - Operations
extension BLPointI {
    /// Returns a `BLPoint` where each coordinate is the minimal value between
    /// this and another `BLPoint`.
    public func pointwiseMin(_ other: BLPointI) -> BLPointI {
        BLPointI(x: min(x, other.x), y: min(y, other.y))
    }

    /// Returns a `BLPoint` where each coordinate is the maximal value between
    /// this and another `BLPoint`.
    public func pointwiseMax(_ other: BLPointI) -> BLPointI {
        BLPointI(x: max(x, other.x), y: max(y, other.y))
    }
}
