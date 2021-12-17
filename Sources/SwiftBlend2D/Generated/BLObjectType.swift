// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Object type identifier.
public extension BLObjectType {
    /// Object represents a RGBA value stored as 4 32-bit floating point components (can be used as style).
    static let rgba = BL_OBJECT_TYPE_RGBA
    
    /// Object is `Null` (can be used as style).
    static let null = BL_OBJECT_TYPE_NULL
    
    /// Object is `BLPattern` (style compatible).
    static let pattern = BL_OBJECT_TYPE_PATTERN
    
    /// Object is `BLGradient` (style compatible).
    static let gradient = BL_OBJECT_TYPE_GRADIENT
    
    /// Object is `BLImage`.
    static let image = BL_OBJECT_TYPE_IMAGE
    
    /// Object is `BLPath`.
    static let path = BL_OBJECT_TYPE_PATH
    
    /// Object is `BLFont`.
    static let font = BL_OBJECT_TYPE_FONT
    
    /// Object is `BLFontFeatureOptions`.
    static let fontFeatureOptions = BL_OBJECT_TYPE_FONT_FEATURE_OPTIONS
    
    /// Object is `BLFontVariationOptions`.
    static let fontVariationOptions = BL_OBJECT_TYPE_FONT_VARIATION_OPTIONS
    
    /// Object represents a boolean value.
    static let bool = BL_OBJECT_TYPE_BOOL
    
    /// Object represents a 64-bit signed integer value.
    static let int64 = BL_OBJECT_TYPE_INT64
    
    /// Object represents a 64-bit unsigned integer value.
    static let uint64 = BL_OBJECT_TYPE_UINT64
    
    /// Object represents a 64-bit floating point value.
    static let double = BL_OBJECT_TYPE_DOUBLE
    
    /// Object is `BLString`.
    static let string = BL_OBJECT_TYPE_STRING
    
    /// Object is `BLArray<T>` where `T` is a `BLObject` compatible type.
    static let arrayObject = BL_OBJECT_TYPE_ARRAY_OBJECT
    
    /// Object is `BLArray<T>` where `T` matches 8-bit signed integral type.
    static let arrayInt8 = BL_OBJECT_TYPE_ARRAY_INT8
    
    /// Object is `BLArray<T>` where `T` matches 8-bit unsigned integral type.
    static let arrayUInt8 = BL_OBJECT_TYPE_ARRAY_UINT8
    
    /// Object is `BLArray<T>` where `T` matches 16-bit signed integral type.
    static let arrayInt16 = BL_OBJECT_TYPE_ARRAY_INT16
    
    /// Object is `BLArray<T>` where `T` matches 16-bit unsigned integral type.
    static let arrayUInt16 = BL_OBJECT_TYPE_ARRAY_UINT16
    
    /// Object is `BLArray<T>` where `T` matches 32-bit signed integral type.
    static let arrayInt32 = BL_OBJECT_TYPE_ARRAY_INT32
    
    /// Object is `BLArray<T>` where `T` matches 32-bit unsigned integral type.
    static let arrayUInt32 = BL_OBJECT_TYPE_ARRAY_UINT32
    
    /// Object is `BLArray<T>` where `T` matches 64-bit signed integral type.
    static let arrayInt64 = BL_OBJECT_TYPE_ARRAY_INT64
    
    /// Object is `BLArray<T>` where `T` matches 64-bit unsigned integral type.
    static let arrayUInt64 = BL_OBJECT_TYPE_ARRAY_UINT64
    
    /// Object is `BLArray<T>` where `T` matches 32-bit floating point type.
    static let arrayFloat32 = BL_OBJECT_TYPE_ARRAY_FLOAT32
    
    /// Object is `BLArray<T>` where `T` matches 64-bit floating point type.
    static let arrayFloat64 = BL_OBJECT_TYPE_ARRAY_FLOAT64
    
    /// Object is `BLArray<T>` where `T` is a struct of size 1.
    static let arrayStruct1 = BL_OBJECT_TYPE_ARRAY_STRUCT_1
    
    /// Object is `BLArray<T>` where `T` is a struct of size 2.
    static let arrayStruct2 = BL_OBJECT_TYPE_ARRAY_STRUCT_2
    
    /// Object is `BLArray<T>` where `T` is a struct of size 3.
    static let arrayStruct3 = BL_OBJECT_TYPE_ARRAY_STRUCT_3
    
    /// Object is `BLArray<T>` where `T` is a struct of size 4.
    static let arrayStruct4 = BL_OBJECT_TYPE_ARRAY_STRUCT_4
    
    /// Object is `BLArray<T>` where `T` is a struct of size 6.
    static let arrayStruct6 = BL_OBJECT_TYPE_ARRAY_STRUCT_6
    
    /// Object is `BLArray<T>` where `T` is a struct of size 8.
    static let arrayStruct8 = BL_OBJECT_TYPE_ARRAY_STRUCT_8
    
    /// Object is `BLArray<T>` where `T` is a struct of size 10.
    static let arrayStruct10 = BL_OBJECT_TYPE_ARRAY_STRUCT_10
    
    /// Object is `BLArray<T>` where `T` is a struct of size 12.
    static let arrayStruct12 = BL_OBJECT_TYPE_ARRAY_STRUCT_12
    
    /// Object is `BLArray<T>` where `T` is a struct of size 16.
    static let arrayStruct16 = BL_OBJECT_TYPE_ARRAY_STRUCT_16
    
    /// Object is `BLArray<T>` where `T` is a struct of size 20.
    static let arrayStruct20 = BL_OBJECT_TYPE_ARRAY_STRUCT_20
    
    /// Object is `BLArray<T>` where `T` is a struct of size 24.
    static let arrayStruct24 = BL_OBJECT_TYPE_ARRAY_STRUCT_24
    
    /// Object is `BLArray<T>` where `T` is a struct of size 32.
    static let arrayStruct32 = BL_OBJECT_TYPE_ARRAY_STRUCT_32
    
    /// Object is `BLContext`.
    static let context = BL_OBJECT_TYPE_CONTEXT
    
    /// Object is `BLImageCodec`.
    static let imageCodec = BL_OBJECT_TYPE_IMAGE_CODEC
    
    /// Object is `BLImageDecoder`.
    static let imageDecoder = BL_OBJECT_TYPE_IMAGE_DECODER
    
    /// Object is `BLImageEncoder`.
    static let imageEncoder = BL_OBJECT_TYPE_IMAGE_ENCODER
    
    /// Object is `BLFontFace`.
    static let fontFace = BL_OBJECT_TYPE_FONT_FACE
    
    /// Object is `BLFontData`.
    static let fontData = BL_OBJECT_TYPE_FONT_DATA
    
    /// Object is `BLFontManager`.
    static let fontManager = BL_OBJECT_TYPE_FONT_MANAGER
    
    /// Object is `BLBitSet`.
    static let bitSet = BL_OBJECT_TYPE_BIT_SET
    
    static let arrayFirst = BL_OBJECT_TYPE_ARRAY_FIRST
    
    static let arrayLast = BL_OBJECT_TYPE_ARRAY_LAST
    
    /// Maximum object type identifier that can be used as a style.
    static let maxStyleValue = BL_OBJECT_TYPE_MAX_STYLE_VALUE
    
    /// Count of type identifiers including all reserved ones.
    static let maxValue = BL_OBJECT_TYPE_MAX_VALUE
}