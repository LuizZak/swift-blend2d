import blend2d

public extension BLRoundRect {
    @inlinable
    init(rect: BLRect, radius: BLPoint) {
        self.init(x: rect.x, y: rect.y, w: rect.w, h: rect.h, rx: radius.x, ry: radius.y)
    }
}

extension BLRoundRect: Equatable {
    @inlinable
    public static func ==(lhs: BLRoundRect, rhs: BLRoundRect) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
            && lhs.rx == rhs.rx
            && lhs.ry == rhs.ry
    }
}
