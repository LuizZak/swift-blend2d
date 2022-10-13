import blend2d

public extension BLBitSetSegment {
    func allOnes() -> Bool {
        (_startWord & BLBitSetConstants.rangeMask.rawValue) != 0
    }
    mutating func clearData() {
        _data = (0, 0, 0, 0)
    }
    mutating func fillData() {
        _data = (0xFF, 0xFF, 0xFF, 0xFF)
    }

    func withDataPointer<T>(_ closure: (UnsafePointer<UInt32>) -> T) -> T {
        withUnsafePointer(to: _data) { pointer in
            pointer.withMemoryRebound(to: UInt32.self, capacity: 4, closure)
        }
    }
    mutating func withMutableDataPointer<T>(_ closure: (UnsafeMutablePointer<UInt32>) -> T) -> T {
        withUnsafeMutablePointer(to: &_data) { pointer in
            pointer.withMemoryRebound(to: UInt32.self, capacity: 4, closure)
        }
    }
    func wordAt<T: FixedWidthInteger>(_ index: T) -> UInt32 {
        switch index {
        case 0:
            return _data.0
        case 1:
            return _data.1
        case 2:
            return _data.2
        case 3:
            return _data.3
        default:
            preconditionFailure(
                "Expected \(index) to be >= 0 && < BL_BIT_SET_SEGMENT_WORD_COUNT (\(BLBitSetConstants.segmentWordCount.rawValue))"
            )
        }
    }

    func _rangeStartWord() -> UInt32 {
        _startWord & ~BLBitSetConstants.rangeMask.rawValue
    }
    func _rangeEndWord() -> UInt32 {
        _data.0
    }

    func _denseStartWord() -> UInt32 {
        _startWord
    }
    func _denseEndWord() -> UInt32 {
        _startWord + BLBitSetConstants.segmentWordCount.rawValue
    }

    mutating func _setRangeStartWord(index: UInt32) {
        _startWord = index
    }
    mutating func _setRangeEndWord(index: UInt32) {
        _data.0 = index
    }

    func startWord() -> UInt32 {
        _startWord & ~BLBitSetConstants.rangeMask.rawValue
    }
    func startSegmentId() -> UInt32 {
        startWord() / BLBitSetConstants.segmentWordCount.rawValue
    }
    func startBit() -> UInt32 {
        _startWord &* 32
    }

    func endWord() -> UInt32 {
        let rangeEnd = _rangeEndWord()
        let denseEnd = _denseEndWord()
        return allOnes() ? rangeEnd : denseEnd
    }

    func endSegmentId() -> UInt32 {
        endWord() / BLBitSetConstants.segmentWordCount.rawValue
    }
    func lastBit() -> UInt32 {
        endWord() &* 32 &- 1
    }
}
