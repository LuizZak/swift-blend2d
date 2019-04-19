import blend2d

public extension BLPoint {
    /// A zero-valued BLPoint with coordinates (0, 0)
    static let zero = BLPoint(x: 0, y: 0)
    
    init(_ point: BLPointI) {
        self.init(x: Double(point.x), y: Double(point.y))
    }
}

extension BLPoint: Equatable {
    public static func ==(lhs: BLPoint, rhs: BLPoint) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}
