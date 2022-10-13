import Foundation
import blend2d

public final class BLImage: BLBaseClass<BLImageCore> {
    /// Maximum width of an image.
    public static var maximumWidth: Int {
        Int(BLRuntimeBuildInfo.current.maxImageSize)
    }
    /// Maximum height of an image.
    public static var maximumHeight: Int {
        Int(BLRuntimeBuildInfo.current.maxImageSize)
    }
    
    public var width: Int {
        Int(getImageData().size.w)
    }
    public var height: Int {
        Int(getImageData().size.h)
    }
    public var size: BLSizeI {
        getImageData().size
    }
    
    /// The image format.
    public var format: BLFormat {
        BLFormat(rawValue: BLFormat.RawValue(getImageData().format))
    }
    
    public override init() {
        super.init()
    }
    
    /// Initializes a new image with the given dimensions and format.
    ///
    /// - Parameters:
    ///   - width: Width of image. Must be greater than zero and less than or
    /// equal to BLImage.maximumWidth.
    ///   - height: Height of image. Must be greater than zero and less than or
    /// equal to BLImage.maximumHeight.
    ///   - format: A valid image format to use for the image.
    public convenience init(width: Int, height: Int, format: BLFormat) {
        self.init(
            size: .init(w: Int32(width), h: Int32(height)),
            format: format
        )
    }
    
    /// Initializes a new image with the given dimensions and format.
    ///
    /// - Parameters:
    ///   - size: Size of the image. Both width and height must be greater than 
    /// zero and less than or equal to (BLImage.maximumWidth, BLImage.maximumHeight).
    ///   - format: A valid image format to use for the image.
    public init(size: BLSizeI, format: BLFormat) {
        precondition(size.w > 0 && size.w <= Int32(BLImage.maximumWidth))
        precondition(size.h > 0 && size.h <= Int32(BLImage.maximumHeight))
        
        super.init {
            blImageInitAs($0, size.w, size.h, format)
        }
    }
    
    /// Initializes a new image from a file on disk.
    ///
    /// Optionally allows specifying codecs to try to use when decoding the image
    /// file. If no codecs are provided, the default image codecs are used, instead.
    ///
    /// - Parameters:
    ///   - filePath: A file path from the current working directory to search
    /// for the image file.
    ///   - codecs: A list of codecs to attempt to use for the referenced image
    /// file. If `nil`, the default image codecs are used, instead.
    public init(fromFile filePath: String, codecs: [BLImageCodec]? = nil) throws {
        try super.init { pointer -> BLResult in
            blImageInit(pointer)
            
            return try mapError {
                withCodecArray(codecs) { codecs in
                    blImageReadFromFile(pointer, filePath, codecs)
                }
            }
            .addFileErrorMappings(filePath: filePath)
            .execute()
        }
    }

    /// Initializes a new image from a section of memory containing the 
    /// appropriately formatted pixel data.
    ///
    /// This type of initialization does not handle deallocation of image data
    /// and should be handled separately by callers.
    ///
    /// - Parameters:
    ///   - pixelData: A pointer to raw pixel data on memory.
    ///   - stride: The stride, or number of bytes per row of pixels.
    ///   - width: Width of image. Must be greater than zero and less than or
    /// equal to BLImage.maximumWidth.
    ///   - height: Height of image. Must be greater than zero and less than or
    /// equal to BLImage.maximumHeight.
    ///   - format: A valid image format to use for the image.
    public convenience init(
        fromUnownedData pixelData: UnsafeMutableRawPointer,
        stride: Int,
        width: Int,
        height: Int,
        format: BLFormat
    ) {

        self.init(
            fromUnownedData: pixelData,
            stride: stride,
            size: .init(w: Int32(width), h: Int32(height)),
            format: format
        )
    }

