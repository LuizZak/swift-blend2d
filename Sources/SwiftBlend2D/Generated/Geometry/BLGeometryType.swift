// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Geometry type.
/// 
/// Geometry describes a shape or path that can be either rendered or added to a BLPath container. Both `BLPath`
/// and `BLContext` provide functionality to work with all geometry types. Please note that each type provided
/// here requires to pass a matching struct or class to the function that consumes a `geometryType` and `geometryData`
/// arguments.
/// 
/// \cond INTERNAL
/// - note: Always modify `BLGeometryType.simpleLast` and related functions when adding a new type to `BLGeometryType`
/// enum. Some functions just pass the geometry type and data to another function, but the rendering context must copy
/// simple types to a render job, which means that it must know which type is simple and also sizes of all simple
/// types, see `geometry_p.h` for more details about handling simple types.
/// \endcond
public extension BLGeometryType {
    /// No geometry provided.
    static let none = BL_GEOMETRY_TYPE_NONE
    
    /// BLBoxI struct.
    static let boxI = BL_GEOMETRY_TYPE_BOXI
    
    /// BLBox struct.
    static let boxD = BL_GEOMETRY_TYPE_BOXD
    
    /// BLRectI struct.
    static let rectI = BL_GEOMETRY_TYPE_RECTI
    
    /// BLRect struct.
    static let rectD = BL_GEOMETRY_TYPE_RECTD
    
    /// BLCircle struct.
    static let circle = BL_GEOMETRY_TYPE_CIRCLE
    
    /// BLEllipse struct.
    static let ellipse = BL_GEOMETRY_TYPE_ELLIPSE
    
    /// BLRoundRect struct.
    static let roundRect = BL_GEOMETRY_TYPE_ROUND_RECT
    
    /// BLArc struct.
    static let arc = BL_GEOMETRY_TYPE_ARC
    
    /// BLArc struct representing chord.
    static let chord = BL_GEOMETRY_TYPE_CHORD
    
    /// BLArc struct representing pie.
    static let pie = BL_GEOMETRY_TYPE_PIE
    
    /// BLLine struct.
    static let line = BL_GEOMETRY_TYPE_LINE
    
    /// BLTriangle struct.
    static let triangle = BL_GEOMETRY_TYPE_TRIANGLE
    
    /// BLArrayView<BLPointI> representing a polyline.
    static let polylineI = BL_GEOMETRY_TYPE_POLYLINEI
    
    /// BLArrayView<BLPoint> representing a polyline.
    static let polylineD = BL_GEOMETRY_TYPE_POLYLINED
    
    /// BLArrayView<BLPointI> representing a polygon.
    static let polygonI = BL_GEOMETRY_TYPE_POLYGONI
    
    /// BLArrayView<BLPoint> representing a polygon.
    static let polygonD = BL_GEOMETRY_TYPE_POLYGOND
    
    /// BLArrayView<BLBoxI> struct.
    static let arrayViewBoxI = BL_GEOMETRY_TYPE_ARRAY_VIEW_BOXI
    
    /// BLArrayView<BLBox> struct.
    static let arrayViewBoxD = BL_GEOMETRY_TYPE_ARRAY_VIEW_BOXD
    
    /// BLArrayView<BLRectI> struct.
    static let arrayViewRectI = BL_GEOMETRY_TYPE_ARRAY_VIEW_RECTI
    
    /// BLArrayView<BLRect> struct.
    static let arrayViewRectD = BL_GEOMETRY_TYPE_ARRAY_VIEW_RECTD
    
    /// BLPath (or BLPathCore).
    static let path = BL_GEOMETRY_TYPE_PATH
    
    /// Maximum value of `BLGeometryType`.
    static let maxValue = BL_GEOMETRY_TYPE_MAX_VALUE
    
    /// The last simple type.
    static let simpleLast = BL_GEOMETRY_TYPE_SIMPLE_LAST
}
