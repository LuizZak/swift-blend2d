import blend2d

public extension BLApproximationOptions {
    /// Default approximation options used by Blend2D.
    static let `default` = bl_default_approximation_options

    /// Preferred initializer for `BLApproximationOptions` in Swift, fills in
    /// omitted parameters with values from `BLApproximationOptions.default`.
    init(
        flattenMode: BLFlattenMode /* Not omitted so that we avoid empty initializers being ambiguous at call sites */,
        offsetMode: BLOffsetMode = BLOffsetMode(BLOffsetMode.RawValue(BLApproximationOptions.default.offset_mode)),
        flattenTolerance: Double = BLApproximationOptions.default.flatten_tolerance,
        simplifyTolerance: Double = BLApproximationOptions.default.simplify_tolerance,
        offsetParameter: Double = BLApproximationOptions.default.offset_parameter
    ) {

        self.init(
            flatten_mode: UInt8(flattenMode.rawValue),
            offset_mode: UInt8(offsetMode.rawValue),
            reserved_flags: (0, 0, 0, 0, 0, 0),
            flatten_tolerance: flattenTolerance,
            simplify_tolerance: simplifyTolerance,
            offset_parameter: offsetParameter
        )
    }
}
