import blend2d

extension BLRectI: Equatable {
    @inlinable
    public static func ==(lhs: BLRectI, rhs: BLRectI) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}
