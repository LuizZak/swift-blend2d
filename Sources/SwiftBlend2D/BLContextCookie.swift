import blend2d

extension BLContextCookie: Equatable {
    @inlinable
    public static func == (lhs: BLContextCookie, rhs: BLContextCookie) -> Bool {
        lhs.data == rhs.data
    }
}
