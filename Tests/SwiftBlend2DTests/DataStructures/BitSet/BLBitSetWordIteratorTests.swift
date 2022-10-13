import XCTest

@testable import SwiftBlend2D

class BLBitSetWordIteratorTests: XCTestCase {
    func testIterator() {
        let bitSet = BLBitSet()
        bitSet.addRange(startBit: 100, endBit: 200)
        var sut = BLBitSetWordIterator(bitSet)
        
        let result = BitSetIteratorResult.fromBitSetWordIterator(&sut)

        XCTAssertEqual(result, [
            BitSetIteratorResult(wordIndex: 3, wordData: 0x0FFFFFFF),
            BitSetIteratorResult(wordIndex: 4, wordData: 0xFFFFFFFF),
            BitSetIteratorResult(wordIndex: 5, wordData: 0xFFFFFFFF),
            BitSetIteratorResult(wordIndex: 6, wordData: 0xFF000000),
        ])
    }
}

struct BitSetIteratorResult: Equatable, CustomStringConvertible {
    let wordIndex: UInt32
    let wordData: UInt32
    var description: String {
        String(format: "{ wordIndex: %u, wordData: 0x%08X }", wordIndex, wordData)
    }
    
    static func fromBitSetWordIterator(_ bitSetIterator: inout BLBitSetWordIterator) -> [Self] {
        var result: [Self] = []

        while let bits = bitSetIterator.nextWord() {
            result.append(
                BitSetIteratorResult(
                    wordIndex: bitSetIterator.wordIndex(),
                    wordData: bits
                )
            )
        }

        return result
    }
}
