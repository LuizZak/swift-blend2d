@_exported import blend2d

public enum Blend2DStatics {
    @inlinable
    static var isLittleEndian: Bool {
        BL_BYTE_ORDER == 1234
    }
}
