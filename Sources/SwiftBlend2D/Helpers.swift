/// Creates a pointer reference to a given inout value, returning nil, in case
/// 'value' itself is nil.
///
/// Used to provide nullable pointers to C functions that use them as 'nullable
/// struct references'.
func makeNullablePointer<T>(_ value: inout T?) -> UnsafePointer<T>? {
    if var value = value {
        return UnsafePointer(&value)
    }
    
    return nil
}
