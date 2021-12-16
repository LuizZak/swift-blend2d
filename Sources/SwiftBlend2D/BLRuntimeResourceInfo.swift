import blend2d

public extension BLRuntimeResourceInfo {
    /// Gets the runtime build info for the resource information
    static var current: BLRuntimeResourceInfo = {
        var info = BLRuntimeResourceInfo()
        blRuntimeQueryInfo(BLRuntimeInfoType.resource, &info)
        
        return info
    }()
}
