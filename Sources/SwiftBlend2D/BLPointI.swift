import blend2d

public extension BLPointI {
    /// A zero-valued BLPointI with coordinates (0, 0)
    static let zero = BLPointI(x: 0, y: 0)
}

extension BLPointI: Equatable {
    public static func ==(lhs: BLPointI, rhs: BLPointI) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}
