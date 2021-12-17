import blend2d

/// A color gradient pattern.
public struct BLGradient: Equatable {
    @usableFromInline
    var box: BLBaseClass<BLGradientCore>
    
    // MARK: Gradient Stops
    @inlinable
    public var stops: [BLGradientStop] {
        get {
            let buffer = UnsafeBufferPointer(start: blGradientGetStops(&box.object),
                                             count: size)

            return Array(buffer)
        }
        set {
            if assignStops(newValue) != BLResultCode.success.rawValue {
                fatalError("Invalid stops value; check that offset values are within range [0 - 1] inclusive and that no two stops have the same offset")
            }
        }
    }

    @inlinable
    public var size: Int {
        return blGradientGetSize(&box.object)
    }

    @inlinable
    public var capacity: Int {
        return blGradientGetCapacity(&box.object)
    }
    
    // MARK: Gradient Options
    
    /// Gradient type.
    @inlinable
    public var type: BLGradientType {
        get {
            return blGradientGetType(&box.object)
        }
        set {
            ensureUnique()
            blGradientSetType(&box.object, newValue)
        }
    }
    
    /// Gradient extend mode.
    @inlinable
    public var extendMode: BLExtendMode {
        get {
            return blGradientGetExtendMode(&box.object)
        }
        set {
            ensureUnique()
            blGradientSetExtendMode(&box.object, newValue)
        }
    }
    
    /// Gradient values.
    @inlinable
    public var gradientValues: GradientValues {
        get {
            switch type {
            case .linear:
                return .linear(linear)
            case .radial:
                return .radial(radial)
            case .conical:
                return .conical(conical)
            default:
                return .linear(linear)
            }
        }
        set {
            switch newValue {
            case .linear(let values):
                type = .linear
                linear = values
            case .radial(let values):
                type = .radial
                radial = values
            case .conical(let values):
                type = .conical
                conical = values
            }
        }
    }
    
    /// Linear parameters.
    @inlinable
    public var linear: BLLinearGradientValues {
        get {
            return box.object.impl.linear
        }
        set {
            ensureUnique()
            box.object.impl.linear = newValue
        }
    }
    
    /// Radial parameters.
    @inlinable
    public var radial: BLRadialGradientValues {
        get {
            return box.object.impl.radial
        }
        set {
            ensureUnique()
            box.object.impl.radial = newValue
        }
    }
    
    /// Conical parameters.
    @inlinable
    public var conical: BLConicalGradientValues {
        get {
            return box.object.impl.conical
        }
        set {
            ensureUnique()
            box.object.impl.conical = newValue
        }
    }
    
    /// x0 - start 'x' for Linear/Radial and center 'x' for Conical.
    @inlinable
    public var x0: Double {
        get {
            return getValue(atIndex: .commonX0)
        }
        set {
            setValue(.commonX0, newValue)
        }
    }
    
    /// y0 - start 'y' for Linear/Radial and center 'y' for Conical.
    @inlinable
    public var y0: Double {
        get {
            return getValue(atIndex: .commonY0)
        }
        set {
            setValue(.commonY0, newValue)
        }
    }
    
    /// x1 - end 'x' for Linear/Radial.
    @inlinable
    public var x1: Double {
        get {
            return getValue(atIndex: .commonX1)
        }
        set {
            setValue(.commonX1, newValue)
        }
    }
    
    /// y1 - end 'y' for Linear/Radial.
    @inlinable
    public var y1: Double {
        get {
            return getValue(atIndex: .commonY1)
        }
        set {
            setValue(.commonY1, newValue)
        }
    }
    
    /// Radial gradient r0 radius.
    @inlinable
    public var r0: Double {
        get {
            return getValue(atIndex: .radialR0)
        }
        set {
            setValue(.radialR0, newValue)
        }
    }
    
