import blend2d

public extension BLContextHints {
    @inlinable
    init(
        renderingQuality: BLRenderingQuality,
        gradientQuality: BLGradientQuality,
        patternQuality: BLPatternQuality
    ) {

        self.init(
            .init(
                .init(
                    rendering_quality: UInt8(renderingQuality.rawValue),
                    gradient_quality: UInt8(gradientQuality.rawValue),
                    pattern_quality: UInt8(patternQuality.rawValue)
                )
            )
        )
    }
}
