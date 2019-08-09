import blend2d

public extension BLMatrix2D {
    @inlinable
    init(m00: Double, m01: Double, m10: Double, m11: Double, m20: Double, m21: Double) {
        self.init(.init(.init(m00: m00, m01: m01, m10: m10, m11: m11, m20: m20, m21: m21)))
    }
}

extension BLMatrix2D: Equatable {
    @inlinable
    public static func ==(lhs: BLMatrix2D, rhs: BLMatrix2D) -> Bool {
        return lhs.m == rhs.m
    }
}

public extension BLMatrix2D {
    /// Gets matrix type
    var type: BLMatrix2DType {
        var matrix = self
        return BLMatrix2DType(blMatrix2DGetType(&matrix))
    }
    
    /// Creates a new matrix initialized to identity.
    @inlinable
    static func makeIdentity() -> BLMatrix2D {
        return BLMatrix2D(m00: 1.0, m01: 0.0, m10: 0.0, m11: 1.0, m20: 0.0, m21: 0.0)
    }
    
    /// Creates a new matrix initialized to translation.
    @inlinable
    static func makeTranslation(x: Double, y: Double) -> BLMatrix2D {
        return BLMatrix2D(m00: 1.0, m01: 0.0, m10: 0.0, m11: 1.0, m20: x, m21: y)
    }
    /// Creates a new matrix initialized to translation.
    @inlinable
    static func makeTranslation(_ p: BLPointI) -> BLMatrix2D {
        return BLMatrix2D(m00: 1.0, m01: 0.0, m10: 0.0, m11: 1.0, m20: Double(p.x), m21: Double(p.y))
    }
    /// Creates a new matrix initialized to translation.
    @inlinable
    static func makeTranslation(_ p: BLPoint) -> BLMatrix2D {
        return BLMatrix2D(m00: 1.0, m01: 0.0, m10: 0.0, m11: 1.0, m20: p.x, m21: p.y)
    }
    
    /// Creates a new matrix initialized to scaling.
    @inlinable
    static func makeScaling(xy: Double) -> BLMatrix2D {
        return BLMatrix2D(m00: xy, m01: 0.0, m10: 0.0, m11: xy, m20: 0.0, m21: 0.0)
    }
    /// Creates a new matrix initialized to scaling.
    @inlinable
    static func makeScaling(x: Double, y: Double) -> BLMatrix2D {
        return BLMatrix2D(m00: x, m01: 0.0, m10: 0.0, m11: y, m20: 0.0, m21: 0.0)
    }
    /// Creates a new matrix initialized to scaling.
    @inlinable
    static func makeScaling(_ p: BLPointI) -> BLMatrix2D {
        return BLMatrix2D(m00: Double(p.x), m01: 0.0, m10: 0.0, m11: Double(p.y), m20: 0.0, m21: 0.0)
    }
    /// Creates a new matrix initialized to scaling.
    @inlinable
    static func makeScaling(_ p: BLPoint) -> BLMatrix2D {
        return BLMatrix2D(m00: p.x, m01: 0.0, m10: 0.0, m11: p.y, m20: 0.0, m21: 0.0)
    }
    
    /// Creates a new matrix initialized to rotation.
    @inlinable
    static func makeRotation(angle: Double) -> BLMatrix2D {
        var result = BLMatrix2D()
        result.resetToRotation(angle: angle, x: 0.0, y: 0.0)
        return result
    }
    
    /// Creates a new matrix initialized to rotation.
    @inlinable
    static func makeRotation(angle: Double, x: Double, y: Double) -> BLMatrix2D {
        var result = BLMatrix2D()
        result.resetToRotation(angle: angle, x: x, y: y)
        return result
    }
    
    /// Creates a new matrix initialized to rotation.
    @inlinable
    static func makeRotation(angle: Double, point: BLPoint) -> BLMatrix2D {
        var result = BLMatrix2D()
        result.resetToRotation(angle: angle, x: point.x, y: point.y)
        return result
    }
    
