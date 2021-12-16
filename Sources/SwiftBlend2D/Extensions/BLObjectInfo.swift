import blend2d

extension BLObjectInfo {
    func sso() -> Bool {
        (bits & UInt32(BLObjectInfoBits.dynamicFlag.rawValue)) == 0
    }

    func dynamicFlag() -> Bool {
        (bits & UInt32(BLObjectInfoBits.dynamicFlag.rawValue)) != 0
    }
}
