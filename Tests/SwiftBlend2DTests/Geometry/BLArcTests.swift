import XCTest
import blend2d
import SwiftBlend2D

class BLArcTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6),
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        )
        
        XCTAssertNotEqual(
            BLArc(cx: 9, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6),
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 9, rx: 3, ry: 4, start: 5, sweep: 6),
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 2, rx: 9, ry: 4, start: 5, sweep: 6),
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 2, rx: 3, ry: 9, start: 5, sweep: 6),
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 9, sweep: 6),
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 9),
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        )
    }
    
    func testHashable() {
        XCTAssertEqual(
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue,
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue
        )
        
        XCTAssertNotEqual(
            BLArc(cx: 9, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue,
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 9, rx: 3, ry: 4, start: 5, sweep: 6).hashValue,
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 2, rx: 9, ry: 4, start: 5, sweep: 6).hashValue,
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 2, rx: 3, ry: 9, start: 5, sweep: 6).hashValue,
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 9, sweep: 6).hashValue,
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue
        )
        XCTAssertNotEqual(
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 9).hashValue,
            BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6).hashValue
        )
    }
    
    func testInitWithCoordinates() {
        let arc = BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        
        XCTAssertEqual(arc.cx, 1)
        XCTAssertEqual(arc.cy, 2)
        XCTAssertEqual(arc.rx, 3)
        XCTAssertEqual(arc.ry, 4)
        XCTAssertEqual(arc.start, 5)
        XCTAssertEqual(arc.sweep, 6)
    }
    
    func testInitWithPoints() {
        let arc = BLArc(
            center: BLPoint(x: 1, y: 2),
            radius: BLPoint(x: 3, y: 4),
            start: 5,
            sweep: 6
        )
        
        XCTAssertEqual(arc.cx, 1)
        XCTAssertEqual(arc.cy, 2)
        XCTAssertEqual(arc.rx, 3)
        XCTAssertEqual(arc.ry, 4)
        XCTAssertEqual(arc.start, 5)
        XCTAssertEqual(arc.sweep, 6)
    }
    
    func testDescription() {
        let arc = BLArc(cx: 1, cy: 2, rx: 3, ry: 4, start: 5, sweep: 6)
        
        XCTAssertEqual(
            arc.description,
            "BLArc(cx: 1.0, cy: 2.0, rx: 3.0, ry: 4.0, start: 5.0, sweep: 6.0)"
        )
    }
}
