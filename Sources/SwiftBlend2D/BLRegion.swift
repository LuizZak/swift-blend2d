import blend2d

/// Region is a set of rectangles sorted and coalesced by their Y/X coordinates.
public struct BLRegion {
    @usableFromInline
    var box: BLBaseClass<BLRegionCore>
    
    /// Returns the type of the region, see `BLRegionType`.
    @inlinable
    public var type: BLRegionType {
        return BLRegionType(blRegionGetType(&box.object))
    }
    
    /// Gets whether the region is empty.
    @inlinable
    public var isEmpty: Bool { return size == 0 }
    /// Gets whether the region is one rectangle.
    @inlinable
    public var isRectangle: Bool { return size == 1 }
    /// Gets whether the region is complex.
    @inlinable
    public var isComplex: Bool { return size > 1 }
    
    /// Returns the region size.
    @inlinable
    public var size: Int { return box.object.impl.pointee.size }
    /// Returns the region capacity.
    @inlinable
    public var capacity: Int { return box.object.impl.pointee.capacity }
    /// Returns the region's bounding box.
    @inlinable
    public var boundingBox: BLBoxI { return box.object.impl.pointee.boundingBox }
    
    public init() {
        box = BLBaseClass()
    }
    
    public init(box: BLBoxI) {
        self.box = BLBaseClass { pointer in
            blRegionInit(pointer)
            
            return withUnsafePointer(to: box) { box in
                blRegionAssignBoxI(pointer, box)
            }
        }
    }
    
    public init(boxes: [BLBoxI]) {
        box = BLBaseClass { pointer in
            blRegionInit(pointer)
            
            return boxes.withUnsafeBufferPointer { boxes in
                if let baseAddress = boxes.baseAddress {
                    return blRegionAssignBoxIArray(pointer, baseAddress, boxes.count)
                }
                return BLResult(BL_SUCCESS.rawValue)
            }
        }
    }
    
    public init(rectangle: BLRectI) {
        self.box = BLBaseClass { pointer in
            blRegionInit(pointer)
            
            return withUnsafePointer(to: rectangle) { rectangle in
                blRegionAssignRectI(pointer, rectangle)
            }
        }
    }
    
    public init(rectangles: [BLRectI]) {
        box = BLBaseClass { pointer in
            blRegionInit(pointer)
            
            return rectangles.withUnsafeBufferPointer { rectangles in
                if let baseAddress = rectangles.baseAddress {
                    return blRegionAssignRectIArray(pointer, baseAddress, rectangles.count)
                }
                return BLResult(BL_SUCCESS.rawValue)
            }
        }
    }
    
    @inlinable
    mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&box) {
            box = box.copy()
        }
    }
    
    public mutating func clear() {
        ensureUnique()
        
        blRegionClear(&box.object)
    }
    
    public mutating func shrink() {
        ensureUnique()
        
        blRegionShrink(&box.object)
    }

    @inlinable
    @discardableResult
    public mutating func reserve(capacity: Int) -> BLResult {
        ensureUnique()
        
        return blRegionReserve(&box.object, capacity)
    }

    @inlinable
    public mutating func combine(region: BLRegion, operation: BLBooleanOp) -> BLResult {
        ensureUnique()
        
        return blRegionCombine(&box.object, &box.object, &region.box.object, operation.rawValue)
    }

    @inlinable
    public mutating func combine(box: BLBoxI, operation: BLBooleanOp) -> BLResult {
        ensureUnique()
        
        var box = box
        return blRegionCombineRB(&self.box.object, &self.box.object, &box, operation.rawValue)
    }
    
    /// Translates the region by the given point `pt`.
    ///
    /// Possible overflow will be handled by clipping to a maximum region boundary,
    /// so the final region could be smaller than the region before translation.
    @inlinable
    @discardableResult
    public mutating func translate(_ pt: BLPointI) -> BLResult {
        ensureUnique()
        
        var pt = pt
        return blRegionTranslate(&box.object, &box.object, &pt)
    }
    
    /// Translates the region by the given point `point` and clip it to the given
    /// `clipBox`.
    @inlinable
    @discardableResult
    public mutating func translateAndClip(point: BLPointI, clipBox: BLBoxI) -> BLResult {
        ensureUnique()
        
        var point = point
        var clipBox = clipBox
        return blRegionTranslateAndClip(&box.object, &box.object, &point, &clipBox)
    }
    
    /// Translates the region with `region` and clip it to the given `clipBox`.
    @inlinable
    @discardableResult
    public mutating func intersectAndClip(region: BLRegion, clipBox: BLBoxI) -> BLResult {
        ensureUnique()
        
        var clipBox = clipBox
        return blRegionIntersectAndClip(&box.object, &box.object, &region.box.object, &clipBox)
    }

    @inlinable
    @discardableResult
    public mutating func combine(_ a: BLRegion, _ b: BLRegion, operation: BLBooleanOp) -> BLResult {
        ensureUnique()
        
        return blRegionCombine(&box.object, &a.box.object, &b.box.object, operation.rawValue)
    }
    
    @inlinable
    @discardableResult
    public mutating func combine(_ a: BLRegion, _ b: BLBoxI, operation: BLBooleanOp) -> BLResult {
        ensureUnique()
        
        var b = b
        return blRegionCombineRB(&box.object, &a.box.object, &b, operation.rawValue)
    }
    
    @inlinable
    @discardableResult
    public mutating func combine(_ a: BLBoxI, _ b: BLRegion, operation: BLBooleanOp) -> BLResult {
        ensureUnique()
        
        var a = a
        return blRegionCombineBR(&box.object, &a, &b.box.object, operation.rawValue)
    }
    
    @inlinable
    @discardableResult
    public mutating func combine(_ a: BLBoxI, _ b: BLBoxI, operation: BLBooleanOp) -> BLResult {
        ensureUnique()
        
        var a = a
        var b = b
        return blRegionCombineBB(&box.object, &a, &b, operation.rawValue)
    }
    
    /// Tests if a given point `pt` is in region.
    @inlinable
    public func hitTest(_ pt: BLPointI) -> BLHitTest {
        var pt = pt
        return BLHitTest(blRegionHitTest(&self.box.object, &pt))
    }
    /// Tests if a given `box` is in region.
    @inlinable
    public func hitTest(_ box: BLBoxI) -> BLHitTest {
        var box = box
        return BLHitTest(blRegionHitTestBoxI(&self.box.object, &box))
    }
}

extension BLRegion: Equatable {
    public static func ==(lhs: BLRegion, rhs: BLRegion) -> Bool {
        return blRegionEquals(&lhs.box.object, &rhs.box.object)
    }
}

extension BLRegionCore: CoreStructure {
    public static var initializer = blRegionInit
    public static var deinitializer = blRegionReset
    public static var assignWeak = blRegionAssignWeak
}
