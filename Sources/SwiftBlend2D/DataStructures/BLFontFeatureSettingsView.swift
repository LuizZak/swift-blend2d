import blend2d

extension BLFontFeatureSettingsView {
    @usableFromInline
    __consuming func makeIterator() -> AnyIterator<BLFontFeatureItem> {
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
