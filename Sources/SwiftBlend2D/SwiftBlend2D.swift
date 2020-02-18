@_exported import blend2d

public enum Blend2DStatics {
    @inlinable
    static var isLittleEndian: Bool {
        return BL_BYTE_ORDER == 1234
    }
}
