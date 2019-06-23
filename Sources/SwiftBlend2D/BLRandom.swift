import blend2d

public extension BLRandom {
    init(seed: UInt64) {
        self.init()
        reset(seed: seed)
    }
    
    /// Resets the random number generator to the given `seed`.
    mutating func reset(seed: UInt64 = 0) {
        blRandomReset(&self, seed)
    }
    
    /// Tests whether the random number generator is equivalent to `other`.
    func equals(_ other: BLRandom) -> Bool {
        return data == other.data
    }
    
    /// Returns the next `UInt64` value.
    mutating func nextUInt64() -> UInt64 {
        return blRandomNextUInt64(&self)
    }
    
    /// Returns the next `UInt32` value.
    mutating func nextUInt32() -> UInt32 {
        return blRandomNextUInt32(&self)
    }
    
    /// Returns the next `Double` precision floating point in [0..1) range.
    mutating func nextDouble() -> Double {
        return blRandomNextDouble(&self)
    }
}

extension BLRandom: Equatable {
    public static func ==(lhs: BLRandom, rhs: BLRandom) -> Bool {
        return lhs.equals(rhs)
    }
}
