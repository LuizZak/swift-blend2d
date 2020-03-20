import blend2d

extension BLFontUnicodeCoverage: Equatable {
    public static func == (lhs: BLFontUnicodeCoverage, rhs: BLFontUnicodeCoverage) -> Bool {
        return lhs.data == rhs.data
    }
}
