// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLFontQueryProperties: @retroactive CustomStringConvertible, @retroactive Equatable { }

public extension BLFontQueryProperties {
    var description: String {
        "BLFontQueryProperties(style: \(style), weight: \(weight), stretch: \(stretch))"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.style == rhs.style && lhs.weight == rhs.weight && lhs.stretch == rhs.stretch
    }
}
