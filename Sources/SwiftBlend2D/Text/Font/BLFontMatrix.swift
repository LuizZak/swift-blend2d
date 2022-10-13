import blend2d

public extension BLFontMatrix {
    func toMatrix2D() -> BLMatrix2D {
        BLMatrix2D(
            m00: m00, m01: m01,
            m10: m10, m11: m11,
            m20: 0.0, m21: 0.0
        )
    }
    
    /// Transforms a given polygon by multiplying each coordinate by this matrix.
    @inlinable
    func mapPolygon(_ polygon: [BLPoint]) -> [BLPoint] {
        polygon.map(mapPoint)
    }
    
    func mapPoint(_ point: BLPoint) -> BLPoint {
        BLPoint(
            x: point.x * m00 + point.y * m10,
            y: point.x * m01 + point.y * m11
        )
    }
    
    /// Maps the corners of a given rectangle into a newer minimal rectangle
    /// capable of containing all four mapped points.
    @inlinable
    func mapRect(_ rect: BLRect) -> BLRect {
        var minimum = mapPoint(rect.topLeft).pointwiseMin(mapPoint(rect.topRight))
        minimum = minimum.pointwiseMin(mapPoint(rect.bottomLeft))
        minimum = minimum.pointwiseMin(mapPoint(rect.bottomRight))

        var maximum = mapPoint(rect.topLeft).pointwiseMax(mapPoint(rect.topRight))
        maximum = maximum.pointwiseMax(mapPoint(rect.bottomLeft))
        maximum = maximum.pointwiseMax(mapPoint(rect.bottomRight))

        return BLBox(x0: minimum.x, y0: minimum.y, x1: maximum.x, y1: maximum.y).asBLRect
    }
    
    /// Maps the corners of a given box into a newer minimal box capable of
    /// containing all four mapped points.
    @inlinable
    func mapBox(_ box: BLBox) -> BLBox {
        var minimum = mapPoint(box.topLeft).pointwiseMin(mapPoint(box.topRight))
        minimum = minimum.pointwiseMin(mapPoint(box.bottomLeft))
        minimum = minimum.pointwiseMin(mapPoint(box.bottomRight))

        var maximum = mapPoint(box.topLeft).pointwiseMax(mapPoint(box.topRight))
        maximum = maximum.pointwiseMax(mapPoint(box.bottomLeft))
        maximum = maximum.pointwiseMax(mapPoint(box.bottomRight))

        return BLBox(x0: minimum.x, y0: minimum.y, x1: maximum.x, y1: maximum.y)
    }
}

extension BLFontMatrix: Equatable {
    public static func == (lhs: BLFontMatrix, rhs: BLFontMatrix) -> Bool {
        lhs.m == rhs.m
    }
}