    /// Create a new skewing matrix.
    @inlinable
    static func makeSkewing(x: Double, y: Double) -> BLMatrix2D {
        var result = BLMatrix2D()
        result.resetToSkewing(x: x, y: y)
        return result
    }
    /// Create a new skewing matrix.
    @inlinable
    static func makeSkewing(_ p: BLPoint) -> BLMatrix2D {
        var result = BLMatrix2D()
        result.resetToSkewing(x: p.x, y: p.y)
        return result
    }
    
    @inlinable
    static func makeSinCos(sin: Double, cos: Double, tx: Double = 0.0, ty: Double = 0.0) -> BLMatrix2D {
        return BLMatrix2D(m00: cos, m01: sin, m10: -sin, m11: cos, m20: tx, m21: ty)
    }
    
    @inlinable
    static func makeSinCos(sin: Double, cos: Double, translation: BLPoint) -> BLMatrix2D {
        return makeSinCos(sin: sin, cos: cos, tx: translation.x, ty: translation.y)
    }
}

public extension BLMatrix2D {
    
    /// Resets matrix to identity.
    @inlinable
    mutating func reset() {
        reset(m00: 1.0, m01: 0.0,
              m10: 0.0, m11: 1.0,
              m20: 0.0, m21: 0.0)
    }
    
    /// Resets matrix to `other` (copy its content to this matrix).
    @inlinable
    mutating func reset(to other: BLMatrix2D) {
        reset(m00: other.m00, m01: other.m01,
              m10: other.m10, m11: other.m11,
              m20: other.m20, m21: other.m21)
    }
    
    /// Resets matrix to [`m00`, `m01`, `m10`, `m11`, `m20`, `m21`].
    @inlinable
    mutating func reset(m00: Double, m01: Double, m10: Double, m11: Double, m20: Double, m21: Double) {
        self.m00 = m00
        self.m01 = m01
        self.m10 = m10
        self.m11 = m11
        self.m20 = m20
        self.m21 = m21
    }
    
    /// Resets matrix to translation.
    @inlinable
    mutating func resetToTranslation(x: Double, y: Double) {
        reset(m00: 1.0, m01: 0.0, m10: 0.0, m11: 1.0, m20: x, m21: y)
    }
    /// Resets matrix to translation.
    @inlinable
    mutating func resetToTranslation(_ p: BLPointI) {
        resetToTranslation(BLPoint(p))
    }
    /// Resets matrix to translation.
    @inlinable
    mutating func resetToTranslation(_ p: BLPoint) {
        resetToTranslation(x: p.x, y: p.y)
    }
    
    /// Resets matrix to scaling.
    @inlinable
    mutating func resetToScaling(xy: Double) {
        resetToScaling(x: xy, y: xy)
    }
    /// Resets matrix to scaling.
    @inlinable
    mutating func resetToScaling(x: Double, y: Double) {
        reset(m00: x, m01: 0.0, m10: 0.0, m11: y, m20: 0.0, m21: 0.0)
    }
    /// Resets matrix to scaling.
    @inlinable
    mutating func resetToScaling(_ p: BLPointI) {
        resetToScaling(BLPoint(p))
    }
    /// Resets matrix to scaling.
    @inlinable
    mutating func resetToScaling(_ p: BLPoint) {
        resetToScaling(x: p.x, y: p.y)
    }
    
    /// Resets matrix to skewing.
    @inlinable
    mutating func resetToSkewing(x: Double, y: Double) {
        blMatrix2DSetSkewing(&self, x, y)
    }
    /// Resets matrix to skewing.
    @inlinable
    mutating func resetToSkewing(_ p: BLPoint) {
        blMatrix2DSetSkewing(&self, p.x, p.y)
    }
    
