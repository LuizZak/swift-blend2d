import blend2d

public extension BLEllipse {
    init(cx: Double, cy: Double, rx: Double, ry: Double) {
        self.init(.init(.init(cx: cx, cy: cy)), .init(.init(rx: rx, ry: ry)))
    }
    
    init(center: BLPoint, radius: BLPoint) {
        self.init(.init(center: center), .init(radius: radius))
    }
}

extension BLEllipse: Equatable {
    public static func ==(lhs: BLEllipse, rhs: BLEllipse) -> Bool {
        return lhs.center == rhs.center
            && lhs.radius == rhs.radius
    }
}
