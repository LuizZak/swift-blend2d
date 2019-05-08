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
    
    /// Linear parameters.
    public var linear: BLLinearGradientValues {
        return object.impl.pointee.linear
    }
    
    /// Radial parameters.
    public var radial: BLRadialGradientValues {
        return object.impl.pointee.radial
    }
    
    /// Conical parameters.
    public var conical: BLConicalGradientValues {
        return object.impl.pointee.conical
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
    
    // TODO: Handle error results for init and create methods bellow

    public init(type: BLGradientType, values: [Double], extendMode: BLExtendMode, stops: [BLGradientStop], matrix: BLMatrix2D? = nil) {
        super.init { object -> BLResult in
            var values = values
            var stops = stops
            
            return withUnsafeNullablePointer(to: matrix) { pointer in
                blGradientInitAs(object, type.rawValue, &values, extendMode.rawValue, &stops, stops.count, pointer)
            }
        }
    }

    public func create(type: BLGradientType, values: [Double], extendMode: BLExtendMode, stops: [BLGradientStop], matrix: BLMatrix2D? = nil) {
        var values = values
        var stops = stops
        withUnsafeNullablePointer(to: matrix) { pointer in
            blGradientCreate(&object, type.rawValue, &values, extendMode.rawValue, &stops, stops.count, pointer)
        }
    }

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

    public func addStopRgba32(offset: Double, argb32: UInt32) {
        blGradientAddStopRgba32(&object, offset, argb32)
    }

    public func addStopRgba64(offset: Double, argb64: UInt64) {
        blGradientAddStopRgba64(&object, offset, argb64)
    }

    public func removeStop(index: Int) {
        blGradientRemoveStop(&object, index)
    }

    public func removeStopByOffset(offset: Double, all: UInt32) {
        blGradientRemoveStopByOffset(&object, offset, all)
    }

    public func removeStops(inRange range: BLRange? = nil) {
        withUnsafeNullablePointer(to: range) { pointer in
            blGradientRemoveStops(&object, pointer)
        }
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
    func resetMatrix() -> BLResult {
        return blGradientApplyMatrixOp(&object, BLMatrix2DOp.reset.rawValue, nil)
    }
    func translate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.translate, x, y)
    }
    func translate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.translate, p.x, p.y)
    }
    func translate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.translate, p)
    }
    func scale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.scale, xy, xy)
    }
    func scale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.scale, x, y)
    }
    func scale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.scale, p.x, p.y)
    }
    func scale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.scale, p)
    }
    func skew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.skew, x, y)
    }
    func skew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.skew, p)
    }
    func rotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.rotate, angle)
    }
    func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, x, y)
    }
    func rotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, point.x, point.y)
    }
    func rotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    func transform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.transform, matrix)
    }
    func postTranslate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postTranslate, x, y)
    }
    func postTranslate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postTranslate, p.x, p.y)
    }
    func postTranslate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postTranslate, p)
    }
    func postScale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, xy, xy)
    }
    func postScale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, x, y)
    }
    func postScale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postScale, p.x, p.y)
    }
    func postScale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postScale, p)
    }
    func postSkew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postSkew, x, y)
    }
    func postSkew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postSkew, p)
    }
    func postRotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.postRotate, angle)
    }
    func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, x, y)
    }
    func postRotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, point.x, point.y)
    }
    func postRotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
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

extension BLGradientCore: CoreStructure {
    public static let initializer = blGradientInit
    public static let deinitializer = blGradientReset
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
