import blend2d

extension BLFontUnicodeCoverage: @retroactive Equatable {
    public static func == (lhs: BLFontUnicodeCoverage, rhs: BLFontUnicodeCoverage) -> Bool {
        lhs.data == rhs.data
    }
}