    /// Resets matrix to rotation specified by `sin` and `cos` and optional
    /// translation `tx` and `ty`.
    @inlinable
    mutating func resetToSinCos(sin: Double, cos: Double, tx: Double = 0.0, ty: Double = 0.0) {
        reset(m00: cos, m01: sin, m10: -sin, m11: cos, m20: tx, m21: ty)
    }
    /// Resets matrix to rotation specified by `sin` and `cos` and optional
    /// translation `translation`.
    @inlinable
    mutating func resetToSinCos(sin: Double, cos: Double, translation: BLPoint) {
        resetToSinCos(sin: sin, cos: cos, tx: translation.x, ty: translation.y)
    }
    
    /// Resets matrix to rotation.
    @inlinable
    mutating func resetToRotation(angle: Double) {
        blMatrix2DSetRotation(&self, angle, 0.0, 0.0)
    }
    /// Resets matrix to rotation around a point `[x, y]`.
    @inlinable
    mutating func resetToRotation(angle: Double, x: Double, y: Double) {
        blMatrix2DSetRotation(&self, angle, x, y)
    }
    /// Resets matrix to rotation around a given `point`.
    @inlinable
    mutating func resetToRotation(angle: Double, point: BLPoint) {
        blMatrix2DSetRotation(&self, angle, point.x, point.y)
    }
    
    /// Gets matrix determinant.
    @inlinable
    func determinant() -> Double {
        return self.m00 * self.m11 - self.m01 * self.m10
    }
    
    @inlinable
    @discardableResult
    mutating func translate(x: Double, y: Double) -> BLResult {
        self.m20 += x * self.m00 + y * self.m10
        self.m21 += x * self.m01 + y * self.m11
        
        return BL_SUCCESS.rawValue
    }
    
    @inlinable
    @discardableResult
    mutating func translate(_ p: BLPointI) -> BLResult {
        return translate(BLPoint(p))
    }
    @inlinable
    @discardableResult
    mutating func translate(_ p: BLPoint) -> BLResult {
        return translate(x: p.x, y: p.y)
    }
    
    @inlinable
    @discardableResult
    mutating func scale(xy: Double) -> BLResult {
        return scale(x: xy, y: xy)
    }
    @inlinable
    @discardableResult
    mutating func scale(x: Double, y: Double) -> BLResult {
        self.m00 *= x
        self.m01 *= x
        self.m10 *= y
        self.m11 *= y
        
        return BL_SUCCESS.rawValue
    }
    
    @inlinable
    @discardableResult
    mutating func scale(_ p: BLPointI) -> BLResult {
        return scale(BLPoint(p))
    }
    @inlinable
    @discardableResult
    mutating func scale(_ p: BLPoint) -> BLResult {
        return scale(x: p.x, y: p.y)
    }
    
