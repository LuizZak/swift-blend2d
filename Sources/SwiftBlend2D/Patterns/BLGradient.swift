import blend2d

/// A color gradient pattern.
public struct BLGradient: Equatable {
    @usableFromInline
    var box: BLBaseClass<BLGradientCore>
    
    // MARK: Gradient Stops
    @inlinable
    public var stops: [BLGradientStop] {
        get {
            let buffer = UnsafeBufferPointer(
                start: blGradientGetStops(&box.object),
                count: size
            )

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
        blGradientGetSize(&box.object)
    }

    @inlinable
    public var capacity: Int {
        blGradientGetCapacity(&box.object)
    }
    
    // MARK: Gradient Options
    
    /// Gradient type.
    @inlinable
    public var type: BLGradientType {
        get {
            blGradientGetType(&box.object)
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
            blGradientGetExtendMode(&box.object)
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
            case .conic:
                return .conic(conical)
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
            case .conic(let values):
                type = .conic
                conical = values
            }
        }
    }
    
    /// Linear parameters.
    @inlinable
    public var linear: BLLinearGradientValues {
        get { box.object.impl.linear }
        set {
            ensureUnique()
            box.object.impl.linear = newValue
        }
    }
    
    /// Radial parameters.
    @inlinable
    public var radial: BLRadialGradientValues {
        get { box.object.impl.radial }
        set {
            ensureUnique()
            box.object.impl.radial = newValue
        }
    }
    
    /// Conical parameters.
    @inlinable
    public var conical: BLConicGradientValues {
        get { box.object.impl.conic }
        set {
            ensureUnique()
            box.object.impl.conic = newValue
        }
    }
    
    /// x0 - start 'x' for Linear/Radial and center 'x' for Conical.
    @inlinable
    public var x0: Double {
        get { getValue(atIndex: .commonX0) }
        set { setValue(.commonX0, newValue) }
    }
    
    /// y0 - start 'y' for Linear/Radial and center 'y' for Conical.
    @inlinable
    public var y0: Double {
        get { getValue(atIndex: .commonY0) }
        set { setValue(.commonY0, newValue) }
    }
    
    /// x1 - end 'x' for Linear/Radial.
    @inlinable
    public var x1: Double {
        get { getValue(atIndex: .commonX1) }
        set { setValue(.commonX1, newValue) }
    }
    
    /// y1 - end 'y' for Linear/Radial.
    @inlinable
    public var y1: Double {
        get { getValue(atIndex: .commonY1) }
        set { setValue(.commonY1, newValue) }
    }
    
    /// Radial gradient r0 radius.
    @inlinable
    public var r0: Double {
        get { getValue(atIndex: .radialR0) }
        set { setValue(.radialR0, newValue) }
    }
    
    /// Conic gradient angle.
    @inlinable
    public var angle: Double {
        get { getValue(atIndex: .conicAngle) }
        set { setValue(.conicAngle, newValue) }
    }
    
    // MARK: Transformations
    
    /// Whether this gradient has a transformation matrix different than
    /// `BLMatrix2D.identity`.
    @inlinable
    public var hasTransform: Bool {
        transformType != .identity
    }
    
    /// Type of the transformation matrix.
    @inlinable
    public var transformType: BLTransformType {
        blGradientGetTransformType(&box.object)
    }
    
    /// Gradient transformation matrix.
    @inlinable
    public var matrix: BLMatrix2D {
        get {
            var matrix = BLMatrix2D()
            blGradientGetTransform(&box.object, &matrix)
            return matrix
        }
        set {
            ensureUnique()
            
            _=_applyTransformOp(.assign, newValue)
        }
    }
    
    /// Gets the gradient values for this gradient.
    @inlinable
    public var values: [Double] {
        assert(BLGradientValue.maxValue.rawValue == 5)
        let values = box.object.impl.values
        return [
            values.0,
            values.1,
            values.2,
            values.3,
            values.4,
            values.5,
        ]
    }
    
    @inlinable
    public init() {
        box = BLBaseClass()
    }
    
    // TODO: Handle error results for init and create methods bellow
    
    @inlinable
    public init(
        linear: BLLinearGradientValues,
        extendMode: BLExtendMode = .pad,
        stops: [BLGradientStop]? = nil,
        matrix: BLMatrix2D? = nil
    ) {
        
        box = BLBaseClass { pointer in
            var linear = linear
            
            return withUnsafeNullablePointer(to: matrix) { matrix in
                blGradientInitAs(
                    pointer,
                    BLGradientType.linear,
                    &linear,
                    extendMode,
                    stops,
                    stops?.count ?? 0,
                    matrix
                )
            }
        }
    }
    
    @inlinable
    public init(
        radial: BLRadialGradientValues,
        extendMode: BLExtendMode = .pad,
        stops: [BLGradientStop]? = nil,
        matrix: BLMatrix2D? = nil
    ) {
        
        box = BLBaseClass { pointer in
            var radial = radial
            
            return withUnsafeNullablePointer(to: matrix) { matrix in
                blGradientInitAs(
                    pointer,
                    BLGradientType.radial,
                    &radial,
                    extendMode,
                    stops,
                    stops?.count ?? 0,
                    matrix
                )
            }
        }
    }
    
