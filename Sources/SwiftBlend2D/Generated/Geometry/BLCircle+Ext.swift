// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLCircle: CustomStringConvertible, Equatable, Hashable { }

public extension BLCircle {
    var description: String {
        "BLCircle(cx: \(cx), cy: \(cy), r: \(r))"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.cx == rhs.cx && lhs.cy == rhs.cy && lhs.r == rhs.r
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cx)
        hasher.combine(cy)
        hasher.combine(r)
    }
}
