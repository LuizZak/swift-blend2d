import blend2d

public class BLPattern: BLBaseClass<BLPatternCore> {
    /// Pattern extend mode.
    public var extendMode: BLExtendMode {
        get {
            return BLExtendMode(rawValue: UInt32(object.impl.pointee.extendMode))
        }
        set {
            blPatternSetExtendMode(&object, newValue.rawValue)
        }
    }
    
    // MARK: Transformations
    public var hasMatrix: Bool {
        return matrixType != .identity
    }
    
    /// Type of the transformation matrix.
    public var matrixType: BLMatrix2DType {
        return BLMatrix2DType(UInt32(object.impl.pointee.matrixType))
    }
    
    /// Gradient transformation matrix.
    public var matrix: BLMatrix2D {
        get {
            return object.impl.pointee.matrix
        }
        set {
            object.impl.pointee.matrix = newValue
        }
    }
    
    public var image: BLImage {
        return BLImage(weakAssign: object.impl.pointee.image)
    }
    
    public var area: BLRectI {
        return object.impl.pointee.area
    }
    
    public override init() {
        super.init()
    }
    
    public init(image: BLImage, area: BLRectI? = nil, extendMode: BLExtendMode = .repeat, matrix: BLMatrix2D? = nil) {
        super.init { pointer -> BLResult in
            withUnsafeNullablePointer(to: area) { area in
                withUnsafeNullablePointer(to: matrix) { matrix in
                    blPatternInitAs(pointer, &image.object, area, extendMode.rawValue, matrix)
                }
            }
        }
    }
    
    func setImage(_ image: BLImage) -> BLResult {
        return blPatternSetImage(&object, &image.object, nil)
    }
    
    func setImage(_ image: BLImage, area: BLRectI) -> BLResult {
        return withUnsafePointer(to: area) { pointer in
            return blPatternSetImage(&object, &image.object, pointer)
        }
    }
    
    func resetImage() -> BLResult {
        return setImage(BLImage.none)
    }
    
    func setArea(_ area: BLRectI?) -> BLResult {
        return withUnsafeNullablePointer(to: area) { pointer in
            return blPatternSetArea(&object, pointer)
        }
    }
    
    func resetArea() -> BLResult {
        return setArea(nil)
    }
}

public extension BLPattern {
    @discardableResult
    func resetMatrix() -> BLResult {
        return blPatternApplyMatrixOp(&object, BLMatrix2DOp.reset.rawValue, nil)
    }
    @discardableResult
    func translate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.translate, x, y)
    }
    @discardableResult
    func translate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.translate, p.x, p.y)
    }
    @discardableResult
    func translate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.translate, p)
    }
    @discardableResult
    func scale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.scale, xy, xy)
    }
    @discardableResult
    func scale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.scale, x, y)
    }
    @discardableResult
    func scale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.scale, p.x, p.y)
    }
    @discardableResult
    func scale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.scale, p)
    }
    @discardableResult
    func skew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.skew, x, y)
    }
    @discardableResult
    func skew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.skew, p)
    }
    @discardableResult
    func rotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.rotate, angle)
    }
    @discardableResult
    func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, x, y)
    }
    @discardableResult
    func rotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, point.x, point.y)
    }
    @discardableResult
    func rotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    func transform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.transform, matrix)
    }
    @discardableResult
    func postTranslate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postTranslate, x, y)
    }
    @discardableResult
    func postTranslate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postTranslate, p.x, p.y)
    }
    @discardableResult
    func postTranslate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postTranslate, p)
    }
    @discardableResult
    func postScale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, xy, xy)
    }
    @discardableResult
    func postScale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, x, y)
    }
    @discardableResult
    func postScale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postScale, p.x, p.y)
    }
    @discardableResult
    func postScale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postScale, p)
    }
    @discardableResult
    func postSkew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postSkew, x, y)
    }
    @discardableResult
    func postSkew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postSkew, p)
    }
    @discardableResult
    func postRotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.postRotate, angle)
    }
    @discardableResult
    func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, x, y)
    }
    @discardableResult
    func postRotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, point.x, point.y)
    }
    @discardableResult
    func postRotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.postTransform, matrix)
    }
}

internal extension BLPattern {
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLMatrix2D) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLPoint) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: Double) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyMatrixOp(&object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOpV(_ opType: BLMatrix2DOp, _ args: Double...) -> BLResult {
        return args.withUnsafeBytes { pointer in
            blPatternApplyMatrixOp(&object, opType.rawValue, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOpV<T: BinaryInteger>(_ opType: BLMatrix2DOp, _ args: T...) -> BLResult {
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blPatternApplyMatrixOp(&object, opType.rawValue, pointer.baseAddress)
        }
    }
}

extension BLPattern: Equatable {
    public static func ==(lhs: BLPattern, rhs: BLPattern) -> Bool {
        return blPatternEquals(&lhs.object, &rhs.object)
    }
}

extension BLPatternCore: CoreStructure {
    public static var initializer = blPatternInit
    public static var deinitializer = blPatternReset
    public static var assignWeak = blPatternAssignWeak
}
