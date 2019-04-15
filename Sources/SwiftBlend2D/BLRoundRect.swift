import blend2d

public extension BLRoundRect {
    init(rect: BLRect, radius: BLPoint) {
        self.init(.init(rect: rect), .init(radius: radius))
    }
}

extension BLRoundRect: Equatable {
    public static func ==(lhs: BLRoundRect, rhs: BLRoundRect) -> Bool {
        return lhs.rect == rhs.rect
            && lhs.radius == rhs.radius
    }
}
