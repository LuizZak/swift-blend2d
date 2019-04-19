import blend2d

extension BLSize: Equatable {
    @inlinable
    public static func == (lhs: BLSize, rhs: BLSize) -> Bool {
        return lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}
