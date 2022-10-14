import blend2d

public extension BLSize {
    static let zero = BLSize(w: 0, h: 0)
}

// MARK: - CustomStringConvertible
extension BLSize: CustomStringConvertible {
    public var description: String {
        "BLSize(w: \(w), h: \(h))"
    }
}

// MARK: - Operators
public extension BLSize {
    @inlinable
    static func + (lhs: BLSize, rhs: BLSize) -> BLSize {
        BLSize(w: lhs.w + rhs.w, h: lhs.h + rhs.h)
    }

    @inlinable
    static func - (lhs: BLSize, rhs: BLSize) -> BLSize {
        BLSize(w: lhs.w - rhs.w, h: lhs.h - rhs.h)
    }

    @inlinable
    static func * (lhs: BLSize, rhs: BLSize) -> BLSize {
        BLSize(w: lhs.w * rhs.w, h: lhs.h * rhs.h)
    }

    @inlinable
    static func / (lhs: BLSize, rhs: BLSize) -> BLSize {
        BLSize(w: lhs.w / rhs.w, h: lhs.h / rhs.h)
    }

    @inlinable
    static func += (lhs: inout BLSize, rhs: BLSize) {
        lhs = lhs + rhs
    }

    @inlinable
    static func -= (lhs: inout BLSize, rhs: BLSize) {
        lhs = lhs - rhs
    }

    @inlinable
    static func *= (lhs: inout BLSize, rhs: BLSize) {
        lhs = lhs * rhs
    }

    @inlinable
    static func /= (lhs: inout BLSize, rhs: BLSize) {
        lhs = lhs / rhs
    }
}
