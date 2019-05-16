import blend2d

public extension BLLinearGradientValues {
    init(box: BLBox) {
        self.init(x0: box.x0, y0: box.y0, x1: box.x1, y1: box.y1)
    }
}
