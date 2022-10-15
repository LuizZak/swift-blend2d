// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLLinearGradientValues: CustomStringConvertible, Equatable, Hashable { }

public extension BLLinearGradientValues {
    var description: String {
        "BLLinearGradientValues(x0: \(x0), y0: \(y0), x1: \(x1), y1: \(y1))"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.x0 == rhs.x0 && lhs.y0 == rhs.y0 && lhs.x1 == rhs.x1 && lhs.y1 == rhs.y1
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x0)
        hasher.combine(y0)
        hasher.combine(x1)
        hasher.combine(y1)
    }
}
