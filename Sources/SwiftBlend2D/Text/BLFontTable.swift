import blend2d

public extension BLFontTable {
    /// Executes a closure passing a buffer pointer to the stored data in this
    /// `BLFontTable` as a read-only buffer pointer.
    ///
    /// Returns the result of the closure.
    ///
    /// The buffer pointer value is short-lived and should not be stored or used
    /// beyond the duration of the closure's execution.
    @inlinable
    func withBufferPointer<T>(_ closure: (UnsafeBufferPointer<UInt8>) throws -> T) rethrows -> T {
        let buffer = UnsafeBufferPointer(start: data, count: size / MemoryLayout<UInt8>.stride)
        return try closure(buffer)
    }
}
