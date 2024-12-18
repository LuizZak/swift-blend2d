// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLTriangle: @retroactive CustomStringConvertible, @retroactive Equatable, @retroactive Hashable { }

public extension BLTriangle {
    var description: String {
        "BLTriangle(x0: \(x0), y0: \(y0), x1: \(x1), y1: \(y1), x2: \(x2), y2: \(y2))"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.x0 == rhs.x0 && lhs.y0 == rhs.y0 && lhs.x1 == rhs.x1 && lhs.y1 == rhs.y1 && lhs.x2 == rhs.x2 && lhs.y2 == rhs.y2
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x0)
        hasher.combine(y0)
        hasher.combine(x1)
        hasher.combine(y1)
        hasher.combine(x2)
        hasher.combine(y2)
    }
}
