import blend2d

public extension BLRuntimeSystemInfo {
    /// Gets the runtime build info for the syttem information
    static var current: BLRuntimeSystemInfo = {
        var info = BLRuntimeSystemInfo()
        blRuntimeQueryInfo(BLRuntimeInfoType.system.rawValue, &info)
        
        return info
    }()
}
