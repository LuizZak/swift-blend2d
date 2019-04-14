/// Specifies the ownership relationship between a Swift wrapper class and its
/// backing pointer value.
///
/// - owner: The class created the pointer it contains. It should invoke the
/// structure's deinitializer once it deinitializes itself.
/// - borrowed: The class has borrowed its pointer from an existing pointer. The
/// class should not invoke the deinitializer for the structure after being
/// deinitialized itself.
enum PointerOwnership {
    case owner
    case borrowed
}
