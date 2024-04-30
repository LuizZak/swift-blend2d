// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLRange: CustomStringConvertible, Equatable, Hashable { }

public extension BLRange {
    var description: String {
        "BLRange(start: \(start), end: \(end))"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.start == rhs.start && lhs.end == rhs.end
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(start)
        hasher.combine(end)
    }
}