import blend2d

/// Bit array structure.
public struct BLBitArray {
    @usableFromInline
    var box: BLBaseClass<BLBitArrayCore>

    /// Returns `true` if this `BLBitArray`'s size is zero.
    public var isEmpty: Bool {
        blBitArrayIsEmpty(&box.object)
    }

    /// Returns the size of this `BLBitArray` in bits.
    public var size: Int {
        Int(blBitArrayGetSize(&box.object))
    }

    /// Returns the number of 32-bit words this `BLBitArray` uses.
    public var wordCount: Int {
        Int(blBitArrayGetWordCount(&box.object))
    }

    /// Returns the capacity of this `BLBitArray` in bits.
    public var capacity: Int {
        Int(blBitArrayGetCapacity(&box.object))
    }

    /// Returns the number of bits set in this `BLBitArray`.
    public var cardinality: Int {
        Int(blBitArrayGetCardinality(&box.object))
    }

    /// Gets or sets a bit at a given index in this `BLBitArray`.
    public subscript(index: UInt32) -> Bool {
        get { hasBit(at: index) }
        set {
            ensureUnique()
            if newValue {
                setBit(index)
            } else {
                clearBit(index)
            }
        }
    }

    public init() {
        box = BLBaseClass()
    }
    
    @inlinable
    mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }

    /// Returns the number of bits set in the given `[startBit, endBit)` range.
    public func cardinalityInRange(startBit: UInt32, endBit: UInt32) -> UInt32 {
        blBitArrayGetCardinalityInRange(&box.object, startBit, endBit)
    }

    /// Returns the value of a bit at a given index in this `BLBitArray`.
    public func hasBit(at index: UInt32) -> Bool {
        blBitArrayHasBit(&box.object, index)
    }

    /// Returns whether this `BLBitArray` has at least one bit set in the given
    /// `[startBit, endBit)` range.
    public func hasBitsInRange(startBit: UInt32, endBit: UInt32) -> Bool {
        blBitArrayHasBitsInRange(&box.object, startBit, endBit)
    }

    /// Returns `true` if this `BLBitArray` subsumes (i.e. includes) `other`.
    public func subsumes(_ other: BLBitArray) -> Bool {
        blBitArraySubsumes(&box.object, &other.box.object)
    }

    /// Returns `true` if this `BLBitArray` intersects with `other`.
    public func intersects(_ other: BLBitArray) -> Bool {
        blBitArrayIntersects(&box.object, &other.box.object)
    }

    // MARK: Mutation

    /// Clears the contents of this `BLBitArray` without releasing its dynamically
    /// allocated data, if possible.
    @discardableResult
    public mutating func clear() -> BLResult {
        ensureUnique()
        return blBitArrayClear(&box.object)
    }

    /// Resizes this `BLBitArray` so its size matches `newSize`.
    @discardableResult
    public mutating func resize(_ newSize: UInt32) -> BLResult {
        ensureUnique()
        return blBitArrayResize(&box.object, newSize)
    }

    /// Reserves `minimumCapacity` bits in this `BLBitArray` without changing its
    /// size.
    @discardableResult
    public mutating func reserveCapacity(_ minimumCapacity: UInt32) -> BLResult {
        ensureUnique()
        return blBitArrayReserve(&box.object, minimumCapacity)
    }

    /// Shrinks the capacity of this `BLBitArray` so it matches its size.
    @discardableResult
    public mutating func shrink() -> BLResult {
        ensureUnique()
        return blBitArrayShrink(&box.object)
    }

    /// Sets a bit at a given index in this `BLBitArray` to be true.
    @discardableResult
    public mutating func setBit(_ index: UInt32) -> BLResult {
        ensureUnique()
        return blBitArraySetBit(&box.object, index)
    }

    /// Sets all bits in range `[startBit, endBit)` in this `BLBitArray` to be true.
    @discardableResult
    public mutating func fillRange(startBit: UInt32, endBit: UInt32) -> BLResult {
        ensureUnique()
        return blBitArrayFillRange(&box.object, startBit, endBit)
    }

    /// Sets a bit at a given index in this `BLBitArray` to be false.
    @discardableResult
    public mutating func clearBit(_ index: UInt32) -> BLResult {
        ensureUnique()
        return blBitArrayClearBit(&box.object, index)
    }

    /// Sets all bits in range `[startBit, endBit)` in this `BLBitArray` to be false.
    @discardableResult
    public mutating func clearRange(startBit: UInt32, endBit: UInt32) -> BLResult {
        ensureUnique()
        return blBitArrayClearRange(&box.object, startBit, endBit)
    }

    /// Sets bits starting from `bitIndex` specified by `bitMask` to false.
    /// 0-bits in `bitMask` are ignored.
    @discardableResult
    public mutating func clearWord(at bitIndex: UInt32, _ bitMask: UInt32) -> BLResult {
        ensureUnique()
        return blBitArrayClearWord(&box.object, bitIndex, bitMask)
    }

    /// Sets bits starting from `bitIndex` specified by `bitMasks` to false.
    /// 0-bits in `bitMasks` are ignored.
    @discardableResult
    public mutating func clearWords(at bitIndex: UInt32, _ bitMasks: [UInt32]) -> BLResult {
        ensureUnique()
        return bitMasks.withUnsafeBufferPointer { buffer in
            blBitArrayClearWords(&box.object, bitIndex, buffer.baseAddress, UInt32(buffer.count))
        }
    }

    /// Appends a bit to this `BLBitArray`.
    @discardableResult
    public mutating func appendBit(_ value: Bool) -> BLResult {
        ensureUnique()
        return blBitArrayAppendBit(&box.object, value)
    }

    /// Appends a single word of 32-bits to this `BLBitArray`.
    @discardableResult
    public mutating func appendWord(_ value: UInt32) -> BLResult {
        ensureUnique()
        return blBitArrayAppendWord(&box.object, value)
    }

    /// Appends whole words to this `BLBitArray`.
    @discardableResult
    public mutating func appendWords(_ values: [UInt32]) -> BLResult {
        ensureUnique()
        return values.withUnsafeBufferPointer { buffer in
            blBitArrayAppendWords(&box.object, buffer.baseAddress, UInt32(buffer.count))
        }
    }
}

extension BLBitArrayCore: CoreStructure {
    public static let initializer = blBitArrayInit
    public static let deinitializer = blBitArrayReset
    public static let assignWeak = blBitArrayAssignWeak
}

// MARK: - Conformances

extension BLBitArray: Equatable {
    /// Compares two bit arrays under bitwise equality.
    public static func == (lhs: BLBitArray, rhs: BLBitArray) -> Bool {
        blBitArrayEquals(&lhs.box.object, &rhs.box.object)
    }
}

extension BLBitArray: Comparable {
    /// Compares two bit arrays and returns `true` iff `lhs` compares lower than
    /// `rhs` via `blBitArrayCompare`.
    public static func < (lhs: BLBitArray, rhs: BLBitArray) -> Bool {
        blBitArrayCompare(&lhs.box.object, &rhs.box.object) == -1
    }
}
