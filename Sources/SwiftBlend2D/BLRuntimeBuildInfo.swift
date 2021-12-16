import blend2d

public extension BLRuntimeBuildInfo {
    /// Gets the runtime build info for the underlying Blend2D build
    static var current: BLRuntimeBuildInfo = {
        var info = BLRuntimeBuildInfo()
        blRuntimeQueryInfo(BLRuntimeInfoType.build, &info)
        
        return info
    }()
}
