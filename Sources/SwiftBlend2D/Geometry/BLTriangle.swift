import blend2d

public extension BLTriangle {
    private static let equilateralHeight = 0.866025404
    private static let equilateralOffset = 0.14433756733333333
    
    /// An upright equilateral triangle where each side is unit-length.
    ///
    /// The centroid of the triangle is at (0, 0).
    ///
    /// The first point is the top-most center point of the triangle.
    static let unitEquilateral = BLTriangle(
        x0: 0,
        y0: -equilateralHeight / 2 - equilateralOffset,
        x1: 0.5,
        y1: equilateralHeight / 2 - equilateralOffset,
        x2: -0.5,
        y2: equilateralHeight / 2 - equilateralOffset
    )
    
    @inlinable
    var p0: BLPoint {
        BLPoint(x: x0, y: y0)
    }
    
    @inlinable
    var p1: BLPoint {
        BLPoint(x: x1, y: y1)
    }
    
    @inlinable
    var p2: BLPoint {
        BLPoint(x: x2, y: y2)
    }
    
    /// Computes the centroid of this triangle
    @inlinable
    var centroid: BLPoint {
        (p0 + p1 + p2) / 3
    }
    
    /// Returns the minimal rectangle capable of containing all three points of
    /// this triangle
    @inlinable
    var boundingBox: BLBox {
        let min = p0.pointwiseMin(p1.pointwiseMin(p2))
        let max = p0.pointwiseMax(p1.pointwiseMax(p2))
        
        return BLBox(x0: min.x, y0: min.y, x1: max.x, y1: max.y)
    }
    
    @inlinable
    init(p0: BLPoint, p1: BLPoint, p2: BLPoint) {
        self.init(
            x0: p0.x, y0: p0.y,
            x1: p1.x, y1: p1.y,
            x2: p2.x, y2: p2.y
        )
    }

    @inlinable
    func contains(x: Double, y: Double) -> Bool {
        func sign(
            _ p1x: Double, _ p1y: Double, _ p2x: Double,
            _ p2y: Double, _ p3x: Double, _ p3y: Double
        ) -> Double {

            (p1x - p3x) * (p2y - p3y) - (p2x - p3x) * (p1y - p3y)
        }

        let d1 = sign(x, y, x0, y0, x1, y1)
        let d2 = sign(x, y, x1, y1, x2, y2)
        let d3 = sign(x, y, x2, y2, x0, y0)

        let has_neg = (d1 < 0) || (d2 < 0) || (d3 < 0)
        let has_pos = (d1 > 0) || (d2 > 0) || (d3 > 0)

        return !(has_neg && has_pos)
    }

    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        contains(x: point.x, y: point.y)
    }
    
    /// Returns a new triangle represented by the coordinates of this triangle,
    /// scaled by a given factor around the centroid.
    ///
    /// The centroid of the resulting triangle matches the centroid of the original
    /// triangle.
    @inlinable
    func scaledBy(x: Double, y: Double) -> BLTriangle {
        scaledBy(BLPoint(x: x, y: y))
    }
    
    /// Returns a new triangle represented by the coordinates of this triangle,
    /// scaled by a given factor around the centroid.
    ///
    /// The centroid of the resulting triangle matches the centroid of the original
    /// triangle.
    @inlinable
    func scaledBy(_ scale: BLPoint) -> BLTriangle {
        let center = centroid
        
        return BLTriangle(
            p0: center + (p0 - center) * scale,
            p1: center + (p1 - center) * scale,
            p2: center + (p2 - center) * scale
        )
    }
    
    /// Returns a new copy of this triangle with the vertices offset by a given
    /// pair of coordinates.
    @inlinable
    func offsetBy(x: Double, y: Double) -> BLTriangle {
        BLTriangle(
            x0: x0 + x,
            y0: y0 + y,
            x1: x1 + x,
            y1: y1 + y,
            x2: x2 + x,
            y2: y2 + y
        )
    }
    
    /// Returns a new copy of this triangle with the vertices offset by a given
    /// point.
    @inlinable
    func offsetBy(_ vector: BLPoint) -> BLTriangle {
        offsetBy(x: vector.x, y: vector.y)
    }
    
    /// Returns a new copy of this triangle with the vertices rotated along the
    /// centroid by a given radian amount
    @inlinable
    func rotated(by angleInRadians: Double) -> BLTriangle {
        rotated(around: centroid, by: angleInRadians)
    }
    
    /// Returns a new copy of this triangle with the vertices rotated along the
    /// given point by a given radian amount
    @inlinable
    func rotated(around center: BLPoint, by angleInRadians: Double) -> BLTriangle {
        let newP0 = p0.rotated(around: center, by: angleInRadians)
        let newP1 = p1.rotated(around: center, by: angleInRadians)
        let newP2 = p2.rotated(around: center, by: angleInRadians)
        
        return BLTriangle(p0: newP0, p1: newP1, p2: newP2)
    }
    
    /// Returns a new copy of this triangle with the vertices transformed around
    /// by a given matrix
    func transformed(by matrix: BLMatrix2D) -> BLTriangle {
        BLTriangle(
            p0: matrix.mapPoint(p0),
            p1: matrix.mapPoint(p1),
            p2: matrix.mapPoint(p2)
        )
    }
}

// MARK: - Equatable
extension BLTriangle: Equatable {
    @inlinable
    public static func == (lhs: BLTriangle, rhs: BLTriangle) -> Bool {
        lhs.x0 == rhs.x0
            && lhs.y0 == rhs.y0
            && lhs.x1 == rhs.x1
            && lhs.y1 == rhs.y1
            && lhs.x2 == rhs.x2
            && lhs.y2 == rhs.y2
    }
}

// MARK: - Hashable
extension BLTriangle: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x0)
        hasher.combine(y0)
        hasher.combine(x1)
        hasher.combine(y1)
        hasher.combine(x2)
        hasher.combine(y2)
    }
}

// MARK: - CustomStringConvertible
extension BLTriangle: CustomStringConvertible {
    public var description: String {
        "BLTriangle(x0: \(x0), y0: \(y0), x1: \(x1), y1: \(y1), x2: \(x2), y2: \(y2))"
    }
}
