import XCTest
import blend2d
@testable import SwiftBlend2D

class BLContextTests: XCTestCase {
    func testInit() {
        _ = BLContext()
    }
    
    func testInitWithImage() {
        let image = BLImage(width: 2, height: 2, format: .prgb32)
        
        XCTAssertNotNil(BLContext(image: image))
    }
    
    func testInitWithImageReturnsNilOnEmptyImage() {
        let image = BLImage()
        
        XCTAssertNil(BLContext(image: image))
    }

    func testStrokePathCrash() throws {
        let image = BLImage(width: 400, height: 400, format: .prgb32)
        let ctx = try XCTUnwrap(BLContext(image: image))

        let path = BLPath()
        path.moveTo(x: 326.9375, y: 253.8544921875)
        path.cubicTo(x1: 350.0, y1: 253.8544921875, x2: 326.9375, y2: 253.8544921875, x3: 350.0, y3: 253.8544921875)
        
        ctx.setStrokeStyle(BLRgba32.white)
        ctx.strokePath(path)
    }
    
    /*
    func testGetStrokeStyleGradientRefCount() {
        let sut = makeSut()
        sut.setStrokeStyle(BLGradient(linear: BLLinearGradientValues(box: .empty)))
        
        let result = sut.strokeStyle
        
        switch result {
        case .gradient(let gradient):
            XCTAssertEqual(1, gradient.box.object.impl.pointee.refCount)
        default:
            XCTFail("Expected gradient style")
        }
    }
    
    func testGetStrokeStylePatternRefCount() {
        let img = BLImage(width: 2, height: 2, format: .prgb32)
        let sut = makeSut()
        sut.setStrokeStyle(BLPattern(image: img))
        
        let result = sut.strokeStyle
        
        switch result {
        case .pattern(let pattern):
            XCTAssertEqual(1, pattern.box.object.impl.pointee.refCount)
        default:
            XCTFail("Expected pattern style")
        }
    }
    
    func testGetFillStyleGradientRefCount() {
        let sut = makeSut()
        sut.setFillStyle(BLGradient(linear: BLLinearGradientValues(box: .empty)))
        
        let result = sut.fillStyle
        
        switch result {
        case .gradient(let gradient):
            XCTAssertEqual(1, gradient.box.object.impl.pointee.refCount)
        default:
            XCTFail("Expected gradient style")
        }
    }
    
    func testGetFillStylePatternRefCount() {
        let img = BLImage(width: 2, height: 2, format: .prgb32)
        let sut = makeSut()
        sut.setFillStyle(BLPattern(image: img))
        
        let result = sut.fillStyle
        
        switch result {
        case .pattern(let pattern):
            XCTAssertEqual(1, pattern.box.object.impl.pointee.refCount)
        default:
            XCTFail("Expected pattern style")
        }
    }
    */
}

extension BLContextTests {
    func makeSut() -> BLContext {
        let img = BLImage(width: 2, height: 2, format: .prgb32)
        return BLContext(image: img)!
    }
}
