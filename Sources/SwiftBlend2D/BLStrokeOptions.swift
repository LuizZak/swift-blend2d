import blend2d

public final class BLStrokeOptions: BLBaseClass<BLStrokeOptionsCore> {
    public var width: Double {
        get { return object.width }
        set { object.width = newValue }
    }
    public var miterLimit: Double {
        get { return object.miterLimit }
        set { object.miterLimit = newValue }
    }
    public var dashOffset: Double {
        get { return object.dashOffset }
        set { object.dashOffset = newValue }
    }
    public var startCap: BLStrokeCap {
        get { return BLStrokeCap(rawValue: BLStrokeCap.RawValue(object.startCap)) }
        set { object.startCap = UInt8(newValue.rawValue) }
    }
    public var endCap: BLStrokeCap {
        get { return BLStrokeCap(rawValue: BLStrokeCap.RawValue(object.endCap)) }
        set { object.endCap = UInt8(newValue.rawValue) }
    }
    public var join: BLStrokeJoin {
        get { return BLStrokeJoin(rawValue: BLStrokeJoin.RawValue(object.join)) }
        set { object.join = UInt8(newValue.rawValue) }
    }
    public var transformOrder: BLStrokeTransformOrder {
        get { return BLStrokeTransformOrder(rawValue: BLStrokeTransformOrder.RawValue(object.transformOrder)) }
        set { object.transformOrder = UInt8(newValue.rawValue) }
    }
    
    public var dashArray: [Double] {
        get { return BLArray<Double>(weakAssign: object.dashArray).asArray() }
        set {
            let array = BLArray<Double>(weakAssign: object.dashArray)
            array.replaceContents(newValue)
        }
    }
    
    public override init() {
        super.init()
    }
    
    public func setCaps(_ cap: BLStrokeCap) {
        startCap = cap
        endCap = cap
    }
}

extension BLStrokeOptionsCore: CoreStructure {
    public static let initializer = blStrokeOptionsInit
    public static let deinitializer = blStrokeOptionsReset
    public static var assignWeak = blStrokeOptionsAssignWeak
}