    /// Conical gradient angle.
    @inlinable
    public var angle: Double {
        get {
            return getValue(atIndex: .conicalAngle)
        }
        set {
            setValue(.conicalAngle, newValue)
        }
    }
    
    // MARK: Transformations
    @inlinable
    public var hasMatrix: Bool {
        return matrixType != .identity
    }
    
    /// Type of the transformation matrix.
    @inlinable
    public var matrixType: BLMatrix2DType {
        return BLMatrix2DType(BLMatrix2DType.RawValue(box.object.impl.matrixType))
    }
    
    /// Gradient transformation matrix.
    @inlinable
    public var matrix: BLMatrix2D {
        get {
            return box.object.impl.matrix
        }
        set {
            ensureUnique()
            
            box.object.impl.matrix = newValue
        }
    }
    
    /// Gets the gradient values for this gradient.
    @inlinable
    public var values: [Double] {
        get {
            assert(BLGradientValue.maxValue.rawValue == 5)
            return [
                box.object.impl.values.0,
                box.object.impl.values.1,
                box.object.impl.values.2,
                box.object.impl.values.3,
                box.object.impl.values.4,
                box.object.impl.values.5,
            ]
        }
    }
    
    @inlinable
    public init() {
        box = BLBaseClass()
    }
    
    // TODO: Handle error results for init and create methods bellow
    
    @inlinable
    public init(linear: BLLinearGradientValues,
                extendMode: BLExtendMode = .pad,
                stops: [BLGradientStop]? = nil,
                matrix: BLMatrix2D? = nil) {
        
        box = BLBaseClass { pointer in
            var linear = linear
            
            return withUnsafeNullablePointer(to: matrix) { matrix in
                blGradientInitAs(pointer,
                                 BLGradientType.linear,
                                 &linear,
                                 extendMode,
                                 stops,
                                 stops?.count ?? 0,
                                 matrix)
            }
        }
    }
    
    @inlinable
    public init(radial: BLRadialGradientValues,
                extendMode: BLExtendMode = .pad,
                stops: [BLGradientStop]? = nil,
                matrix: BLMatrix2D? = nil) {
        
        box = BLBaseClass { pointer in
            var radial = radial
            
            return withUnsafeNullablePointer(to: matrix) { matrix in
                blGradientInitAs(pointer,
                                 BLGradientType.radial,
                                 &radial,
                                 extendMode,
                                 stops,
                                 stops?.count ?? 0,
                                 matrix)
            }
        }
    }
    
    @inlinable
    public init(conical: BLConicalGradientValues,
                extendMode: BLExtendMode = .pad,
                stops: [BLGradientStop]? = nil,
                matrix: BLMatrix2D? = nil) {
        
        box = BLBaseClass { pointer -> BLResult in
            var conical = conical
            
            return withUnsafeNullablePointer(to: matrix) { matrix in
                blGradientInitAs(pointer,
                                 BLGradientType.conical,
                                 &conical,
                                 extendMode,
                                 stops,
                                 stops?.count ?? 0,
                                 matrix)
            }
        }
    }
    
    @inlinable
    init(box: BLBaseClass<BLGradientCore>) {
        self.box = box
    }
    
    @inlinable
    mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }

    @inlinable
    public static func == (lhs: BLGradient, rhs: BLGradient) -> Bool {
        return blGradientEquals(&lhs.box.object, &rhs.box.object)
    }
}

public extension BLGradient {
    /// Reset extend mode to `BLExtendMode.pad`.
    @inlinable
    mutating func resetExtendMode() {
        extendMode = .pad
    }

    @inlinable
    func getValue(atIndex index: BLGradientValue) -> Double {
        return blGradientGetValue(&box.object, Int(index.rawValue))
    }

    @inlinable
    mutating func setValue(_ index: BLGradientValue, _ value: Double) {
        ensureUnique()
        blGradientSetValue(&box.object, Int(index.rawValue), value)
    }

