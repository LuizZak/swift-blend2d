// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.
// Generated by generate_types.py

import blend2d

extension BLFontFaceInfo: @retroactive CustomStringConvertible, @retroactive Equatable { }

public extension BLFontFaceInfo {
    var description: String {
        "BLFontFaceInfo(faceType: \(faceType), outlineType: \(outlineType), reserved8: \(reserved8), glyphCount: \(glyphCount), revision: \(revision), faceIndex: \(faceIndex), faceFlags: \(faceFlags), diagFlags: \(diagFlags), reserved: \(reserved))"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.faceType == rhs.faceType && lhs.outlineType == rhs.outlineType && lhs.reserved8 == rhs.reserved8 && lhs.glyphCount == rhs.glyphCount && lhs.revision == rhs.revision && lhs.faceIndex == rhs.faceIndex && lhs.faceFlags == rhs.faceFlags && lhs.diagFlags == rhs.diagFlags && lhs.reserved == rhs.reserved
    }
}
