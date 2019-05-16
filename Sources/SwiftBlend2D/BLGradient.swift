import blend2d

/// A color gradient pattern.
public struct BLGradient: Equatable {
    @usableFromInline
    var box: Box<BLGradientCore>
    
    // MARK: Gradient Stops
    
    public var stops: [BLGradientStop] {
        let buffer = UnsafeBufferPointer(start: blGradientGetStops(&box.object),
                                         count: size)
        
        return Array(buffer)
    }
    
    public var size: Int {
        return blGradientGetSize(&box.object)
    }
    
    public var capacity: Int {
        return blGradientGetCapacity(&box.object)
    }
    
    // MARK: Gradient Options
    
    /// Gradient type.
    public var type: BLGradientType {
        get {
            return BLGradientType(rawValue: blGradientGetType(&box.object))
        }
        set {
            blGradientSetType(&box.object, newValue.rawValue)
        }
    }
    
    /// Gradient extend mode.
    public var extendMode: BLExtendMode {
        get {
            return BLExtendMode(rawValue: blGradientGetExtendMode(&box.object))
        }
        set {
            blGradientSetExtendMode(&box.object, newValue.rawValue)
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
            return box.object.impl.pointee.linear
        }
        set {
            ensureUnique()
            box.object.impl.pointee.linear = newValue
        }
    }
    
    /// Radial parameters.
    public var radial: BLRadialGradientValues {
        get {
            return box.object.impl.pointee.radial
        }
        set {
            ensureUnique()
            box.object.impl.pointee.radial = newValue
        }
    }
    
    /// Conical parameters.
    public var conical: BLConicalGradientValues {
        get {
            return box.object.impl.pointee.conical
        }
        set {
            ensureUnique()
            box.object.impl.pointee.conical = newValue
        }
    }
    
    /// x0 - start 'x' for Linear/Radial and center 'x' for Conical.
    public var x0: Double {
        get {
            return getValue(atIndex: .commonX0)
        }
        set {
            setValue(.commonX0, newValue)
        }
    }
    
    /// y0 - start 'y' for Linear/Radial and center 'y' for Conical.
    public var y0: Double {
        get {
            return getValue(atIndex: .commonY0)
        }
        set {
            setValue(.commonY0, newValue)
        }
    }
    
    /// x1 - end 'x' for Linear/Radial.
    public var x1: Double {
        get {
            return getValue(atIndex: .commonX1)
        }
        set {
            setValue(.commonX1, newValue)
        }
    }
    
    /// y1 - end 'y' for Linear/Radial.
    public var y1: Double {
        get {
            return getValue(atIndex: .commonY1)
        }
        set {
            setValue(.commonY1, newValue)
        }
    }
    
    /// Radial gradient r0 radius.
    public var r0: Double {
        get {
            return getValue(atIndex: .radialR0)
        }
        set {
            setValue(.radialR0, newValue)
        }
    }
    
