extension UInt32 {
    func toUInt32() -> UInt32 {
        return self
    }
}

extension Int32 {
    func toUInt32() -> UInt32 {
        return UInt32(bitPattern: self)
    }
}
