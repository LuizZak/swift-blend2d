import blend2d

public extension BLRange {
    static var everything: BLRange {
        return BLRange(start: 0, end: .max)
    }
}

extension BLRange: Equatable {
    @inlinable
    public static func ==(lhs: BLRange, rhs: BLRange) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}
