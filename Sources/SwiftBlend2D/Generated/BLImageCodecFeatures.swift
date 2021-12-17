// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Image codec feature bits.
extension BLImageCodecFeatures: OptionSet { }

public extension BLImageCodecFeatures {
    /// No features.
    static let noFeatures = BL_IMAGE_CODEC_NO_FEATURES
    
    /// Image codec supports reading images (can create BLImageDecoder).
    static let read = BL_IMAGE_CODEC_FEATURE_READ
    
    /// Image codec supports writing images (can create BLImageEncoder).
    static let write = BL_IMAGE_CODEC_FEATURE_WRITE
    
    /// Image codec supports lossless compression.
    static let lossless = BL_IMAGE_CODEC_FEATURE_LOSSLESS
    
    /// Image codec supports loosy compression.
    static let lossy = BL_IMAGE_CODEC_FEATURE_LOSSY
    
    /// Image codec supports writing multiple frames (GIF).
    static let multiFrame = BL_IMAGE_CODEC_FEATURE_MULTI_FRAME
    
    /// Image codec supports IPTC metadata.
    static let iptc = BL_IMAGE_CODEC_FEATURE_IPTC
    
    /// Image codec supports EXIF metadata.
    static let exif = BL_IMAGE_CODEC_FEATURE_EXIF
    
    /// Image codec supports XMP metadata.
    static let xmp = BL_IMAGE_CODEC_FEATURE_XMP
}