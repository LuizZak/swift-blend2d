import blend2d

public struct BLStrokeOptions {
    @usableFromInline
    var box: BLBaseClass<BLStrokeOptionsCore>

    @inlinable
    public var width: Double {
        get { box.object.width }
        set {
            ensureUnique()
            box.object.width = newValue
        }
    }
    @inlinable
    public var miterLimit: Double {
        get { box.object.miterLimit }
        set {
            ensureUnique()
            box.object.miterLimit = newValue
        }
    }
    @inlinable
    public var dashOffset: Double {
        get { box.object.dashOffset }
        set {
            ensureUnique()
            box.object.dashOffset = newValue
        }
    }
    @inlinable
    public var startCap: BLStrokeCap {
        get { BLStrokeCap(rawValue: BLStrokeCap.RawValue(box.object.startCap)) }
        set {
            ensureUnique()
            box.object.startCap = UInt8(newValue.rawValue)
        }
    }
    @inlinable
    public var endCap: BLStrokeCap {
        get { BLStrokeCap(rawValue: BLStrokeCap.RawValue(box.object.endCap)) }
        set {
            ensureUnique()
            box.object.endCap = UInt8(newValue.rawValue)
        }
    }
    @inlinable
    public var join: BLStrokeJoin {
        get { BLStrokeJoin(rawValue: BLStrokeJoin.RawValue(box.object.join)) }
        set {
            ensureUnique()
            box.object.join = UInt8(newValue.rawValue)
        }
    }
    public var transformOrder: BLStrokeTransformOrder {
        get { BLStrokeTransformOrder(rawValue: BLStrokeTransformOrder.RawValue(box.object.transformOrder)) }
        set {
            ensureUnique()
            box.object.transformOrder = UInt8(newValue.rawValue)
        }
    }

    @inlinable
    public var dashArray: [Double] {
        get { BLArray<Double>(weakAssign: box.object.dashArray).asArray() }
        set {
            ensureUnique()
            
            blArrayClear(&box.object.dashArray)
            
            newValue.withTemporaryView { view in
                guard let pointer = view.pointee.data else {
                    return
                }
                
                blArrayAppendData(&box.object.dashArray, pointer, newValue.count)
            }
        }
    }
    
    public init() {
        box = BLBaseClass()
    }
    
    public mutating func setCaps(_ cap: BLStrokeCap) {
        startCap = cap
        endCap = cap
    }
    
    @inlinable
    mutating func ensureUnique() {
        if isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }
}

extension BLStrokeOptionsCore: CoreStructure {
    public static let initializer = blStrokeOptionsInit
    public static let deinitializer = blStrokeOptionsReset
    public static let assignWeak = blStrokeOptionsAssignWeak
}
