import blend2d

public extension BLPoint {
    /// A zero-valued BLPoint with coordinates (0, 0)
    static let zero = BLPoint(x: 0, y: 0)
}

extension BLPoint: Equatable {
    public static func ==(lhs: BLPoint, rhs: BLPoint) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}