    @inlinable
    mutating func setValues(from index: BLGradientValue, _ values: [Double]) {
        ensureUnique()
        var values = values
        blGradientSetValues(&box.object, Int(index.rawValue), &values, values.count)
    }
    
    // MARK: Gradient Stops

    @inlinable
    mutating func resetStops() {
        ensureUnique()
        blGradientResetStops(&box.object)
    }

    @discardableResult
    @inlinable
    mutating func assignStops(_ stops: [BLGradientStop]) -> BLResult {
        ensureUnique()
        return blGradientAssignStops(&box.object, stops, stops.count)
    }

    @inlinable
    mutating func addStops(_ stops: [(offset: Double, rgba32: BLRgba32)]) {
        for stop in stops {
            addStop(stop.offset, stop.rgba32)
        }
    }

    @inlinable
    mutating func addStops(_ stops: [(offset: Double, rgba64: BLRgba64)]) {
        for stop in stops {
            addStop(stop.offset, stop.rgba64)
        }
    }

    @discardableResult
    @inlinable
    mutating func addStop(_ offset: Double, rgba32: UInt32) -> BLResult {
        ensureUnique()
        return blGradientAddStopRgba32(&box.object, offset, rgba32)
    }

    @discardableResult
    @inlinable
    mutating func addStop(_ offset: Double, rgba64: UInt64) -> BLResult {
        ensureUnique()
        return blGradientAddStopRgba64(&box.object, offset, rgba64)
    }

    @discardableResult
    @inlinable
    mutating func addStop(_ offset: Double, _ rgba: BLRgba32) -> BLResult {
        ensureUnique()
        return blGradientAddStopRgba32(&box.object, offset, rgba.value)
    }

    @discardableResult
    @inlinable
    mutating func addStop(_ offset: Double, _ rgba: BLRgba64) -> BLResult {
        ensureUnique()
        return blGradientAddStopRgba64(&box.object, offset, rgba.value)
    }

    @discardableResult
    @inlinable
    mutating func removeStop(index: Int) -> BLResult {
        ensureUnique()
        return blGradientRemoveStop(&box.object, index)
    }

    @discardableResult
    @inlinable
    mutating func removeStopByOffset(offset: Double, all: UInt32) -> BLResult {
        ensureUnique()
        return blGradientRemoveStopByOffset(&box.object, offset, all)
    }

    @discardableResult
    @inlinable
    mutating func removeStops(inRange range: BLRange) -> BLResult {
        ensureUnique()
        return blGradientRemoveStopsByIndex(&box.object, range.start, range.end)
    }

    @discardableResult
    @inlinable
    mutating func removeStopsFromTo(offsetMin: Double, offsetMax: Double) -> BLResult {
        ensureUnique()
        return blGradientRemoveStopsByOffset(&box.object, offsetMin, offsetMax)
    }

    @discardableResult
    @inlinable
    mutating func replaceStopRgba32(index: Int, offset: Double, rgba32: UInt32) -> BLResult {
        ensureUnique()
        return blGradientReplaceStopRgba32(&box.object, index, offset, rgba32)
    }

    @discardableResult
    @inlinable
    mutating func replaceStopRgba64(index: Int, offset: Double, rgba64: UInt64) -> BLResult {
        ensureUnique()
        return blGradientReplaceStopRgba64(&box.object, index, offset, rgba64)
    }

    @inlinable
    mutating func replaceStopRgba32(atIndex index: Int, rgba32: BLRgba32) -> BLResult {
        if index < 0 || index >= box.object.impl.size {
            fatalError("Index out of bounds: \(index) in bounds [0 - \(box.object.impl.size)]")
        }
        if let stops = blGradientGetStops(&box.object) {
            ensureUnique()
            return replaceStopRgba32(index: index, offset: stops[index].offset, rgba32: rgba32.value)
        }

        return BLResult(BLResultCode.errorNotInitialized.rawValue)
    }

