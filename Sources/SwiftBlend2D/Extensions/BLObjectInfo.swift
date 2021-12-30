import blend2d

extension BLObjectInfo {
    func sso() -> Bool {
        (bits & UInt32(BL_OBJECT_INFO_DYNAMIC_FLAG.rawValue)) == 0
    }

    func dynamicFlag() -> Bool {
        (bits & UInt32(BL_OBJECT_INFO_DYNAMIC_FLAG.rawValue)) != 0
    }
}