    /// Conical gradient angle.
    public var angle: Double {
        get {
            return getValue(atIndex: .conicalAngle)
        }
        set {
            setValue(.conicalAngle, newValue)
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
    
    /// Gets the gradient values for this gradient.
    public var values: [Double] {
        get {
            assert(BL_GRADIENT_VALUE_COUNT.rawValue == 6)
            return [
                box.object.impl.pointee.values.0,
                box.object.impl.pointee.values.1,
                box.object.impl.pointee.values.2,
                box.object.impl.pointee.values.3,
                box.object.impl.pointee.values.4,
                box.object.impl.pointee.values.5,
            ]
        }
    }
    
    @inlinable
    public init() {
        box = Box()
    }
    
    // TODO: Handle error results for init and create methods bellow
    
    @inlinable
    public init(linear: BLLinearGradientValues,
                extendMode: BLExtendMode = .pad,
                stops: [BLGradientStop]? = nil,
                matrix: BLMatrix2D? = nil) {
        
        box = Box { pointer in
            var linear = linear
            withUnsafeNullablePointer(to: matrix) { matrix -> Void in
                blGradientInitAs(pointer,
                                 BLGradientType.linear.rawValue,
                                 &linear,
                                 extendMode.rawValue,
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
        
        box = Box { pointer in
            var radial = radial
            withUnsafeNullablePointer(to: matrix) { matrix -> Void in
                blGradientInitAs(pointer,
                                 BLGradientType.radial.rawValue,
                                 &radial,
                                 extendMode.rawValue,
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
        
        box = Box { pointer in
            var conical = conical
            withUnsafeNullablePointer(to: matrix) { matrix -> Void in
                blGradientInitAs(pointer,
                                 BLGradientType.conical.rawValue,
                                 &conical,
                                 extendMode.rawValue,
                                 stops,
                                 stops?.count ?? 0,
                                 matrix)
            }
        }
    }
    
    @inlinable
    mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }
    
    // TODO: Find a better way to express matrix operations + operation data,
    // probably using an enum to couple the two.
    func applyMatrixOperation(_ opType: BLMatrix2DOp,
                              opData: BLGradientMatrixOperationData) -> BLResult {
        
        return opData.withUnsafePointerToContents { pointer in
            blGradientApplyMatrixOp(&box.object, opType.rawValue, pointer)
        }
    }
    
    public static func == (lhs: BLGradient, rhs: BLGradient) -> Bool {
        return blGradientEquals(&lhs.box.object, &rhs.box.object)
    }
}

public extension BLGradient {
    /// Reset extend mode to `BLExtendMode.pad`.
    mutating func resetExtendMode() {
        extendMode = .pad
    }
    
    func getValue(atIndex index: BLGradientValue) -> Double {
        return blGradientGetValue(&box.object, Int(index.rawValue))
    }
    
    mutating func setValue(_ index: BLGradientValue, _ value: Double) {
        ensureUnique()
        blGradientSetValue(&box.object, Int(index.rawValue), value)
    }
    
    mutating func setValues(from index: BLGradientValue, _ values: [Double]) {
        ensureUnique()
        var values = values
        blGradientSetValues(&box.object, Int(index.rawValue), &values, values.count)
    }
    
    // MARK: Gradient Stops
    
    mutating func resetStops() {
        ensureUnique()
        blGradientResetStops(&box.object)
    }
    
    mutating func assignStops(_ stops: [BLGradientStop]) {
        ensureUnique()
        blGradientAssignStops(&box.object, stops, stops.count)
    }
    
    mutating func addStop(_ offset: Double, rgba32: UInt32) {
        ensureUnique()
        blGradientAddStopRgba32(&box.object, offset, rgba32)
    }
    
    mutating func addStop(_ offset: Double, rgba64: UInt64) {
        ensureUnique()
        blGradientAddStopRgba64(&box.object, offset, rgba64)
    }
    
    mutating func addStop(_ offset: Double, _ rgba: BLRgba32) {
        ensureUnique()
        blGradientAddStopRgba32(&box.object, offset, rgba.value)
    }
    
    mutating func addStop(_ offset: Double, _ rgba: BLRgba64) {
        ensureUnique()
        blGradientAddStopRgba64(&box.object, offset, rgba.value)
    }
    
    mutating func removeStop(index: Int) {
        ensureUnique()
        blGradientRemoveStop(&box.object, index)
    }
    
    mutating func removeStopByOffset(offset: Double, all: UInt32) {
        ensureUnique()
        blGradientRemoveStopByOffset(&box.object, offset, all)
    }
    
    mutating func removeStops(inRange range: BLRange) {
        ensureUnique()
        var range = range
        blGradientRemoveStops(&box.object, &range)
    }
    
    mutating func removeStopsFromTo(offsetMin: Double, offsetMax: Double) {
        ensureUnique()
        blGradientRemoveStopsFromTo(&box.object, offsetMin, offsetMax)
    }
    
    mutating func replaceStopRgba32(index: Int, offset: Double, rgba32: UInt32) {
        ensureUnique()
        blGradientReplaceStopRgba32(&box.object, index, offset, rgba32)
    }
    
    mutating func replaceStopRgba64(index: Int, offset: Double, rgba64: UInt64) {
        ensureUnique()
        blGradientReplaceStopRgba64(&box.object, index, offset, rgba64)
    }
    
    func indexOfStop(withOffset offset: Double) -> Int {
        return blGradientIndexOfStop(&box.object, offset)
    }
}

public extension BLGradient {
    @discardableResult
    mutating func resetMatrix() -> BLResult {
        ensureUnique()
        return blGradientApplyMatrixOp(&box.object, BLMatrix2DOp.reset.rawValue, nil)
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

internal extension BLGradient {
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLMatrix2D) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&box.object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLPoint) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&box.object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: Double) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyMatrixOp(&box.object, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOpV(_ opType: BLMatrix2DOp, _ args: Double...) -> BLResult {
        ensureUnique()
        return args.withUnsafeBytes { pointer in
            blGradientApplyMatrixOp(&box.object, opType.rawValue, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    mutating func _applyMatrixOpV<T: BinaryInteger>(_ opType: BLMatrix2DOp, _ args: T...) -> BLResult {
        ensureUnique()
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blGradientApplyMatrixOp(&box.object, opType.rawValue, pointer.baseAddress)
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

extension BLGradientCore: CoreStructure {
    public static let initializer = blGradientInit
    public static let deinitializer = blGradientReset
    public static var assignWeak = blGradientAssignWeak
}
