import blend2d

public extension BLRectI {
    @inlinable
    var topLeft: BLPointI {
        return BLPointI(x: x, y: y)
    }

    @inlinable
    var topRight: BLPointI {
        return BLPointI(x: x + w, y: y)
    }

    @inlinable
    var bottomLeft: BLPointI {
        return BLPointI(x: x, y: y + h)
    }

    @inlinable
    var bottomRight: BLPointI {
        return BLPointI(x: x + w, y: y + h)
    }

    @inlinable
    var left: Int {
        return Int(x)
    }

    @inlinable
    var right: Int {
        return Int(x + w)
    }

    @inlinable
    var top: Int {
        return Int(y)
    }

    @inlinable
    var bottom: Int {
        return Int(y + h)
    }

    @inlinable
    var center: BLPointI {
        get {
            return BLPointI(x: x + w / 2, y: y + h / 2)
        }
        set {
            (x, y) = (newValue.x - w / 2, newValue.y - h / 2)
        }
    }

    @inlinable
    var size: BLSizeI {
        get {
            return BLSizeI(w: w, h: h)
        }
        set {
            (w, h) = (newValue.w, newValue.h)
        }
    }

    @inlinable
    func insetBy(x: Int, y: Int) -> BLRectI {
        return BLRectI(x: self.x + Int32(x) / 2, y: self.y + Int32(y) / 2, w: w - Int32(x), h: h - Int32(y))
    }
}

extension BLRectI: Equatable {
    @inlinable
    public static func ==(lhs: BLRectI, rhs: BLRectI) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.w == rhs.w
            && lhs.h == rhs.h
    }
}
