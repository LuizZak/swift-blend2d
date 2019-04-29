import blend2d

public extension BLApproximationOptions {
    /// Default approximation options used by Blend2D.
    static let `default` = blDefaultApproximationOptions
    
    /// Preferred initializer for `BLApproximationOptions` in Swift, fills in
    /// omitted parameters with values from `BLApproximationOptions.default`.
    init(flattenMode: BLFlattenMode /* Not omitted so that we avoid empty initializers being ambiguous at call sites */,
         offsetMode: BLOffsetMode = BLOffsetMode(UInt32(BLApproximationOptions.default.offsetMode)),
         flattenTolerance: Double = BLApproximationOptions.default.flattenTolerance,
         simplifyTolerance: Double = BLApproximationOptions.default.simplifyTolerance,
         offsetParameter: Double = BLApproximationOptions.default.offsetParameter) {
        
        self.init(flattenMode: UInt8(flattenMode.rawValue),
                  offsetMode: UInt8(offsetMode.rawValue),
                  reservedFlags: (0, 0, 0, 0, 0, 0),
                  flattenTolerance: flattenTolerance,
                  simplifyTolerance: simplifyTolerance,
                  offsetParameter: offsetParameter)
    }
}
