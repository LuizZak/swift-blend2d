// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLConicGradientValues: CustomStringConvertible, Equatable, Hashable { }

public extension BLConicGradientValues {
    var description: String {
        "BLConicGradientValues(x0: \(x0), y0: \(y0), angle: \(angle), repeat: \(`repeat`))"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.x0 == rhs.x0 && lhs.y0 == rhs.y0 && lhs.angle == rhs.angle && lhs.`repeat` == rhs.`repeat`
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x0)
        hasher.combine(y0)
        hasher.combine(angle)
        hasher.combine(`repeat`)
    }
}
