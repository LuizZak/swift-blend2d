import blend2d

public extension BLEllipse {
    @inlinable
    init(center: BLPoint, radius: BLPoint) {
        self.init(cx: center.x, cy: center.y, rx: radius.x, ry: radius.y)
    }

    @inlinable
    func insetBy(x: Double, y: Double) -> BLEllipse {
        return BLEllipse(cx: self.cx + x / 2, cy: self.cy + y / 2, rx: rx - x, ry: ry - y)
    }

    @inlinable
    func contains(x: Double, y: Double) -> Bool {
        let p = pow(x - cx, 2) / (rx * rx) + pow(y - cy, 2) / (ry * ry)

        return p < 1
    }

    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        return contains(x: point.x, y: point.y)
    }
}

extension BLEllipse: Equatable {
    @inlinable
    public static func ==(lhs: BLEllipse, rhs: BLEllipse) -> Bool {
        return lhs.cx == rhs.cx
            && lhs.cy == rhs.cy
            && lhs.rx == rhs.rx
            && lhs.ry == rhs.ry
    }
}

extension BLEllipse: CustomStringConvertible {
    public var description: String {
        return "BLEllipse(cx: \(cx), cy: \(cy), rx: \(rx), rx: \(ry))"
    }
}
