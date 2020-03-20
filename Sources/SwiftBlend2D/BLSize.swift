import blend2d

extension BLSize: Equatable {
    @inlinable
    public static func == (lhs: BLSize, rhs: BLSize) -> Bool {
        return lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}

// MARK: - Operators
public extension BLSize {
    @inlinable
    static func + (lhs: BLSize, rhs: BLSize) -> BLSize {
        return BLSize(w: lhs.w + rhs.w, h: lhs.h + rhs.h)
    }

    @inlinable
    static func - (lhs: BLSize, rhs: BLSize) -> BLSize {
        return BLSize(w: lhs.w - rhs.w, h: lhs.h - rhs.h)
    }

    @inlinable
    static func * (lhs: BLSize, rhs: BLSize) -> BLSize {
        return BLSize(w: lhs.w * rhs.w, h: lhs.h * rhs.h)
    }

    @inlinable
    static func / (lhs: BLSize, rhs: BLSize) -> BLSize {
        return BLSize(w: lhs.w / rhs.w, h: lhs.h / rhs.h)
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
