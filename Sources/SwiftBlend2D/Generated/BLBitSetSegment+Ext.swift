// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLBitSetSegment: Equatable { }

public extension BLBitSetSegment {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs._startWord == rhs._startWord && lhs._data == rhs._data
    }
}