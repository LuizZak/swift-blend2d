import blend2d

public extension BLRange {
    static var everything: BLRange {
        return BLRange(start: 0, end: .max)
    }
}
