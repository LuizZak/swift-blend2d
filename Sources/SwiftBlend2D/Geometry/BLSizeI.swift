import blend2d

public extension BLSizeI {
    static let zero = BLSizeI(w: 0, h: 0)
}

// MARK: - Operators
public extension BLSizeI {
    @inlinable
    static func + (lhs: BLSizeI, rhs: BLSizeI) -> BLSizeI {
        BLSizeI(w: lhs.w + rhs.w, h: lhs.h + rhs.h)
    }

    @inlinable
    static func - (lhs: BLSizeI, rhs: BLSizeI) -> BLSizeI {
        BLSizeI(w: lhs.w - rhs.w, h: lhs.h - rhs.h)
    }

    @inlinable
    static func * (lhs: BLSizeI, rhs: BLSizeI) -> BLSizeI {
        BLSizeI(w: lhs.w * rhs.w, h: lhs.h * rhs.h)
    }

    @inlinable
    static func / (lhs: BLSizeI, rhs: BLSizeI) -> BLSizeI {
        BLSizeI(w: lhs.w / rhs.w, h: lhs.h / rhs.h)
    }

    @inlinable
    static func += (lhs: inout BLSizeI, rhs: BLSizeI) {
        lhs = lhs + rhs
    }

    @inlinable
    static func -= (lhs: inout BLSizeI, rhs: BLSizeI) {
        lhs = lhs - rhs
    }

    @inlinable
    static func *= (lhs: inout BLSizeI, rhs: BLSizeI) {
        lhs = lhs * rhs
    }

    @inlinable
    static func /= (lhs: inout BLSizeI, rhs: BLSizeI) {
        lhs = lhs / rhs
    }
}
