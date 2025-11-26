import blend2d

public extension BLRuntimeSystemInfo {
    /// Gets the runtime build info for the system information
    static var current: BLRuntimeSystemInfo = {
        var info = BLRuntimeSystemInfo()
        bl_runtime_query_info(BLRuntimeInfoType.system, &info)

        return info
    }()
}
