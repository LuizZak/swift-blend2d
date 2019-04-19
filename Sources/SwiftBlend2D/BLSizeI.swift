import blend2d

extension BLSizeI: Equatable {
    @inlinable
    public static func == (lhs: BLSizeI, rhs: BLSizeI) -> Bool {
        return lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}
