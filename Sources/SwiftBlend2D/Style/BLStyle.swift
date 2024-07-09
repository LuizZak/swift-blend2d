import blend2d

/// Holds either RGBA color in floating point format or other style object like
/// `BLPattern` or `BLGradient`.
public enum BLStyle {
    /// A gradient pattern style.
    case gradient(BLGradient)

    /// An image pattern style.
    case pattern(BLPattern)

    /// A solid color style.
    case rgba(BLRgba)
}
