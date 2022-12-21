import blend2d

/// BitSet word iterator [C++ API].
///
/// Low-level iterator that sees a BitSet as an array of bit words. It only iterates non-zero words and
/// returns zero at the end of iteration.
///
/// A simple way of printing all non-zero words of a BitWord:
///
/// ```swift
/// var set = BLBitSet()
/// set.addRange(100, 200)
///
/// var it = BLBitSetWordIterator(set)
/// while let bits = it.nextWord() {
///     print(String("{WordIndex: %u, WordData: %08X }\n", it.wordIndex(), bits))
/// }
/// ```
public struct BLBitSetWordIterator {
    /// Underlying bitset being iterated.
    /// Kept around for lifetime reasons.
    private var _bitSet: BLBitSet

    private var _wordIndex: UInt32 = 0
    private var _segmentOffset: Int = 0
    private var _segmentCount: Int = 0

    // TODO: Inspect why locally sorting a copy of `_bitSet.data` leads to
    // incorrect results and (potentially) memory corruption.
    private var _data: BLBitSetData {
        _bitSet.data
    }
    private var _segmentPtr: UnsafePointer<BLBitSetSegment> {
        _data.segmentData.advanced(by: _segmentOffset)
    }
    private var _segment: BLBitSetSegment {
        _segmentPtr.pointee
    }

    /// Creates an iterator, that will iterate the given `bitSet`.
    ///
    /// - note: The `bitSet` cannot change or be destroyed during iteration.
    public init(_ bitSet: BLBitSet) {
        _bitSet = bitSet
        _segmentCount = Int(_data.segmentCount)
        _wordIndex = _segmentCount > 0 ? _segmentPtr.pointee.startWord() &- 1 : 0xFFFFFFFF
    }

    /// Returns the next (or the first, if called the first time) non-zero word
    /// of the `BitSet` or `nil` if the iteration ended.
    ///
    /// Use `wordIndex()` to get the index (in word units) of the word returned.
    public mutating func nextWord() -> UInt32? {
        if _segmentOffset == _segmentCount {
            return nil
        }

        _wordIndex &+= 1

        while true { // TODO: Rewrite as a bounded loop
            if _segment.allOnes() {
                if _wordIndex < _segment._rangeEndWord() {
                    return 0xFFFFFFFF
                }
            } else {
                let endWord: UInt32 = _segment._denseEndWord()
                while _wordIndex < endWord {
                    let bits: UInt32 = _segment.wordAt(
                        _wordIndex & (BLBitSetConstants.segmentWordCount.rawValue.toUInt32() - 1)
                    )

                    if bits != 0 {
                        return bits
                    }
                    
                    _wordIndex &+= 1
                }
            }

            _segmentOffset &+= 1

            if _segmentOffset == _segmentCount {
                return nil
            }

            _wordIndex = _segment.startWord()
        }
    }

    /// Returns the current bit index of a word returned by `nextWord()`.
    public func bitIndex() -> UInt32 {
        _wordIndex &* 32
    }

    /// Returns the current word index of a word returned by `nextWord()`.
    public func wordIndex() -> UInt32 {
        _wordIndex
    }
}

extension BLBitSetWordIterator: IteratorProtocol {
    /// Returns the current word being iterated, and moves the iterator to the
    /// next available word.
    ///
    /// Returns `nil` if the end of the bit set has been reached.
    public mutating func next() -> UInt32? {
        nextWord()
    }
}