    @inlinable
    func indexOfStop(withOffset offset: Double) -> Int {
        return blGradientIndexOfStop(&box.object, offset)
    }
}

public extension BLGradient {
    @discardableResult
    @inlinable
    mutating func resetMatrix() -> BLResult {
        ensureUnique()
        return blGradientApplyMatrixOp(&box.object, BLMatrix2DOp.reset, nil)
    }
    @discardableResult
    @inlinable
    mutating func translate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.translate, x, y)
    }
    @discardableResult
    @inlinable
    mutating func translate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.translate, p.x, p.y)
    }
    @discardableResult
    @inlinable
    mutating func translate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.translate, p)
    }
    @discardableResult
    @inlinable
    mutating func scale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.scale, xy, xy)
    }
    @discardableResult
    @inlinable
    mutating func scale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.scale, x, y)
    }
    @discardableResult
    @inlinable
    mutating func scale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.scale, p.x, p.y)
    }
    @discardableResult
    @inlinable
    mutating func scale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.scale, p)
    }
    @discardableResult
    @inlinable
    mutating func skew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.skew, x, y)
    }
    @discardableResult
    @inlinable
    mutating func skew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.skew, p)
    }
    @discardableResult
    @inlinable
    mutating func rotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.rotate, angle)
    }
    @discardableResult
    @inlinable
    mutating func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, x, y)
    }
    @discardableResult
    @inlinable
    mutating func rotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, point.x, point.y)
    }
    @discardableResult
    @inlinable
    mutating func rotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    @inlinable
    mutating func transform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.transform, matrix)
    }
    @discardableResult
    @inlinable
    mutating func postTranslate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postTranslate, x, y)
    }
    @discardableResult
    @inlinable
    mutating func postTranslate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postTranslate, p.x, p.y)
    }
    @discardableResult
    @inlinable
    mutating func postTranslate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postTranslate, p)
    }
    @discardableResult
    @inlinable
    mutating func postScale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, xy, xy)
    }
    @discardableResult
    @inlinable
    mutating func postScale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, x, y)
    }
    @discardableResult
    @inlinable
    mutating func postScale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postScale, p.x, p.y)
    }
    @discardableResult
    @inlinable
    mutating func postScale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postScale, p)
    }
    @discardableResult
    @inlinable
    mutating func postSkew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postSkew, x, y)
    }
    @discardableResult
    @inlinable
    mutating func postSkew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postSkew, p)
    }
    @discardableResult
    @inlinable
    mutating func postRotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.postRotate, angle)
    }
    @discardableResult
    @inlinable
    mutating func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, x, y)
    }
    @discardableResult
    @inlinable
    mutating func postRotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, point.x, point.y)
    }
    @discardableResult
    @inlinable
    mutating func postRotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    @inlinable
    mutating func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.postTransform, matrix)
    }
}

internal extension BLGradient {
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLMatrix2D) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLPoint) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: Double) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOpV(_ opType: BLMatrix2DOp, _ args: Double...) -> BLResult {
        ensureUnique()
        return args.withUnsafeBytes { pointer in
            blGradientApplyMatrixOp(&box.object, opType, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyMatrixOpV<T: BinaryInteger>(_ opType: BLMatrix2DOp, _ args: T...) -> BLResult {
        ensureUnique()
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blGradientApplyMatrixOp(&box.object, opType, pointer.baseAddress)
        }
    }
}

public extension BLGradient {
    enum GradientValues {
        case linear(BLLinearGradientValues)
        case radial(BLRadialGradientValues)
        case conical(BLConicalGradientValues)
    }
}

extension BLGradientCore: CoreStructure {
    public static let initializer = blGradientInit
    public static let deinitializer = blGradientReset
    public static let assignWeak = blGradientAssignWeak
    
    @usableFromInline
    var impl: BLGradientImpl {
        get {
            _d.impl!.load(as: BLGradientImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLGradientImpl.self)
        }
    }
}
