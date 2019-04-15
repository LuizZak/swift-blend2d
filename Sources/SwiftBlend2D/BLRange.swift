import blend2d

extension BLRange: Equatable {
    public static func ==(lhs: BLRange, rhs: BLRange) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}
