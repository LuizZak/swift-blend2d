import blend2d

extension BLGlyphItem: Equatable {
    public static func ==(lhs: BLGlyphItem, rhs: BLGlyphItem) -> Bool {
        return lhs.value == rhs.value
    }
}
