import blend2d

public extension BLGlyphRun {
    var isEmpty: Bool {
        size == 0
    }
}

/// A helper to iterate over a `BLGlyphRun`.
///
/// Takes into consideration glyph-id advance and glyph-offset advance.
///
/// Example:
///
/// ```
/// func inspectGlyphRun(_ glyphRun: BLGlyphRun) {
///     var it = BLGlyphRunIterator(glyphRun: self)
///     if it.hasPlacement {
///         while !it.atEnd {
///             let glyphId = it.glyphId()
///             let offset = it.placement(as: BLPoint.self)
///
///             // Do something with `glyphId` and `offset`.
///
///             it.advance()
///         }
///     } else {
///         while !it.atEnd {
///             let glyphId = it.glyphId()
///
///             // Do something with `glyphId`.
///
///             it.advance()
///         }
///     }
/// }
/// ```
public struct BLGlyphRunIterator {
    public private(set) var index: Int
    public private(set) var size: Int
    var glyphData: UnsafeMutableRawPointer?
    var placementDataPointer: UnsafeMutableRawPointer?
    var glyphAdvance: Int
    var placementAdvance: Int
    
    var glyphRun: BLGlyphRun
    
    public var atEnd: Bool {
        index >= size
    }
    
    public var hasPlacement: Bool {
        placementDataPointer != nil
    }

    /// Placement data that depends on the stored placement data on the currently
    /// iterating `BLGlyphRun`
    public var placementData: PlacementData {
        guard let pointer = placementDataPointer else {
            return .none
        }
        
        switch BLGlyphPlacementType(BLGlyphPlacementType.RawValue(glyphRun.placementType)) {
        case .none:
            return .none
        case .advanceOffset:
            return .advanceOffset(pointer.load(as: BLGlyphPlacement.self))
        case .designUnits:
            return .designUnits(pointer.load(as: BLPoint.self))
        case .userUnits:
            return .userUnits(pointer.load(as: BLPoint.self))
        case .absoluteUnits:
            return .absoluteUnits(pointer.load(as: BLPoint.self))
        default:
            return .none
        }
    }
    
    public init(glyphRun: BLGlyphRun) {
        index = 0
        size = glyphRun.size
        glyphData = glyphRun.glyphData
        placementDataPointer = glyphRun.placementData
        glyphAdvance = Int(glyphRun.glyphAdvance)
        placementAdvance = Int(glyphRun.placementAdvance)
        
        self.glyphRun = glyphRun
    }
    
    public func glyphId() -> UInt32? {
        glyphData?.load(as: UInt32.self)
    }
    
    public func placement<T>(as type: T.Type) -> T? {
        placementDataPointer?.load(as: type)
    }
    
    public mutating func advance() {
        if atEnd {
            return
        }
        
        index += 1
        glyphData = glyphData.map { $0 + glyphAdvance }
        placementDataPointer = placementDataPointer.map { $0 + placementAdvance }
    }

    public enum PlacementData {
        case none
        case advanceOffset(BLGlyphPlacement)
        case designUnits(BLPoint)
        case userUnits(BLPoint)
        case absoluteUnits(BLPoint)
    }
}
