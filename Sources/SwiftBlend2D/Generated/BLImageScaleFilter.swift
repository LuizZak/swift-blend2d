// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Filter type used by `BLImage::scale()`.
public extension BLImageScaleFilter {
    /// No filter or uninitialized.
    static let none = BL_IMAGE_SCALE_FILTER_NONE
    
    /// Nearest neighbor filter (radius 1.0).
    static let nearest = BL_IMAGE_SCALE_FILTER_NEAREST
    
    /// Bilinear filter (radius 1.0).
    static let bilinear = BL_IMAGE_SCALE_FILTER_BILINEAR
    
    /// Bicubic filter (radius 2.0).
    static let bicubic = BL_IMAGE_SCALE_FILTER_BICUBIC
    
    /// Bell filter (radius 1.5).
    static let bell = BL_IMAGE_SCALE_FILTER_BELL
    
    /// Gauss filter (radius 2.0).
    static let gauss = BL_IMAGE_SCALE_FILTER_GAUSS
    
    /// Hermite filter (radius 1.0).
    static let hermite = BL_IMAGE_SCALE_FILTER_HERMITE
    
    /// Hanning filter (radius 1.0).
    static let hanning = BL_IMAGE_SCALE_FILTER_HANNING
    
    /// Catrom filter (radius 2.0).
    static let catrom = BL_IMAGE_SCALE_FILTER_CATROM
    
    /// Bessel filter (radius 3.2383).
    static let bessel = BL_IMAGE_SCALE_FILTER_BESSEL
    
    /// Sinc filter (radius 2.0, adjustable through `BLImageScaleOptions`).
    static let sinc = BL_IMAGE_SCALE_FILTER_SINC
    
    /// Lanczos filter (radius 2.0, adjustable through `BLImageScaleOptions`).
    static let lanczos = BL_IMAGE_SCALE_FILTER_LANCZOS
    
    /// Blackman filter (radius 2.0, adjustable through `BLImageScaleOptions`).
    static let blackman = BL_IMAGE_SCALE_FILTER_BLACKMAN
    
    /// Mitchell filter (radius 2.0, parameters 'b' and 'c' passed through `BLImageScaleOptions`).
    static let mitchell = BL_IMAGE_SCALE_FILTER_MITCHELL
    
    /// Filter using a user-function, must be passed through `BLImageScaleOptions`.
    static let user = BL_IMAGE_SCALE_FILTER_USER
    
    /// Maximum value of `BLImageScaleFilter`.
    static let maxValue = BL_IMAGE_SCALE_FILTER_MAX_VALUE
}
