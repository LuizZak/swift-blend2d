import blend2d

public extension BLSize {
    static let zero = BLSize(w: 0, h: 0)
}

// MARK: - Equatable
extension BLSize: Equatable {
    @inlinable
    public static func == (lhs: BLSize, rhs: BLSize) -> Bool {
        lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}

// MARK: - Hashable
extension BLSize: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(w)
        hasher.combine(h)
    }
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
