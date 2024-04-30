import blend2d

public struct BLPattern {
    @usableFromInline
    var box: BLBaseClass<BLPatternCore>
    
    /// Pattern extend mode.
    public var extendMode: BLExtendMode {
        get {
            blPatternGetExtendMode(&box.object)
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
        transformType != .identity
    }
    
    /// Type of the transformation matrix.
    public var transformType: BLTransformType {
        blPatternGetTransformType(&box.object)
    }
    
    /// Gradient transformation matrix.
    public var matrix: BLMatrix2D {
        get {
            var matrix = BLMatrix2D()
            blPatternGetTransform(&box.object, &matrix)
            return matrix
        }
        set {
            ensureUnique()

            _=_applyTransformOp(.assign, newValue)
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
    
    public init(
        image: BLImage,
        area: BLRectI? = nil,
        extendMode: BLExtendMode = .repeat,
        matrix: BLMatrix2D? = nil
    ) {
        box = BLBaseClass { pointer in
            withUnsafeNullablePointer(to: area) { area in
                withUnsafeNullablePointer(to: matrix) { matrix in
                    blPatternInitAs(
                        pointer,
                        &image.object,
                        area,
                        extendMode,
                        matrix
                    )
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
            blPatternSetImage(&box.object, &image.object, pointer)
        }
    }

    @discardableResult
    mutating func resetImage() -> BLResult {
        blPatternResetImage(&box.object)
    }

    @discardableResult
    mutating func setArea(_ area: BLRectI?) -> BLResult {
        ensureUnique()
        return withUnsafeNullablePointer(to: area) { pointer in
            blPatternSetArea(&box.object, pointer)
        }
    }

    @discardableResult
    mutating func resetArea() -> BLResult {
        setArea(nil)
    }
}

public extension BLPattern {
    @inlinable
    @discardableResult
    mutating func resetMatrix() -> BLResult {
        ensureUnique()
        return blPatternApplyTransformOp(&box.object, .reset, nil)
    }
    @inlinable
    @discardableResult
    mutating func translate(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.translate, x, y)
    }
    @inlinable
    @discardableResult
    mutating func translate(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.translate, p.x, p.y)
    }
    @inlinable
    @discardableResult
    mutating func translate(by p: BLPoint) -> BLResult {
        _applyTransformOp(.translate, p)
    }
    @inlinable
    @discardableResult
    mutating func scale(xy: Double) -> BLResult {
        _applyTransformOpV(.scale, xy, xy)
    }
    @inlinable
    @discardableResult
    mutating func scale(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.scale, x, y)
    }
    @inlinable
    @discardableResult
    mutating func scale(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.scale, p.x, p.y)
    }
    @inlinable
    @discardableResult
    mutating func scale(by p: BLPoint) -> BLResult {
        _applyTransformOp(.scale, p)
    }
    @inlinable
    @discardableResult
    mutating func skew(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.skew, x, y)
    }
    @inlinable
    @discardableResult
    mutating func skew(by p: BLPoint) -> BLResult {
        _applyTransformOp(.skew, p)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double) -> BLResult {
        _applyTransformOp(.rotate, angle)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, x, y)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, point: BLPoint) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, point.x, point.y)
    }
    @inlinable
    @discardableResult
    mutating func rotate(angle: Double, point: BLPointI) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @inlinable
    @discardableResult
    mutating func transform(_ matrix: BLMatrix2D) -> BLResult {
        _applyTransformOp(.transform, matrix)
    }
    @inlinable
    @discardableResult
    mutating func postTranslate(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postTranslate, x, y)
    }
    @inlinable
    @discardableResult
    mutating func postTranslate(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.postTranslate, p.x, p.y)
    }
    @inlinable
    @discardableResult
    mutating func postTranslate(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postTranslate, p)
    }
    @inlinable
    @discardableResult
    mutating func postScale(xy: Double) -> BLResult {
        _applyTransformOpV(.postScale, xy, xy)
    }
    @inlinable
    @discardableResult
    mutating func postScale(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postScale, x, y)
    }
    @inlinable
    @discardableResult
    mutating func postScale(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.postScale, p.x, p.y)
    }
    @inlinable
    @discardableResult
    mutating func postScale(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postScale, p)
    }
    @inlinable
    @discardableResult
    mutating func postSkew(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postSkew, x, y)
    }
    @inlinable
    @discardableResult
    mutating func postSkew(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postSkew, p)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double) -> BLResult {
        _applyTransformOp(.postRotate, angle)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, x, y)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, point: BLPoint) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, point.x, point.y)
    }
    @inlinable
    @discardableResult
    mutating func postRotate(angle: Double, point: BLPointI) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    @inlinable
    @discardableResult
    mutating func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        _applyTransformOp(.postTransform, matrix)
    }
}

internal extension BLPattern {
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOp(_ opType: BLTransformOp, _ opData: BLMatrix2D) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyTransformOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOp(_ opType: BLTransformOp, _ opData: BLPoint) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyTransformOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOp(_ opType: BLTransformOp, _ opData: Double) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blPatternApplyTransformOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOpV(_ opType: BLTransformOp, _ args: Double...) -> BLResult {
        ensureUnique()
        return args.withUnsafeBytes { pointer in
            blPatternApplyTransformOp(&box.object, opType, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOpV<T: BinaryInteger>(_ opType: BLTransformOp, _ args: T...) -> BLResult {
        ensureUnique()
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blPatternApplyTransformOp(&box.object, opType, pointer.baseAddress)
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
        get { UnsafeMutablePointer(_d.impl)!.pointee }
        set { UnsafeMutablePointer(_d.impl)!.pointee = newValue }
    }
}
