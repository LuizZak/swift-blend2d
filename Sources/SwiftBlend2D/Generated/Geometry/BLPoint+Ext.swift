// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLPoint: Hashable, Equatable { }

public extension BLPoint {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
