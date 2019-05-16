import blend2d

public struct BLPattern {
    @usableFromInline
    var box: Box<BLPatternCore>
    
    /// Pattern extend mode.
    public var extendMode: BLExtendMode {
        get {
            return BLExtendMode(rawValue: UInt32(box.object.impl.pointee.extendMode))
        }
        set {
            ensureUnique()
            blPatternSetExtendMode(&box.object, newValue.rawValue)
        }
    }
    
    // MARK: Transformations
    public var hasMatrix: Bool {
        return matrixType != .identity
    }
    
    /// Type of the transformation matrix.
    public var matrixType: BLMatrix2DType {
        return BLMatrix2DType(UInt32(box.object.impl.pointee.matrixType))
    }
    
    /// Gradient transformation matrix.
    public var matrix: BLMatrix2D {
        get {
            return box.object.impl.pointee.matrix
        }
        set {
            ensureUnique()
            box.object.impl.pointee.matrix = newValue
        }
    }
    
    public var image: BLImage {
        return BLImage(weakAssign: box.object.impl.pointee.image)
    }
    
    public var area: BLRectI {
        return box.object.impl.pointee.area
    }
    
    public init() {
        box = Box()
    }
    
    public init(image: BLImage, area: BLRectI? = nil, extendMode: BLExtendMode = .repeat, matrix: BLMatrix2D? = nil) {
        box = Box { pointer in
            withUnsafeNullablePointer(to: area) { area in
                withUnsafeNullablePointer(to: matrix) { matrix in
                    blPatternInitAs(pointer, &image.object, area, extendMode.rawValue, matrix)
                }
            }
        }
    }
    
    @inlinable
    mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }
    
    mutating func setImage(_ image: BLImage) -> BLResult {
        ensureUnique()
        return blPatternSetImage(&box.object, &image.object, nil)
    }
    
    mutating func setImage(_ image: BLImage, area: BLRectI) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: area) { pointer in
            return blPatternSetImage(&box.object, &image.object, pointer)
        }
    }
    
    mutating func resetImage() -> BLResult {
        return setImage(BLImage.none)
    }
    
    mutating func setArea(_ area: BLRectI?) -> BLResult {
        ensureUnique()
        return withUnsafeNullablePointer(to: area) { pointer in
            return blPatternSetArea(&box.object, pointer)
        }
    }
    
    mutating func resetArea() -> BLResult {
        return setArea(nil)
    }
}

public extension BLPattern {
    @discardableResult
    mutating func resetMatrix() -> BLResult {
        ensureUnique()
        return blPatternApplyMatrixOp(&box.object, BLMatrix2DOp.reset.rawValue, nil)
    }
    @discardableResult
    mutating func translate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.translate, x, y)
    }
    @discardableResult
    mutating func translate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.translate, p.x, p.y)
    }
    @discardableResult
    mutating func translate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.translate, p)
    }
    @discardableResult
    mutating func scale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.scale, xy, xy)
    }
    @discardableResult
    mutating func scale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.scale, x, y)
    }
    @discardableResult
    mutating func scale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.scale, p.x, p.y)
    }
    @discardableResult
    mutating func scale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.scale, p)
    }
    @discardableResult
    mutating func skew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.skew, x, y)
    }
    @discardableResult
    mutating func skew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.skew, p)
    }
    @discardableResult
    mutating func rotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.rotate, angle)
    }
    @discardableResult
    mutating func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, x, y)
    }
    @discardableResult
    mutating func rotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, point.x, point.y)
    }
    @discardableResult
    mutating func rotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    mutating func transform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.transform, matrix)
    }
    @discardableResult
    mutating func postTranslate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postTranslate, x, y)
    }
    @discardableResult
    mutating func postTranslate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postTranslate, p.x, p.y)
    }
    @discardableResult
    mutating func postTranslate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postTranslate, p)
    }
    @discardableResult
    mutating func postScale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, xy, xy)
    }
    @discardableResult
    mutating func postScale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, x, y)
    }
    @discardableResult
    mutating func postScale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postScale, p.x, p.y)
    }
    @discardableResult
    mutating func postScale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postScale, p)
    }
    @discardableResult
    mutating func postSkew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postSkew, x, y)
    }
    @discardableResult
    mutating func postSkew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postSkew, p)
    }
    @discardableResult
    mutating func postRotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.postRotate, angle)
    }
    @discardableResult
    mutating func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, x, y)
    }
    @discardableResult
    mutating func postRotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, point.x, point.y)
    }
    @discardableResult
    mutating func postRotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    mutating func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.postTransform, matrix)
    }
}

internal extension BLPattern {
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLMatrix2D) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&box.object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLPoint) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&box.object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: Double) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&box.object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOpV(_ opType: BLMatrix2DOp, _ args: Double...) -> BLResult {
        ensureUnique()
        return args.withUnsafeBytes { pointer in
            blPatternApplyMatrixOp(&box.object, opType.rawValue, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOpV<T: BinaryInteger>(_ opType: BLMatrix2DOp, _ args: T...) -> BLResult {
        ensureUnique()
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blPatternApplyMatrixOp(&box.object, opType.rawValue, pointer.baseAddress)
        }
    }
}

extension BLPattern: Equatable {
    public static func ==(lhs: BLPattern, rhs: BLPattern) -> Bool {
        return blPatternEquals(&lhs.box.object, &rhs.box.object)
    }
}

extension BLPatternCore: CoreStructure {
    public static var initializer = blPatternInit
    public static var deinitializer = blPatternReset
    public static var assignWeak = blPatternAssignWeak
}
