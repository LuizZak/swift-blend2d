import blend2d

/// Creates a pointer reference to a given value and invokes a given closure
/// with, passing a nil pointer, in case 'value' itself is nil.
///
/// Used to provide nullable pointers to C functions that use them as 'nullable
/// struct references'.
@inlinable
func withUnsafeNullablePointer<T, Result>(to value: T?, _ closure: (UnsafePointer<T>?) -> Result) -> Result {
    _withUnsafeNullablePointer(to: value, closure)
}

@inlinable
@discardableResult
func withUnsafeNullablePointer<T>(to value: T?, _ closure: (UnsafePointer<T>?) -> BLResult) -> BLResult {
    _withUnsafeNullablePointer(to: value, closure)
}

// Used to allow defining two signatures for withUnsafeNullablePointer, one with
// `BLResult` being a discardable result
@inlinable
func _withUnsafeNullablePointer<T, Result>(to value: T?, _ closure: (UnsafePointer<T>?) -> Result) -> Result {
    if let value = value {
        return withUnsafePointer(to: value) { pointer in
            closure(pointer)
        }
    } else {
        return closure(nil)
    }
}
