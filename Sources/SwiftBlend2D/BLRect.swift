import blend2d

extension BLRect: Equatable {
    @inlinable
    public static func ==(lhs: BLRect, rhs: BLRect) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}
