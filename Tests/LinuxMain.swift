import XCTest

import LibPNGTests
import SwiftBlend2DTests

var tests = [XCTestCaseEntry]()
tests += LibPNGTests.__allTests()
tests += SwiftBlend2DTests.__allTests()

XCTMain(tests)
