import blend2d

extension BLFontVariation: Equatable {
    public static func == (lhs: BLFontVariation, rhs: BLFontVariation) -> Bool {
        return lhs.tag == rhs.tag && lhs.value == rhs.value
    }
}