    /// Initializes a new image from a section of memory containing the 
    /// appropriately formatted pixel data.
    ///
    /// This type of initialization does not handle deallocation of image data
    /// and should be handled separately by callers.
    ///
    /// - Parameters:
    ///   - pixelData: A pointer to raw pixel data on memory.
    ///   - stride: The stride, or number of bytes per row of pixels.
    ///   - size: Size of the image. Both width and height must be greater than 
    /// zero and less than or equal to (BLImage.maximumWidth, BLImage.maximumHeight).
    ///   - format: A valid image format to use for the image.
    public init(
        fromUnownedData pixelData: UnsafeMutableRawPointer,
        stride: Int,
        size: BLSizeI,
        format: BLFormat
    ) {

        super.init {
            blImageInitAsFromData(
                $0,
                size.w,
                size.h,
                format,
                pixelData,
                stride,
                nil,
                nil
            )
        }
    }
    
    override init(weakAssign object: BLImageCore) {
        super.init(weakAssign: object)
    }
    
    public func equals(to other: BLImage) -> Bool {
        return blImageEquals(&object, &other.object)
    }
    
    /// Scales this image to a given size, with a given scale filter.
    ///
    /// Throws in case one of the input values is invalid.
    public func scale(
        size: BLSizeI,
        filter: BLImageScaleFilter,
        options: BLImageScaleOptions? = nil
    ) throws {

        var size = size
        var objectCopy = object
        
        try resultToError(
            withUnsafeNullablePointer(to: options) {
                blImageScale(&object, &objectCopy, &size, UInt32(filter.rawValue), $0)
            }
        )
    }
    
    public func writeToFile(_ path: String, codec: BLImageCodec) throws {
        try mapError {
            blImageWriteToFile(&self.object, path, &codec.object)
        }
        .addFileErrorMappings(filePath: path)
        .execute()
    }
    
    public func getImageData() -> BLImageData {
        var data = BLImageData()
        blImageGetData(&object, &data)
        return data
    }
    
    public func toData(codec: BLImageCodec) throws -> Data {
        var data = Data()
        try writeToData(data: &data, codec: codec)
        return data
    }

    public func writeToData(data: inout Data, codec: BLImageCodec) throws {
        let buffer = BLArray<UInt8>()
        try writeToData(buffer, codec: codec)
        data.append(buffer.unsafePointer())
    }
    
    func writeToData<T>(_ buffer: BLArray<T>, codec: BLImageCodec) throws {
        try resultToError(
            blImageWriteToData(&object, &buffer.object, &codec.object)
        )
    }
    
    public func readFromFile(_ fileName: String, codecs: [BLImageCodec]? = nil) throws {
        try mapError {
            withCodecArray(codecs) {
                blImageReadFromFile(&self.object, fileName, $0)
            }
        }
        .addFileErrorMappings(filePath: fileName)
        .execute()
    }
    
    public func readFromData(_ data: [UInt8], codecs: [BLImageCodec]? = nil) throws {
        let array = BLArray<UInt8>()
        for item in data {
            array.append(item)
        }
        
        try readFromData(array, codecs: codecs)
    }
    
    func readFromData(_ buffer: BLArray<UInt8>, codecs: [BLImageCodec]? = nil) throws {
        try resultToError(
            withCodecArray(codecs) {
                blImageReadFromData(&object, buffer.unsafePointer().baseAddress, buffer.count, $0)
            }
        )
    }
}

extension BLImage: Equatable {
    public static func == (lhs: BLImage, rhs: BLImage) -> Bool {
        blImageEquals(&lhs.object, &rhs.object)
    }
}

private func withCodecArray<T>(_ codecs: [BLImageCodec]?, _ closure: (UnsafePointer<BLArrayCore>?) throws -> T) rethrows -> T {
    if let codecs = codecs {
        let codecsArray = BLArray<BLImageCodecCore>()
        for codec in codecs {
            codecsArray.append(codec.object)
        }
        
        return try closure(&codecsArray.object)
    } else {
        return try closure(nil)
    }
}

extension BLImageCore: CoreStructure {
    public static let initializer = blImageInit
    public static let deinitializer = blImageReset
    public static let assignWeak = blImageAssignWeak

    @usableFromInline
    var impl: BLImageImpl {
        get {
            _d.impl!.load(as: BLImageImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLImageImpl.self)
        }
    }
}
