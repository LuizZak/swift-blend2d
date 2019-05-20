import blend2d

/// A layout-compatible Swift version of Blend2D's `BLArrayView<T>`
@usableFromInline
struct BLArrayView<T> {
    var data: UnsafePointer<T>?
    var size: Int
}

extension Array {
    /// Executes a closure passing in a context for a temporary BLArrayView that
    /// can be provided for Blend2D methods that accept a pair of (void*, size_t)
    /// values for representing Blend2D arrays of `BLArrayElement` elements.
    ///
    /// Returns the result from the closure invocation, or any error thrown by
    /// the closure during the execution of this method.
    ///
    /// The pointer value is short-lived and should not be stored or used beyond
    /// the duration of the closure's execution.
    @usableFromInline
    func withTemporaryView<T>(_ closure: (UnsafePointer<BLArrayView<Element>>) throws -> T) rethrows -> T {
        return try withUnsafeBufferPointer { pointer -> T in
            var view = BLArrayView(data: pointer.baseAddress,
                                   size: pointer.count)
            
            return try closure(&view)
        }
    }
}
