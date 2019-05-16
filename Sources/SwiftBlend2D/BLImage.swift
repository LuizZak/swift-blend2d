#if canImport(Foundation)
import Foundation
#endif
import blend2d

public final class BLImage: BLBaseClass<BLImageCore> {
    public static var none: BLImage {
        let image = BLImage()
        blVariantInit(&image.object)
        
        return image
    }
    
    /// Maximum width of an image.
    public static var maximumWidth: Int {
        return Int(BLRuntimeBuildInfo.current.maxImageSize)
    }
    /// Maximum height of an image.
    public static var maximumHeight: Int {
        return Int(BLRuntimeBuildInfo.current.maxImageSize)
    }
    
    public var width: Int {
        return Int(object.impl.pointee.size.w)
    }
    public var height: Int {
        return Int(object.impl.pointee.size.h)
    }
    public var size: BLSizeI {
        return object.impl.pointee.size
    }
    
    /// The image format.
    public var format: BLFormat {
        return BLFormat(rawValue: BLFormat.RawValue(object.impl.pointee.format))
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
    public init(width: Int, height: Int, format: BLFormat) {
        precondition(width > 0 && width <= BLImage.maximumWidth)
        precondition(height > 0 && height <= BLImage.maximumHeight)
        
        super.init {
            blImageInitAs($0, Int32(width), Int32(height), format.rawValue)
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
    
    override init(weakAssign object: BLImageCore) {
        super.init(weakAssign: object)
    }
    
    public func equals(to other: BLImage) -> Bool {
        return blImageEquals(&object, &other.object)
    }
    
    /// Scales this image to a given size, with a given scale filter.
    ///
    /// Throws in case one of the input values is invalid.
    public func scale(size: BLSizeI, filter: BLImageScaleFilter, options: BLImageScaleOptions? = nil) throws {
        var size = size
        
        try resultToError(
            withUnsafeNullablePointer(to: options) {
                blImageScale(&object, &object, &size, filter.rawValue, $0)
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
    
    public func getData() -> BLImageData {
        var data = BLImageData()
        blImageGetData(&object, &data)
        return data
    }
    
    #if canImport(Foundation)
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
    #endif
    
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
    public static var assignWeak = blImageAssignWeak
}
