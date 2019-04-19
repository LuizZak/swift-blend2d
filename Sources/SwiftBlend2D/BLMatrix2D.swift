import blend2d

public extension BLMatrix2D {
    init(m00: Double, m01: Double, m10: Double, m11: Double, m20: Double, m21: Double) {
        self.init(.init(.init(m00: m00, m01: m01, m10: m10, m11: m11, m20: m20, m21: m21)))
    }
}

extension BLMatrix2D: Equatable {
    public static func ==(lhs: BLMatrix2D, rhs: BLMatrix2D) -> Bool {
        return lhs.m == rhs.m
    }
}
