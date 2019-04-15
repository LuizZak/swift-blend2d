#if !canImport(ObjectiveC)
import XCTest

extension BLArrayTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLArrayTests = [
        ("testAppendU8", testAppendU8),
        ("testInit", testInit),
        ("testReserveCapacity", testReserveCapacity),
        ("testShrink", testShrink),
    ]
}

extension BLBaseClassTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLBaseClassTests = [
        ("testBorrowInitializer", testBorrowInitializer),
        ("testDefaultInitialize", testDefaultInitialize),
        ("testDeinitialize", testDeinitialize),
        ("testDeinitializeOnLeaveScope", testDeinitializeOnLeaveScope),
        ("testDeinitializeWithBorrowedObject", testDeinitializeWithBorrowedObject),
        ("testDontDeinitializeBorrowedObjects", testDontDeinitializeBorrowedObjects),
        ("testInitializeWithClosure", testInitializeWithClosure),
    ]
}

extension BLBoxITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLBoxITests = [
        ("testContains", testContains),
        ("testContainsPoint", testContainsPoint),
        ("testEquals", testEquals),
        ("testHeight", testHeight),
        ("testInitWithWidthAndHeight", testInitWithWidthAndHeight),
        ("testReset", testReset),
        ("testWidth", testWidth),
    ]
}

extension BLBoxTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLBoxTests = [
        ("testContains", testContains),
        ("testContainsPoint", testContainsPoint),
        ("testContainsPointI", testContainsPointI),
        ("testEquals", testEquals),
        ("testHeight", testHeight),
        ("testInitWithWidthAndHeight", testInitWithWidthAndHeight),
        ("testReset", testReset),
        ("testWidth", testWidth),
    ]
}

extension BLContextTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLContextTests = [
        ("testInit", testInit),
        ("testInitWithImage", testInitWithImage),
        ("testInitWithImageReturnsNilOnEmptyImage", testInitWithImageReturnsNilOnEmptyImage),
    ]
}

extension BLImageCodecTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLImageCodecTests = [
        ("testBuiltInCodecs", testBuiltInCodecs),
        ("testBuiltInCodecsCountMatchesInternalImageCodecs", testBuiltInCodecsCountMatchesInternalImageCodecs),
    ]
}

extension BLImageTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLImageTests = [
        ("testInitDefault", testInitDefault),
        ("testInitWithSize", testInitWithSize),
        ("testReadFromData", testReadFromData),
        ("testSize", testSize),
        ("testWriteToData", testWriteToData),
    ]
}

extension BLPointITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLPointITests = [
        ("testEquals", testEquals),
    ]
}

extension BLPointTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLPointTests = [
        ("testEquals", testEquals),
    ]
}

extension BLSizeITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLSizeITests = [
        ("testEquals", testEquals),
    ]
}

extension BLSizeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BLSizeTests = [
        ("testEquals", testEquals),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BLArrayTests.__allTests__BLArrayTests),
        testCase(BLBaseClassTests.__allTests__BLBaseClassTests),
        testCase(BLBoxITests.__allTests__BLBoxITests),
        testCase(BLBoxTests.__allTests__BLBoxTests),
        testCase(BLContextTests.__allTests__BLContextTests),
        testCase(BLImageCodecTests.__allTests__BLImageCodecTests),
        testCase(BLImageTests.__allTests__BLImageTests),
        testCase(BLPointITests.__allTests__BLPointITests),
        testCase(BLPointTests.__allTests__BLPointTests),
        testCase(BLSizeITests.__allTests__BLSizeITests),
        testCase(BLSizeTests.__allTests__BLSizeTests),
    ]
}
#endif