    @inlinable
    @discardableResult
    mutating func skew(x: Double, y: Double) -> BLResult {
        return skew(BLPoint(x: x, y: y))
    }
    @inlinable
    @discardableResult
    mutating func skew(_ p: BLPoint) -> BLResult {
        var p = p
        return blMatrix2DApplyOp(&self, BLMatrix2DOp.skew.rawValue, &p)
    }
    
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double) -> BLResult {
        var angle = angle
        return blMatrix2DApplyOp(&self, BLMatrix2DOp.rotate.rawValue, &angle)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        let opData = [
            angle, x, y
        ]
        return blMatrix2DApplyOp(&self, BLMatrix2DOp.rotatePt.rawValue, opData)
    }
    
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, point: BLPointI) -> BLResult {
        return rotate(angle: angle, x: Double(point.x), y: Double(point.y))
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, point: BLPoint) -> BLResult {
        return rotate(angle: angle, x: point.x, y: point.y)
    }
    
    @inlinable
    @discardableResult
    mutating func transform(_ m: BLMatrix2D) -> BLResult {
        var m = m
        return blMatrix2DApplyOp(&self, BLMatrix2DOp.transform.rawValue, &m)
    }
    
    @inlinable
    @discardableResult
    mutating func postTranslate(x: Double, y: Double) -> BLResult {
        self.m20 += x
        self.m21 += y
        
        return BL_SUCCESS.rawValue
    }
    
    @inlinable
    @discardableResult
    mutating func postTranslate(_ p: BLPointI) -> BLResult {
        return postTranslate(BLPoint(p))
    }
    @inlinable
    @discardableResult
    mutating func postTranslate(_ p: BLPoint) -> BLResult {
        return postTranslate(x: p.x, y: p.y)
    }
    
    @inlinable
    @discardableResult
    mutating func postScale(xy: Double) -> BLResult {
        return postScale(x: xy, y: xy)
    }
    @inlinable
    @discardableResult
    mutating func postScale(x: Double, y: Double) -> BLResult {
        self.m00 *= x
        self.m01 *= y
        self.m10 *= x
        self.m11 *= y
        self.m20 *= x
        self.m21 *= y
        
        return BL_SUCCESS.rawValue
    }
    @inlinable
    @discardableResult
    mutating func postScale(_ p: BLPointI) -> BLResult {
        return postScale(BLPoint(p))
    }
    @inlinable
    @discardableResult
    mutating func postScale(_ p: BLPoint) -> BLResult {
        return postScale(x: p.x, y: p.y)
    }
    
    @inlinable
    @discardableResult
    mutating func postSkew(x: Double, y: Double) -> BLResult {
        return postSkew(BLPoint(x: x, y: y))
    }
    @inlinable
    @discardableResult
    mutating func postSkew(_ p: BLPoint) -> BLResult {
        var p = p
        return blMatrix2DApplyOp(&self, BLMatrix2DOp.postSkew.rawValue, &p)
    }
    
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double) -> BLResult {
        var angle = angle
        return blMatrix2DApplyOp(&self, BLMatrix2DOp.postRotate.rawValue, &angle)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        let params = [
            angle, x, y
        ]
        return blMatrix2DApplyOp(&self, BLMatrix2DOp.postRotatePt.rawValue, params)
    }
    
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, _ p: BLPointI) -> BLResult {
        return postRotate(angle: angle, BLPoint(p))
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, _ p: BLPoint) -> BLResult {
        return postRotate(angle: angle, x: p.x, y: p.y)
    }
    
    @inlinable
    @discardableResult
    mutating func postTransform(_ m: BLMatrix2D) -> BLResult {
        var m = m
        return blMatrix2DApplyOp(&self, BLMatrix2DOp.postTransform.rawValue, &m)
    }
    
    /// Inverts the matrix, returns `BL_SUCCESS` if the matrix has been inverted
    /// successfully.
    @inlinable
    @discardableResult
    mutating func invert() -> BLResult {
        var sSelf = self
        return blMatrix2DInvert(&self, &sSelf)
    }
    
    /// Map Points and Primitives
    @inlinable
    func mapPoint(x: Double, y: Double) -> BLPoint {
        return BLPoint(x: x * m00 + y * m10 + m20, y: x * m01 + y * m11 + m21)
    }
    @inlinable
    func mapPoint(_ p: BLPoint) -> BLPoint {
        return mapPoint(x: p.x, y: p.y)
    }
    
    @inlinable
    func mapVector(x: Double, y: Double) -> BLPoint {
        return BLPoint(x: x * m00 + y * m10, y: x * m01 + y * m11)
    }
    @inlinable
    func mapVector(_ v: BLPoint) -> BLPoint {
        return mapVector(x: v.x, y: v.y)
    }
    
    /// Inverts `source` matrix and stores the result in `desination`.
    @discardableResult
    static func invert(destination: inout BLMatrix2D, source: BLMatrix2D) -> BLResult {
        var source = source
        return blMatrix2DInvert(&destination, &source)
    }
}

public extension BLMatrix2D {
    var inverted: BLMatrix2D {
        var copy = self
        copy.invert()
        return copy
    }
    
    static func * (lhs: BLMatrix2D, rhs: BLMatrix2D) -> BLMatrix2D {
        var copy = lhs
        copy.postTransform(rhs)
        return copy
    }
    
    static func * (lhs: BLPoint, rhs: BLMatrix2D) -> BLPoint {
        return rhs.mapPoint(lhs)
    }
}
