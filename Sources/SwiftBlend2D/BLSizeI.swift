import blend2d

public extension BLSizeI {
    static let zero = BLSizeI(w: 0, h: 0)
}

// MARK: - Equatable
extension BLSizeI: Equatable {
    @inlinable
    public static func == (lhs: BLSizeI, rhs: BLSizeI) -> Bool {
        return lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}

// MARK: - Hashable
extension BLSizeI: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(w)
        hasher.combine(h)
    }
}

// MARK: - CustomStringConvertible
extension BLSizeI: CustomStringConvertible {
    public var description: String {
        return "BLSizeI(w: \(w), h: \(h))"
    }
}

// MARK: - Operators
public extension BLSizeI {
    @inlinable
    static func + (lhs: BLSizeI, rhs: BLSizeI) -> BLSizeI {
        return BLSizeI(w: lhs.w + rhs.w, h: lhs.h + rhs.h)
    }

    @inlinable
    static func - (lhs: BLSizeI, rhs: BLSizeI) -> BLSizeI {
        return BLSizeI(w: lhs.w - rhs.w, h: lhs.h - rhs.h)
    }

    @inlinable
    static func * (lhs: BLSizeI, rhs: BLSizeI) -> BLSizeI {
        return BLSizeI(w: lhs.w * rhs.w, h: lhs.h * rhs.h)
    }

    @inlinable
    static func / (lhs: BLSizeI, rhs: BLSizeI) -> BLSizeI {
        return BLSizeI(w: lhs.w / rhs.w, h: lhs.h / rhs.h)
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
