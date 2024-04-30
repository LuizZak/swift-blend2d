import blend2d

/// BitSet container.
///
/// BitSet container implements sparse BitSet that consists of segments, where
/// each segment represents either dense range of bits or a range of bits that
/// are all set to one. In addition, the BitSet provides also a SSO mode, in which
/// it's possible to store 96 dense bits (3 consecutive BitWords) in the whole
/// addressable range or a range of ones. SSO mode optimizes use cases, in which
/// very small BitSets are used (typically in OpenType pipeline).
///
/// The BitSet itself has been optimized for Blend2D use cases, which are the
/// following:
///
///   1. Representing character coverage of fonts and unicode text. This use-case
///      requires sparseness and ranges as some fonts, especially those designed
///      for CJK use, provide thousands of glyphs that have pretty high code
///      points - using BLBitArray would be very wasteful in this particular case.
///
public class BLBitSet: BLBaseClass<BLBitSetCore> {
    /// Tests whether the BitSet is empty (has no content).
    ///
    /// Returns `true` if the BitSet's size is zero.
    public var isEmpty: Bool {
        blBitSetIsEmpty(&object)
    }

    /// Stores a normalized `BitSet` data represented as segments.
    ///
    /// If the `BitSet` is in SSO mode, it will be converter to temporary segments
    /// provided by `BLBitSetData.ssoSegments`, if the `BitSet` is in dynamic mode
    /// (already contains segments) then only a pointer to the data will be stored
    /// into the result.
    ///
    /// - remarks: The data written into the result can reference the data in the
    /// `BitSet`, thus the `BitSet` cannot be manipulated during the use of the
    /// data. This property is ideal for inspecting the content of the `BitSet`
    /// in a unique way and for implementing iterators that don't have to be
    /// aware of how SSO data is represented and used.
    public var data: BLBitSetData {
        var data = BLBitSetData()
        blBitSetGetData(&object, &data)
        return data
    }

    /// Returns the number of segments this BitSet occupies.
    ///
    /// - note: If the BitSet is in SSO mode then the returned value is the
    /// number of segments the BitSet would occupy when the BitSet was converted
    /// to dynamic.
    public var segmentCount: Int {
        Int(blBitSetGetSegmentCount(&object))
    }

    /// Returns the number of segments this BitSet has allocated.
    ///
    /// - note: If the BitSet is in SSO mode the returned value is always zero.
    public var segmentCapacity: Int {
        Int(blBitSetGetSegmentCapacity(&object))
    }

    public var cardinality: Int {
        Int(blBitSetGetCardinality(&object))
    }

    /// Returns the range of the BitSet as `[startOut, endOut)`.
    ///
    /// If this bitset is empty, the result is `nil`.
    public var range: (Int, Int)? {
        var start: UInt32 = 0
        var end: UInt32 = 0

        if !blBitSetGetRange(&object, &start, &end) {
            return nil
        }

        return (Int(start), Int(end))
    }

    public override init() {
        super.init()
    }

    /// Returns a bit-value at the given `bitIndex`.
    public func hasBit(_ bitIndex: Int) -> Bool {
        blBitSetHasBit(&object, UInt32(bitIndex))
    }

    /// Returns whether the bit-set has at least on bit in the given range
    /// `[startBit:endBit)`.
    public func hasBitsInRange(startBit: Int, endBit: Int) -> Bool {
        blBitSetHasBitsInRange(&object, UInt32(startBit), UInt32(endBit))
    }

    /// Returns whether this BitSet subsumes `other`.
    public func subsumes(_ other: BLBitSet) -> Bool {
        blBitSetSubsumes(&object, &other.object)
    }

    /// Returns whether this BitSet intersects with `other`.
    public func intersects(_ other: BLBitSet) -> Bool {
        blBitSetIntersects(&object, &other.object)
    }

    /// Returns the number of bits set in the given `[startBit, endBit)` range.
    public func cardinalityInRange(startBit: Int, endBit: Int) -> Int {
        Int(blBitSetGetCardinalityInRange(&object, UInt32(startBit), UInt32(endBit)))
    }

    /// Clears the content of the BitSet without releasing its dynamically
    /// allocated data, if possible.
    public func clear() {
        blBitSetClear(&object)
    }

    /// Shrinks the capacity of the BitSet to match the actual content.
    public func shrink() {
        blBitSetShrink(&object)
    }

    /// Optimizes the BitSet by clearing unused pages and by merging continuous
    /// pages, without reallocating the BitSet.
    public func optimize() {
        blBitSetOptimize(&object)
    }

    /// Bounds the BitSet to the given interval `[startBit:endBit)`.
    public func chop(startBit: Int, endBit: Int) {
        blBitSetChop(&object, UInt32(startBit), UInt32(endBit))
    }

    /// Truncates the BitSet so it's maximum bit set is less than `n`.
    public func truncate(_ n: Int) {
        chop(startBit: 0, endBit: n)
    }

    /// Adds a bit to the BitSet at the given `index`.
    public func addBit(index: Int) {
        blBitSetAddBit(&object, UInt32(index))
    }

    /// Adds a range of bits `[startBit:endBit)` to the BitSet.
    public func addRange(startBit: Int, endBit: Int) {
        blBitSetAddRange(&object, UInt32(startBit), UInt32(endBit))
    }

    /// Adds a dense data to the BitSet starting a bit index `startWord`.
    public func addWords(startWord: Int, wordData: [Int]) {
        var words: [UInt32] = wordData.map(UInt32.init)
        blBitSetAddWords(&object, UInt32(startWord), &words, UInt32(words.count))
    }

    /// Clears a bit in the BitSet at the given `index`.
    public func clearBit(index: Int) {
        blBitSetClearBit(&object, UInt32(index))
    }

    /// Clears a range of bits `[startBit:endBit)` in the BitSet.
    public func clearRange(startBit: Int, endBit: Int) {
        blBitSetClearRange(&object, UInt32(startBit), UInt32(endBit))
    }
}

extension BLBitSetCore: CoreStructure {
    public static let initializer = blBitSetInit
    public static let deinitializer = blBitSetReset
    public static let assignWeak = blBitSetAssignWeak
}

extension BLBitSet: Equatable {
    /// Returns whether two BitSets are bitwise equal.
    public static func == (lhs: BLBitSet, rhs: BLBitSet) -> Bool {
        blBitSetEquals(&lhs.object, &rhs.object)
    }
}

extension BLBitSet: Comparable {
    /// Compares two BitSets and returns `true` if `lhs` compares lower than `rhs`
    public static func < (lhs: BLBitSet, rhs: BLBitSet) -> Bool {
        blBitSetCompare(&lhs.object, &rhs.object) < 0
    }
}

extension BLBitSet: Sequence {
    /// Creates an iterator for this `BLBitSet` that iterates over each word data
    /// within the set.
    public func makeIterator() -> BLBitSetWordIterator {
        .init(self)
    }
}
