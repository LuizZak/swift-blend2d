import blend2d

public final class BLGradient: BLBaseClass<BLGradientCore> {
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
    
    public var extendMode: BLExtendMode {
        get {
            return BLExtendMode(rawValue: blGradientGetExtendMode(&object))
        }
        set {
            blGradientSetExtendMode(&object, newValue.rawValue)
        }
    }
    
    public var type: BLGradientType {
        get {
            return BLGradientType(rawValue: blGradientGetType(&object))
        }
        set {
            blGradientSetType(&object, newValue.rawValue)
        }
    }
    
    /// Convenience subscript that wraps 'setValue'/'getValue' calls.
    public subscript(index: Int) -> Double {
        get {
            return blGradientGetValue(&object, index)
        }
        
        set {
            blGradientSetValue(&object, index, newValue)
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

    public func getValue(atIndex index: Int) -> Double {
        return blGradientGetValue(&object, index)
    }

    public func setValue(atIndex index: Int, _ value: Double) {
        blGradientSetValue(&object, index, value)
    }

    public func setValues(atIndex index: Int, _ values: [Double]) {
        var values = values
        blGradientSetValues(&object, index, &values, values.count)
    }

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
