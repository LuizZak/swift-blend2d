import blend2d

public extension BLRuntimeMemoryInfo {
    /// Gets the runtime build info for the memory information
    static var current: BLRuntimeMemoryInfo = {
        var info = BLRuntimeMemoryInfo()
        blRuntimeQueryInfo(BLRuntimeInfoType.memory.rawValue, &info)
        
        return info
    }()
}