    @inlinable
    public init(
        conic: BLConicGradientValues,
        extendMode: BLExtendMode = .pad,
        stops: [BLGradientStop]? = nil,
        matrix: BLMatrix2D? = nil
    ) {
        
        box = BLBaseClass { pointer -> BLResult in
            var conic = conic
            
            return withUnsafeNullablePointer(to: matrix) { matrix in
                blGradientInitAs(
                    pointer,
                    BLGradientType.conic,
                    &conic,
                    extendMode,
                    stops,
                    stops?.count ?? 0,
                    matrix
                )
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
        blGradientEquals(&lhs.box.object, &rhs.box.object)
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
        blGradientGetValue(&box.object, Int(index.rawValue))
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
        if index < 0 || index >= size {
            fatalError("Index out of bounds: \(index) in bounds [0 - \(size)]")
        }
        if let stops = blGradientGetStops(&box.object) {
            ensureUnique()
            return replaceStopRgba32(index: index, offset: stops[index].offset, rgba32: rgba32.value)
        }

        return BLResult(BLResultCode.errorNotInitialized.rawValue)
    }

    @inlinable
    func indexOfStop(withOffset offset: Double) -> Int {
        blGradientIndexOfStop(&box.object, offset)
    }
}

public extension BLGradient {
    @discardableResult
    @inlinable
    mutating func resetMatrix() -> BLResult {
        ensureUnique()
        return blGradientApplyTransformOp(&box.object, BLTransformOp.reset, nil)
    }
    @discardableResult
    @inlinable
    mutating func translate(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.translate, x, y)
    }
    @discardableResult
    @inlinable
    mutating func translate(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.translate, p.x, p.y)
    }
    @discardableResult
    @inlinable
    mutating func translate(by p: BLPoint) -> BLResult {
        _applyTransformOp(.translate, p)
    }
    @discardableResult
    @inlinable
    mutating func scale(xy: Double) -> BLResult {
        _applyTransformOpV(.scale, xy, xy)
    }
    @discardableResult
    @inlinable
    mutating func scale(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.scale, x, y)
    }
    @discardableResult
    @inlinable
    mutating func scale(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.scale, p.x, p.y)
    }
    @discardableResult
    @inlinable
    mutating func scale(by p: BLPoint) -> BLResult {
        _applyTransformOp(.scale, p)
    }
    @discardableResult
    @inlinable
    mutating func skew(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.skew, x, y)
    }
    @discardableResult
    @inlinable
    mutating func skew(by p: BLPoint) -> BLResult {
        _applyTransformOp(.skew, p)
    }
    @discardableResult
    @inlinable
    mutating func rotate(angle: Double) -> BLResult {
        _applyTransformOp(.rotate, angle)
    }
    @discardableResult
    @inlinable
    mutating func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, x, y)
    }
    @discardableResult
    @inlinable
    mutating func rotate(angle: Double, point: BLPoint) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, point.x, point.y)
    }
    @discardableResult
    @inlinable
    mutating func rotate(angle: Double, point: BLPointI) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    @inlinable
    mutating func transform(_ matrix: BLMatrix2D) -> BLResult {
        _applyTransformOp(.transform, matrix)
    }
    @discardableResult
    @inlinable
    mutating func postTranslate(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postTranslate, x, y)
    }
    @discardableResult
    @inlinable
    mutating func postTranslate(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.postTranslate, p.x, p.y)
    }
    @discardableResult
    @inlinable
    mutating func postTranslate(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postTranslate, p)
    }
    @discardableResult
    @inlinable
    mutating func postScale(xy: Double) -> BLResult {
        _applyTransformOpV(.postScale, xy, xy)
    }
    @discardableResult
    @inlinable
    mutating func postScale(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postScale, x, y)
    }
    @discardableResult
    @inlinable
    mutating func postScale(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.postScale, p.x, p.y)
    }
    @discardableResult
    @inlinable
    mutating func postScale(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postScale, p)
    }
    @discardableResult
    @inlinable
    mutating func postSkew(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postSkew, x, y)
    }
    @discardableResult
    @inlinable
    mutating func postSkew(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postSkew, p)
    }
    @discardableResult
    @inlinable
    mutating func postRotate(angle: Double) -> BLResult {
        _applyTransformOp(.postRotate, angle)
    }
    @discardableResult
    @inlinable
    mutating func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, x, y)
    }
    @discardableResult
    @inlinable
    mutating func postRotate(angle: Double, point: BLPoint) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, point.x, point.y)
    }
    @discardableResult
    @inlinable
    mutating func postRotate(angle: Double, point: BLPointI) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    @inlinable
    mutating func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        _applyTransformOp(.postTransform, matrix)
    }
}

internal extension BLGradient {
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOp(_ opType: BLTransformOp, _ opData: BLMatrix2D) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyTransformOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOp(_ opType: BLTransformOp, _ opData: BLPoint) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyTransformOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOp(_ opType: BLTransformOp, _ opData: Double) -> BLResult {
        ensureUnique()
        return withUnsafePointer(to: opData) { pointer in
            blGradientApplyTransformOp(&box.object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOpV(_ opType: BLTransformOp, _ args: Double...) -> BLResult {
        ensureUnique()
        return args.withUnsafeBytes { pointer in
            blGradientApplyTransformOp(&box.object, opType, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    mutating func _applyTransformOpV<T: BinaryInteger>(_ opType: BLTransformOp, _ args: T...) -> BLResult {
        ensureUnique()
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blGradientApplyTransformOp(&box.object, opType, pointer.baseAddress)
        }
    }
}

public extension BLGradient {
    enum GradientValues {
        case linear(BLLinearGradientValues)
        case radial(BLRadialGradientValues)
        case conic(BLConicGradientValues)
    }
}

extension BLGradientCore: CoreStructure {
    public static let initializer = blGradientInit
    public static let deinitializer = blGradientReset
    public static let assignWeak = blGradientAssignWeak
    
    @usableFromInline
    var impl: BLGradientImpl {
        get { UnsafeMutablePointer(_d.impl)!.pointee }
        set { UnsafeMutablePointer(_d.impl)!.pointee = newValue }
    }
}
