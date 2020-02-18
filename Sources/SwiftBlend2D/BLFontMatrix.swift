import blend2d

public extension BLFontMatrix {
    func toMatrix2D() -> BLMatrix2D {
        return BLMatrix2D(m00: m00, m01: m01,
                          m10: m10, m11: m11,
                          m20: 0.0, m21: 0.0)
    }
    
    /// Transforms a given polygon by multiplying each coordinate by this matrix.
    @inlinable
    func mapPolygon(_ polygon: [BLPoint]) -> [BLPoint] {
        return polygon.map(mapPoint)
    }
    
    func mapPoint(_ point: BLPoint) -> BLPoint {
        return BLPoint(x: point.x * m00 + point.y * m10,
                       y: point.x * m01 + point.y * m11)
    }
    
    /// Maps the corners of a given rectangle into a newer minimal rectangle
    /// capable of containing all four mapped points.
    @inlinable
    func mapRect(_ rect: BLRect) -> BLRect {
        let points = [
            rect.topLeft,
            rect.topRight,
            rect.bottomLeft,
            rect.bottomRight
        ]

        let transformed = mapPolygon(points)

        return BLBox(boundsForPoints: transformed).asBLRect
    }
    
    /// Maps the corners of a given box into a newer minimal box capable of
    /// containing all four mapped points.
    @inlinable
    func mapBox(_ box: BLBox) -> BLBox {
        let points = [
            box.topLeft,
            box.topRight,
            box.bottomLeft,
            box.bottomRight
        ]

        let transformed = mapPolygon(points)

        return BLBox(boundsForPoints: transformed)
    }
}
