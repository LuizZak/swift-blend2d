import blend2d

extension BLPoint: Equatable {
    public static func ==(lhs: BLPoint, rhs: BLPoint) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}
