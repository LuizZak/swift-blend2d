import blend2d

extension BLContextCookie: @retroactive Equatable {
    @inlinable
    public static func == (lhs: BLContextCookie, rhs: BLContextCookie) -> Bool {
        lhs.data == rhs.data
    }
}
