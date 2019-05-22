import blend2d

/// A layout-compatible Swift version of Blend2D's `BLArrayView<T>`
@usableFromInline
struct BLArrayView<T> {
    @usableFromInline
    var data: UnsafePointer<T>?
    @usableFromInline
    var size: Int
}

extension BLArrayView: Sequence {
    @usableFromInline
    __consuming func makeIterator() -> AnyIterator<T> {
        var index = 0
        return AnyIterator {
            if index >= self.size {
                return nil
            }
            defer {
                index += 1
            }

            return self.data?[index]
        }
    }
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
