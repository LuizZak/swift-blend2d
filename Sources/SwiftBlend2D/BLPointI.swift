import blend2d

extension BLPointI: Equatable {
    public static func ==(lhs: BLPointI, rhs: BLPointI) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}
