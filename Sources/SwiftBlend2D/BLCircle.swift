import blend2d

public extension BLCircle {
    init(cx: Double, cy: Double, radius: Double) {
        self.init(.init(.init(cx: cx, cy: cy)), r: radius)
    }
    
    init(center: BLPoint, radius: Double) {
        self.init(.init(center: center), r: radius)
    }
}

extension BLCircle: Equatable {
    public static func ==(lhs: BLCircle, rhs: BLCircle) -> Bool {
        return lhs.center == rhs.center
            && lhs.r == rhs.r
    }
}
