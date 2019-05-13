import blend2d

public final class BLGradient: BLBaseClass<BLGradientCore> {
    // MARK: Gradient Stops
    
    public var stops: [BLGradientStop] {
        let buffer = UnsafeBufferPointer(start: blGradientGetStops(&object),
                                         count: size)
        
        return Array(buffer)
    }
    
    public var size: Int {
        return blGradientGetSize(&object)
    }
    
    public var capacity: Int {
        return blGradientGetCapacity(&object)
    }
    
    // MARK: Gradient Options
    
    /// Gradient type.
    public var type: BLGradientType {
        get {
            return BLGradientType(rawValue: blGradientGetType(&object))
        }
        set {
            blGradientSetType(&object, newValue.rawValue)
        }
    }
    
    /// Gradient extend mode.
    public var extendMode: BLExtendMode {
        get {
            return BLExtendMode(rawValue: blGradientGetExtendMode(&object))
        }
        set {
            blGradientSetExtendMode(&object, newValue.rawValue)
        }
    }

    /// Gradient values.
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
    }
    
    /// Linear parameters.
    public var linear: BLLinearGradientValues {
        get {
            return object.impl.pointee.linear
        }
        set {
            object.impl.pointee.linear = newValue
        }
    }
    
    /// Radial parameters.
    public var radial: BLRadialGradientValues {
        get {
            return object.impl.pointee.radial
        }
        set {
            object.impl.pointee.radial = newValue
        }
    }
    
    /// Conical parameters.
    public var conical: BLConicalGradientValues {
        get {
            return object.impl.pointee.conical
        }
        set {
            object.impl.pointee.conical = newValue
        }
    }
    
    /// x0 - start 'x' for Linear/Radial and center 'x' for Conical.
    public var x0: Double {
        get {
            return getValue(atIndex: .commonX0)
        }
        set {
            setValue(atIndex: .commonX0, newValue)
        }
    }
    
    /// y0 - start 'y' for Linear/Radial and center 'y' for Conical.
    public var y0: Double {
        get {
            return getValue(atIndex: .commonY0)
        }
        set {
            setValue(atIndex: .commonY0, newValue)
        }
    }
    
    /// x1 - end 'x' for Linear/Radial.
    public var x1: Double {
        get {
            return getValue(atIndex: .commonX1)
        }
        set {
            setValue(atIndex: .commonX1, newValue)
        }
    }
    
    /// y1 - end 'y' for Linear/Radial.
    public var y1: Double {
        get {
            return getValue(atIndex: .commonY1)
        }
        set {
            setValue(atIndex: .commonY1, newValue)
        }
    }
    
    /// Radial gradient r0 radius.
    public var r0: Double {
        get {
            return getValue(atIndex: .radialR0)
        }
        set {
            setValue(atIndex: .radialR0, newValue)
        }
    }
    
    /// Conical gradient angle.
    public var angle: Double {
        get {
            return getValue(atIndex: .conicalAngle)
        }
        set {
            setValue(atIndex: .conicalAngle, newValue)
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
    
    // MARK: - Initializers
    
    // TODO: Handle error results for init and create methods bellow

    public init(linear: BLLinearGradientValues, extendMode: BLExtendMode = .pad, stops: [BLGradientStop]? = nil, matrix: BLMatrix2D? = nil) {
        super.init { pointer -> BLResult in
            var linear = linear
            return withUnsafeNullablePointer(to: matrix) { matrix in
                return blGradientInitAs(pointer, BLGradientType.linear.rawValue, &linear, extendMode.rawValue, stops, stops?.count ?? 0, matrix)
            }
        }
    }
    
    public init(radial: BLRadialGradientValues, extendMode: BLExtendMode = .pad, stops: [BLGradientStop]? = nil, matrix: BLMatrix2D? = nil) {
        super.init { pointer -> BLResult in
            var radial = radial
            return withUnsafeNullablePointer(to: matrix) { matrix in
                return blGradientInitAs(pointer, BLGradientType.radial.rawValue, &radial, extendMode.rawValue, stops, stops?.count ?? 0, matrix)
            }
        }
    }
    
    public init(conical: BLConicalGradientValues, extendMode: BLExtendMode = .pad, stops: [BLGradientStop]? = nil, matrix: BLMatrix2D? = nil) {
        super.init { pointer -> BLResult in
            var conical = conical
            return withUnsafeNullablePointer(to: matrix) { matrix in
                return blGradientInitAs(pointer, BLGradientType.conical.rawValue, &conical, extendMode.rawValue, stops, stops?.count ?? 0, matrix)
            }
        }
    }
    
    // MARK: - Creation methods

    public func create(type: BLGradientType, values: [Double], extendMode: BLExtendMode, stops: [BLGradientStop], matrix: BLMatrix2D? = nil) {
        var values = values
        var stops = stops
        withUnsafeNullablePointer(to: matrix) { pointer in
            blGradientCreate(&object, type.rawValue, &values, extendMode.rawValue, &stops, stops.count, pointer)
        }
    }
    
    // MARK: - Methods

    public func shrink() {
        blGradientShrink(&object)
    }

    public func reserve(capacity: Int) {
        blGradientReserve(&object, capacity)
    }
    
    /// Reset extend mode to `BLExtendMode.pad`.
    public func resetExtendMode() {
        extendMode = .pad
    }
    
    public func getValue(atIndex index: BLGradientValue) -> Double {
        return blGradientGetValue(&object, Int(index.rawValue))
    }
    
    public func setValue(atIndex index: BLGradientValue, _ value: Double) {
        blGradientSetValue(&object, Int(index.rawValue), value)
    }
    
    public func setValues(atIndex index: BLGradientValue, _ values: [Double]) {
        var values = values
        blGradientSetValues(&object, Int(index.rawValue), &values, values.count)
    }
    
    // MARK: Gradient Stops

    public func resetStops() {
        blGradientResetStops(&object)
    }

    public func assignStops(_ stops: [BLGradientStop]) {
        blGradientAssignStops(&object, stops, stops.count)
    }

    public func addStop(_ offset: Double, rgba32: UInt32) {
        blGradientAddStopRgba32(&object, offset, rgba32)
    }

    public func addStop(_ offset: Double, rgba64: UInt64) {
        blGradientAddStopRgba64(&object, offset, rgba64)
    }
    
    public func addStop(_ offset: Double, _ rgba: BLRgba32) {
        blGradientAddStopRgba32(&object, offset, rgba.value)
    }
    
    public func addStop(_ offset: Double, _ rgba: BLRgba64) {
        blGradientAddStopRgba64(&object, offset, rgba.value)
    }

    public func removeStop(index: Int) {
        blGradientRemoveStop(&object, index)
    }

    public func removeStopByOffset(offset: Double, all: UInt32) {
        blGradientRemoveStopByOffset(&object, offset, all)
    }

    public func removeStops(inRange range: BLRange) {
        var range = range
        blGradientRemoveStops(&object, &range)
    }

    public func removeStopsFromTo(offsetMin: Double, offsetMax: Double) {
        blGradientRemoveStopsFromTo(&object, offsetMin, offsetMax)
    }

    public func replaceStopRgba32(index: Int, offset: Double, rgba32: UInt32) {
        blGradientReplaceStopRgba32(&object, index, offset, rgba32)
    }

    public func replaceStopRgba64(index: Int, offset: Double, rgba64: UInt64) {
        blGradientReplaceStopRgba64(&object, index, offset, rgba64)
    }

    public func indexOfStop(withOffset offset: Double) -> Int {
        return blGradientIndexOfStop(&object, offset)
    }

    // TODO: Find a better way to express matrix operations + operation data,
    // probably using an enum to couple the two.
    func applyMatrixOperation(_ opType: BLMatrix2DOp, opData: BLGradientMatrixOperationData) -> BLResult {
        return opData.withUnsafePointerToContents { pointer in
            blGradientApplyMatrixOp(&object, opType.rawValue, pointer)
        }
    }

    static func == (lhs: BLGradient, rhs: BLGradient) -> Bool {
        return blGradientEquals(&lhs.object, &rhs.object)
    }
}

public extension BLGradient {
    @discardableResult
    func resetMatrix() -> BLResult {
        return blGradientApplyMatrixOp(&object, BLMatrix2DOp.reset.rawValue, nil)
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

internal extension BLGradient {
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLMatrix2D) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLPoint) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: Double) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOpV(_ opType: BLMatrix2DOp, _ args: Double...) -> BLResult {
        return args.withUnsafeBytes { pointer in
            blGradientApplyMatrixOp(&object, opType.rawValue, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOpV<T: BinaryInteger>(_ opType: BLMatrix2DOp, _ args: T...) -> BLResult {
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blGradientApplyMatrixOp(&object, opType.rawValue, pointer.baseAddress)
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
    public static var assignWeak = blGradientAssignWeak
}

// TODO: Will probably remove later- see TODO in BLGradient.applyMatrixOperation
protocol BLGradientMatrixOperationData {
    /// Requests that this `BLGradientMatrixOperationData` instance produce a
    /// pointer that callers can use when invoking `blGradientApplyMatrixOp`
    /// function with the appropriate operation type.
    ///
    /// The closure is invoked with a `nil` pointer, in case the value cannot
    /// produce a pointer to its contents (such as empty arrays)
    func withUnsafePointerToContents<T>(_ closure: (UnsafeRawPointer?) throws -> T) rethrows -> T
}

extension Array: BLGradientMatrixOperationData where Element == Double {
    func withUnsafePointerToContents<T>(_ closure: (UnsafeRawPointer?) throws -> T) rethrows -> T {
        return try withUnsafeBytes { pointer in
            try closure(pointer.baseAddress)
        }
    }
}

extension BLMatrix2D: BLGradientMatrixOperationData {
    func withUnsafePointerToContents<T>(_ closure: (UnsafeRawPointer?) throws -> T) rethrows -> T {
        return try withUnsafePointer(to: self) { pointer in
            try closure(UnsafeRawPointer(pointer))
        }
    }
}
