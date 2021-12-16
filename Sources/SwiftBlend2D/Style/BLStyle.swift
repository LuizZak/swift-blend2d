import blend2d

/// Holds either RGBA color in floating point format or other style object like
/// `BLPattern` or `BLGradient`.
public enum BLStyle {
    case gradient(BLGradient)
    case pattern(BLPattern)
    case rgba(BLRgba)
}
