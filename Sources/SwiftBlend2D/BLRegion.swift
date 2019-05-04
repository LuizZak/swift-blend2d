import blend2d

public final class BLRegion: BLBaseClass<BLRegionCore> {
    
    /// Returns the type of the region, see `BLRegionType`.
    public var type: BLRegionType {
        return BLRegionType(blRegionGetType(&object))
    }
    
    /// Gets whether the region is empty.
    public var isEmpty: Bool { return size == 0 }
    /// Gets whether the region is one rectangle.
    public var isRectangle: Bool { return size == 1 }
    /// Gets whether the region is complex.
    public var isComplex: Bool { return size > 1 }
    
    /// Returns the region size.
    public var size: Int { return object.impl.pointee.size }
    /// Returns the region capacity.
    public var capacity: Int { return object.impl.pointee.capacity }
    /// Returns the region's bounding box.
    public var boundingBox: BLBoxI { return object.impl.pointee.boundingBox }
    
    public override init() {
        super.init()
    }
    
    public init(box: BLBoxI) {
        super.init()
        
        _ = withUnsafePointer(to: box) { pointer in
            blRegionAssignBoxI(&object, pointer)
        }
    }
    
    public init(boxes: [BLBoxI]) {
        super.init()
        
        boxes.withUnsafeBufferPointer { pointer in
            if let baseAddress = pointer.baseAddress {
                blRegionAssignBoxIArray(&object, baseAddress, pointer.count)
            }
        }
    }
    
    public init(rectangle: BLRectI) {
        super.init()
        
        _ = withUnsafePointer(to: rectangle) { pointer in
            blRegionAssignRectI(&object, pointer)
        }
    }
    
    public init(rectangles: [BLRectI]) {
        super.init()
        
        rectangles.withUnsafeBufferPointer { pointer in
            if let baseAddress = pointer.baseAddress {
                blRegionAssignRectIArray(&object, baseAddress, pointer.count)
            }
        }
    }
    
    public func clear() {
        blRegionClear(&object)
    }
    
    public func shrink() {
        blRegionShrink(&object)
    }
    
    @discardableResult
    public func reserve(capacity: Int) -> BLResult {
        return blRegionReserve(&object, capacity)
    }
    
    public func combine(region: BLRegion, operation: BLBooleanOp) -> BLResult {
        return blRegionCombine(&object, &object, &region.object, operation.rawValue)
    }
    public func combine(box: BLBoxI, operation: BLBooleanOp) -> BLResult {
        var box = box
        return blRegionCombineRB(&object, &object, &box, operation.rawValue)
    }
    
    /// Translates the region by the given point `pt`.
    ///
    /// Possible overflow will be handled by clipping to a maximum region boundary,
    /// so the final region could be smaller than the region before translation.
    @discardableResult
    public func translate(_ pt: BLPointI) -> BLResult {
        var pt = pt
        return blRegionTranslate(&object, &object, &pt)
    }
    
    /// Translates the region by the given point `point` and clip it to the given
    /// `clipBox`.
    @discardableResult
    public func translateAndClip(point: BLPointI, clipBox: BLBoxI) -> BLResult {
        var point = point
        var clipBox = clipBox
        return blRegionTranslateAndClip(&object, &object, &point, &clipBox)
    }
    
    /// Translates the region with `region` and clip it to the given `clipBox`.
    @discardableResult
    public func intersectAndClip(region: BLRegion, clipBox: BLBoxI) -> BLResult {
        var clipBox = clipBox
        return blRegionIntersectAndClip(&object, &object, &region.object, &clipBox)
    }
    
    @discardableResult
    public func combine(_ a: BLRegion, _ b: BLRegion, operation: BLBooleanOp) -> BLResult {
        return blRegionCombine(&object, &a.object, &b.object, operation.rawValue)
    }
    @discardableResult
    public func combine(_ a: BLRegion, _ b: BLBoxI, operation: BLBooleanOp) -> BLResult {
        var b = b
        return blRegionCombineRB(&object, &a.object, &b, operation.rawValue)
    }
    @discardableResult
    public func combine(_ a: BLBoxI, _ b: BLRegion, operation: BLBooleanOp) -> BLResult {
        var a = a
        return blRegionCombineBR(&object, &a, &b.object, operation.rawValue)
    }
    @discardableResult
    public func combine(_ a: BLBoxI, _ b: BLBoxI, operation: BLBooleanOp) -> BLResult {
        var a = a
        var b = b
        return blRegionCombineBB(&object, &a, &b, operation.rawValue)
    }
    
    /// Tests if a given point `pt` is in region.
    public func hitTest(_ pt: BLPointI) -> BLHitTest {
        var pt = pt
        return BLHitTest(blRegionHitTest(&object, &pt))
    }
    /// Tests if a given `box` is in region.
    public func hitTest(_ box: BLBoxI) -> BLHitTest {
        var box = box
        return BLHitTest(blRegionHitTestBoxI(&object, &box))
    }
}

extension BLRegion: Equatable {
    public static func ==(lhs: BLRegion, rhs: BLRegion) -> Bool {
        return blRegionEquals(&lhs.object, &rhs.object)
    }
}

extension BLRegionCore: CoreStructure {
    public static var initializer = blRegionInit
    public static var deinitializer = blRegionReset
}
