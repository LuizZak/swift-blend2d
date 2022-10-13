import Foundation
import blend2d

public extension BLPoint {
    /// A zero-valued BLPoint with coordinates (0, 0)
    static let zero = BLPoint(x: 0, y: 0)

    /// A one-valued BLPoint with coordinates (1, 1)
    static let one = BLPoint(x: 1, y: 1)

    /// Returns the magnitude of this point
    var magnitude: Double {
        (x * x + y * y).squareRoot()
    }

    /// Returns a normalized version of this point.
    /// In case this point lies at (0, 0), (0, 0) is returned.
    var normalized: BLPoint {
        if x == 0 && y == 0 {
            return .zero
        }

        let mag = magnitude
        return BLPoint(x: x / mag, y: y / mag)
    }
    
    @inlinable
    init(_ point: BLPointI) {
        self.init(x: Double(point.x), y: Double(point.y))
    }

    /// Returns the dot product between `self` and `other`.
    @inlinable
    func dot(_ other: BLPoint) -> Double {
        x * other.x + y * other.y
    }
    
    /// Returns the distance between this and another point
    @inlinable
    func distance(to other: BLPoint) -> Double {
        distanceSquared(to: other).squareRoot()
    }
    
    /// Returns the distance (squared) between this and another point
    @inlinable
    func distanceSquared(to other: BLPoint) -> Double {
        let dx = x - other.x
        let dy = y - other.y
        
        return dx * dx + dy * dy
    }
    
    /// Returns a new point which represents this point's coordinates rotated
    /// around a (0, 0) origin by a given radian amount
    @inlinable
    func rotated(by angleInRadians: Double) -> BLPoint {
        let c = cos(angleInRadians)
        let s = sin(angleInRadians)
        
        return BLPoint(x: (c * x) - (s * y), y: (s * x) + (c * y))
    }
    
    /// Returns a new point which represents this point's coordinates rotated
    /// around a given center point by a given radian amount
    @inlinable
    func rotated(around center: BLPoint, by angleInRadians: Double) -> BLPoint {
        (self - center).rotated(by: angleInRadians) + center
    }
}

// MARK: - Operators - BLPoint
public extension BLPoint {
    @inlinable
    static prefix func - (lhs: BLPoint) -> BLPoint {
        BLPoint(x: -lhs.x, y: -lhs.y)
    }
    
    @inlinable
    static func + (lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        BLPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    @inlinable
    static func - (lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        BLPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    @inlinable
    static func * (lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        BLPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }
    
    @inlinable
    static func / (lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        BLPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }
    
    @inlinable
    static func += (lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs + rhs
    }
    
    @inlinable
    static func -= (lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs - rhs
    }
    
    @inlinable
    static func *= (lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs * rhs
    }
    
    @inlinable
    static func /= (lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs / rhs
    }
}

// MARK: - Operators - Double
public extension BLPoint {
    @inlinable
    static func * (lhs: BLPoint, rhs: Double) -> BLPoint {
        BLPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    @inlinable
    static func / (lhs: BLPoint, rhs: Double) -> BLPoint {
        BLPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    
    @inlinable
    static func * (lhs: Double, rhs: BLPoint) -> BLPoint {
        BLPoint(x: lhs * rhs.x, y: lhs * rhs.y)
    }
    
    @inlinable
    static func / (lhs: Double, rhs: BLPoint) -> BLPoint {
        BLPoint(x: lhs / rhs.x, y: lhs / rhs.y)
    }
    
    @inlinable
    static func *= (lhs: inout BLPoint, rhs: Double) {
        lhs = lhs * rhs
    }
    
    @inlinable
    static func /= (lhs: inout BLPoint, rhs: Double) {
        lhs = lhs / rhs
    }
}

// MARK: - Equatable
extension BLPoint: Equatable {
    @inlinable
    public static func == (lhs: BLPoint, rhs: BLPoint) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

// MARK: - Hashable
extension BLPoint: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

// MARK: - Operations
public extension BLPoint {
    /// Returns a `BLPoint` where each coordinate is the minimal value between
    /// this and another `BLPoint`.
    @inlinable
    func pointwiseMin(_ other: BLPoint) -> BLPoint {
        BLPoint(x: min(x, other.x), y: min(y, other.y))
    }

    /// Returns a `BLPoint` where each coordinate is the maximal value between
    /// this and another `BLPoint`.
    @inlinable
    func pointwiseMax(_ other: BLPoint) -> BLPoint {
        BLPoint(x: max(x, other.x), y: max(y, other.y))
    }
}

extension BLPoint: CustomStringConvertible {
    public var description: String {
        "BLPoint(x: \(x), y: \(y))"
    }
}
