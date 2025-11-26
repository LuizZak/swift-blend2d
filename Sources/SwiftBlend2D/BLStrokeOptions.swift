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
        get { box.object.miter_limit }
        set {
            ensureUnique()
            box.object.miter_limit = newValue
        }
    }
    @inlinable
    public var dashOffset: Double {
        get { box.object.dash_offset }
        set {
            ensureUnique()
            box.object.dash_offset = newValue
        }
    }
    @inlinable
    public var startCap: BLStrokeCap {
        get { BLStrokeCap(rawValue: BLStrokeCap.RawValue(box.object.start_cap)) }
        set {
            ensureUnique()
            box.object.start_cap = UInt8(newValue.rawValue)
        }
    }
    @inlinable
    public var endCap: BLStrokeCap {
        get { BLStrokeCap(rawValue: BLStrokeCap.RawValue(box.object.end_cap)) }
        set {
            ensureUnique()
            box.object.end_cap = UInt8(newValue.rawValue)
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
        get { BLStrokeTransformOrder(rawValue: BLStrokeTransformOrder.RawValue(box.object.transform_order)) }
        set {
            ensureUnique()
            box.object.transform_order = UInt8(newValue.rawValue)
        }
    }

    @inlinable
    public var dashArray: [Double] {
        get { BLArray<Double>(weakAssign: box.object.dash_array).asArray() }
        set {
            ensureUnique()

            bl_array_clear(&box.object.dash_array)

            newValue.withTemporaryView { view in
                guard let pointer = view.pointee.data else {
                    return
                }

                bl_array_append_data(&box.object.dash_array, pointer, newValue.count)
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
    public static let initializer = bl_stroke_options_init
    public static let deinitializer = bl_stroke_options_reset
    public static let assignWeak = bl_stroke_options_assign_weak
}
