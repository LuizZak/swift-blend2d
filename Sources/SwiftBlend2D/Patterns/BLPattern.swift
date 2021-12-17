import blend2d

public struct BLPattern {
    @usableFromInline
    var box: BLBaseClass<BLPatternCore>
    
    /// Pattern extend mode.
    public var extendMode: BLExtendMode {
        get {
            return blPatternGetExtendMode(&box.object)
        }
        set {
            ensureUnique()
            blPatternSetExtendMode(&box.object, newValue)
        }
    }
    
    // MARK: Transformations
    
    /// Whether this pattern has a transformation matrix different than
    /// `BLMatrix2D.identity`.
    public var hasMatrix: Bool {
        return matrixType != .identity
    }
    
    /// Type of the transformation matrix.
    public var matrixType: BLMatrix2DType {
        return blPatternGetMatrixType(&box.object)
    }
    
    /// Gradient transformation matrix.
    public var matrix: BLMatrix2D {
        get {
            var matrix = BLMatrix2D()
            blPatternGetMatrix(&box.object, &matrix)
            return matrix
        }
        set {
            ensureUnique()

            _=_applyMatrixOp(.assign, newValue)
        }
    }
    
    public var image: BLImage {
        var image = BLImageCore()
        blPatternGetImage(&box.object, &image)
        return BLImage(weakAssign: image)
    }
    
    public var area: BLRectI {
        var area = BLRectI()
        blPatternGetArea(&box.object, &area)
        return area
    }
    
    public init() {
        box = BLBaseClass()
    }
    
    public init(image: BLImage, area: BLRectI? = nil, extendMode: BLExtendMode = .repeat, matrix: BLMatrix2D? = nil) {
        box = BLBaseClass { pointer in
            return withUnsafeNullablePointer(to: area) { area in
                withUnsafeNullablePointer(to: matrix) { matrix in
                    blPatternInitAs(pointer, &image.object, area, extendMode, matrix)
                }
            }
        }
    }
    
    @inlinable
    init(box: BLBaseClass<BLPatternCore>) {
        self.box = box
    }
    
    @inlinable
    mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }

    @discardableResult
    mutating func setImage(_ image: BLImage) -> BLResult {
        ensureUnique()
        return blPatternSetImage(&box.object, &image.object, nil)
    }

    @discardableResult
    mutating func setImage(_ image: BLImage, area: BLRectI) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: area) { pointer in
            return blPatternSetImage(&box.object, &image.object, pointer)
        }
    }

    @discardableResult
    mutating func resetImage() -> BLResult {
        return blPatternResetImage(&box.object)
    }

    @discardableResult
    mutating func setArea(_ area: BLRectI?) -> BLResult {
        ensureUnique()
        return withUnsafeNullablePointer(to: area) { pointer in
            return blPatternSetArea(&box.object, pointer)
        }
    }

    @discardableResult
    mutating func resetArea() -> BLResult {
        return setArea(nil)
    }
}

public extension BLPattern {
    @inlinable
    @discardableResult
    mutating func resetMatrix() -> BLResult {
        ensureUnique()
        return blPatternApplyMatrixOp(&box.object, .reset, nil)
    }
    @inlinable
    @discardableResult
    mutating func translate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.translate, x, y)
    }
    @inlinable
    @discardableResult
    mutating func translate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.translate, p.x, p.y)
    }
    @inlinable
    @discardableResult
    mutating func translate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.translate, p)
    }
    @inlinable
    @discardableResult
    mutating func scale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.scale, xy, xy)
    }
    @inlinable
    @discardableResult
    mutating func scale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.scale, x, y)
    }
    @inlinable
    @discardableResult
    mutating func scale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.scale, p.x, p.y)
    }
    @inlinable
    @discardableResult
    mutating func scale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.scale, p)
    }
    @inlinable
    @discardableResult
    mutating func skew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.skew, x, y)
    }
    @inlinable
    @discardableResult
    mutating func skew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.skew, p)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.rotate, angle)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, x, y)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, point.x, point.y)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @inlinable
    @discardableResult
    mutating func transform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.transform, matrix)
    }
    @inlinable
    @discardableResult
    mutating func postTranslate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postTranslate, x, y)
    }
    @inlinable
    @discardableResult
    mutating func postTranslate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postTranslate, p.x, p.y)
    }
    @inlinable
    @discardableResult
    mutating func postTranslate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postTranslate, p)
    }
    @inlinable
    @discardableResult
    mutating func postScale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, xy, xy)
    }
    @inlinable
    @discardableResult
    mutating func postScale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, x, y)
    }
    @inlinable
    @discardableResult
    mutating func postScale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postScale, p.x, p.y)
    }
    @inlinable
    @discardableResult
    mutating func postScale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postScale, p)
    }
    @inlinable
    @discardableResult
    mutating func postSkew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postSkew, x, y)
    }
    @inlinable
    @discardableResult
    mutating func postSkew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postSkew, p)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.postRotate, angle)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, x, y)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, point.x, point.y)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    @inlinable
    @discardableResult
    mutating func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.postTransform, matrix)
    }
}

internal extension BLPattern {
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLMatrix2D) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLPoint) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: Double) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOpV(_ opType: BLMatrix2DOp, _ args: Double...) -> BLResult {
        ensureUnique()
        return args.withUnsafeBytes { pointer in
            blPatternApplyMatrixOp(&box.object, opType, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOpV<T: BinaryInteger>(_ opType: BLMatrix2DOp, _ args: T...) -> BLResult {
        ensureUnique()
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blPatternApplyMatrixOp(&box.object, opType, pointer.baseAddress)
        }
    }
}

extension BLPattern: Equatable {
    public static func == (lhs: BLPattern, rhs: BLPattern) -> Bool {
        return blPatternEquals(&lhs.box.object, &rhs.box.object)
    }
}

extension BLPatternCore: CoreStructure {
    public static let initializer = blPatternInit
    public static let deinitializer = blPatternReset
    public static let assignWeak = blPatternAssignWeak
    
    @usableFromInline
    var impl: BLPatternImpl {
        get {
            _d.impl!.load(as: BLPatternImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLPatternImpl.self)
        }
    }
}
