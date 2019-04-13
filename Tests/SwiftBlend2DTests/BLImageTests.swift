import XCTest
import blend2d
@testable import SwiftBlend2D

class BLImageTests: XCTestCase {
    func testInitDefault() {
        let image = BLImage()
        
        assertIsDefaultPointer(image.image)
    }
    
    func testInitWithSize() {
        let image = BLImage(width: 32, height: 32, format: BL_FORMAT_PRGB32)
        
        assertIsNonDefaultPointer(image.image)
    }
}

extension BLImageTests {
    
    static var nilImageImpl: UnsafeMutablePointer<BLImageImpl> {
        var imageCore = BLImageCore()
        blImageInit(&imageCore)
        return imageCore.impl
    }
    
    func assertIsNonDefaultPointer(_ imageCore: BLImageCore,
                                   file: String = #file,
                                   line: Int = #line) {
        if imageCore.impl == nil {
            recordFailure(
                withDescription: """
                Provided image core has a nil-pointer to its inner BLImageImpl value.
                Did you forget to invoke blImageInit()?
                """,
                inFile: file,
                atLine: line,
                expected: true
            )
        } else if imageCore.impl == BLImageTests.nilImageImpl {
            recordFailure(
                withDescription: """
                Expected image implementation to not point to \(BLImageTests.nilImageImpl) (default image implementation).
                """,
                inFile: file,
                atLine: line,
                expected: true
            )
        }
    }
    
    func assertIsDefaultPointer(_ imageCore: BLImageCore,
                                file: String = #file,
                                line: Int = #line) {
        
        if imageCore.impl == nil {
            recordFailure(
                withDescription: """
                Provided image core has a nil-pointer to its inner BLImageImpl value.
                Did you forget to invoke blImageInit()?
                """,
                inFile: file,
                atLine: line,
                expected: true
            )
        } else if imageCore.impl != BLImageTests.nilImageImpl {
            recordFailure(
                withDescription: """
                Expected image implementation to point to \(BLImageTests.nilImageImpl) \
                (default image implementation), but found a pointer to \(imageCore.impl as Any) instead.
                """,
                inFile: file,
                atLine: line,
                expected: true
            )
        }
    }
}
