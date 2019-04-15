import blend2d

extension BLContextCookie: Equatable {
    public static func ==(lhs: BLContextCookie, rhs: BLContextCookie) -> Bool {
        return lhs.data == rhs.data
    }
}
