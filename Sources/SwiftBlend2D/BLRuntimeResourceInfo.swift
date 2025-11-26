import blend2d

public extension BLRuntimeResourceInfo {
    /// Gets the runtime build info for the resource information
    static var current: BLRuntimeResourceInfo = {
        var info = BLRuntimeResourceInfo()
        bl_runtime_query_info(BLRuntimeInfoType.resource, &info)

        return info
    }()
}
