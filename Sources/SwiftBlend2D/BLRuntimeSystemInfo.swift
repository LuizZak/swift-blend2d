import blend2d

public extension BLRuntimeSystemInfo {
    /// Gets the runtime build info for the sytstem information
    static var current: BLRuntimeSystemInfo = {
        var info = BLRuntimeSystemInfo()
        blRuntimeQueryInfo(BLRuntimeInfoType.system.rawValue, &info)
        
        return info
    }()
}
