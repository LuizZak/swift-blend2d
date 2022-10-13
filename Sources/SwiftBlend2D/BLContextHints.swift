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
                    renderingQuality: UInt8(renderingQuality.rawValue),
                    gradientQuality: UInt8(gradientQuality.rawValue),
                    patternQuality: UInt8(patternQuality.rawValue)
                )
            )
        )
    }
}
