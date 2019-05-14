import blend2d

/// Errors that can be raised by Blend2D during some operations.
/// Altough not mapped here, a successful operation has an error result of BL_SUCCESS (0).
///
/// - outOfMemory:
///     Out of memory                 [ENOMEM].
/// - invalidValue:
///     Invalid value/argument        [EINVAL].
/// - invalidState:
///     Invalid state                 [EFAULT].
/// - invalidHandle:
///     Invalid handle or file.       [EBADF].
/// - valueTooLarge:
///     Value too large               [EOVERFLOW].
/// - notInitialized:
///     Not initialize (some instance is built-in none when it shouldn't be).
/// - notImplemented:
///     Not implemented               [ENOSYS].
/// - notPermitted:
///     Operation not permitted       [EPERM].
/// - io:
///     IO error                      [EIO].
/// - busy:
///     Device or resource busy       [EBUSY].
/// - interrupted:
///     Operation interrupted         [EINTR].
/// - tryAgain:
///     Try again                     [EAGAIN].
/// - timedOut:
///     Timed out                     [ETIMEDOUT].
/// - brokenPipe:
///     Broken pipe                   [EPIPE].
/// - invalidSeek:
///     File is not seekable          [ESPIPE].
/// - symlinkLoop:
///     Too many levels of symlinks   [ELOOP].
/// - fileTooLarge:
///     File is too large             [EFBIG].
/// - alreadyExists:
///     File/directory already exists [EEXIST].
/// - accessDenied:
///     Access denied                 [EACCES].
/// - mediaChanged:
///     Media changed                 [Windows::ERROR_MEDIA_CHANGED].
/// - readOnlyFs:
///     The file/FS is read-only      [EROFS].
/// - noDevice:
///     Device doesn't exist          [ENXIO].
/// - noEntry:
///     No such file or directory     [ENOENT].
/// - noMedia:
///     No media in drive/device      [ENOMEDIUM].
/// - noMoreData:
///     No more data / end of file    [ENODATA].
/// - noMoreFiles:
///     No more files                 [ENMFILE].
/// - noSpaceLeft:
///     No space left on device       [ENOSPC].
/// - notEmpty:
///     Directory is not empty        [ENOTEMPTY].
/// - notFile:
///     Not a file                    [EISDIR].
/// - notDirectory:
///     Not a directory               [ENOTDIR].
/// - notSameDevice:
///     Not same device               [EXDEV].
/// - notBlockDevice:
///     Not a block device            [ENOTBLK].
/// - invalidFileName:
///     File/path name is invalid     [n/a].
/// - fileNameTooLong:
///     File/path name is too long    [ENAMETOOLONG].
/// - tooManyOpenFiles:
///     Too many open files           [EMFILE].
/// - tooManyOpenFilesByOs:
///     Too many open files by OS     [ENFILE].
/// - tooManyLinks:
///     Too many symbolic links on FS [EMLINK].
/// - tooManyThreads:
///     Too many threads              [EAGAIN].
/// - fileEmpty:
///     File is empty (not specific to any OS error).
/// - openFailed:
///     File open failed              [Windows::ERROR_OPEN_FAILED].
/// - notRootDevice:
///     Not a root device/directory   [Windows::ERROR_DIR_NOT_ROOT].
/// - unknownSystemError:
///     Unknown system error that failed to translate to Blend2D result code.
/// - invalidSignature:
///     Invalid data signature or header.
/// - invalidData:
///     Invalid or corrupted data.
/// - invalidString:
///     Invalid string (invalid data of either UTF8 UTF16 or UTF32).
/// - dataTruncated:
///     Truncated data (more data required than memory/stream provides).
/// - dataTooLarge:
///     Input data too large to be processed.
/// - decompressionFailed:
///     Decompression failed due to invalid data (RLE Huffman etc).
/// - invalidGeometry:
///     Invalid geometry (invalid path data or shape).
/// - noMatchingVertex:
///     Returned when there is no matching vertex in path data.
/// - noMatchingCookie:
///     No matching cookie (BLContext).
/// - noStatesToRestore:
///     No states to restore (BLContext).
/// - imageTooLarge:
///     The size of the image is too large.
/// - imageNoMatchingCodec:
///     Image codec for a required format doesn't exist.
/// - imageUnknownFileFormat:
///     Unknown or invalid file format that cannot be read.
/// - imageDecoderNotProvided:
///     Image codec doesn't support reading the file format.
/// - imageEncoderNotProvided:
///     Image codec doesn't support writing the file format.
/// - pngMultipleIhdr:
///     Multiple IHDR chunks are not allowed (PNG).
/// - pngInvalidIdat:
///     Invalid IDAT chunk (PNG).
/// - pngInvalidIend:
///     Invalid IEND chunk (PNG).
/// - pngInvalidPlte:
///     Invalid PLTE chunk (PNG).
/// - pngInvalidTrns:
///     Invalid tRNS chunk (PNG).
/// - pngInvalidFilter:
///     Invalid filter type (PNG).
/// - jpegUnsupportedFeature:
///     Unsupported feature (JPEG).
/// - jpegInvalidSos:
///     Invalid SOS marker or header (JPEG).
/// - jpegInvalidSof:
///     Invalid SOF marker (JPEG).
/// - jpegMultipleSof:
///     Multiple SOF markers (JPEG).
/// - jpegUnsupportedSof:
///     Unsupported SOF marker (JPEG).
/// - fontNoCharacterMapping:
///     Font has no character to glyph mapping data.
/// - fontMissingImportantTable:
///     Font has missing an important table.
/// - fontFeatureNotAvailable:
///     Font feature is not available.
/// - fontCffInvalidData:
///     Font has an invalid CFF data.
/// - fontProgramTerminated:
///     Font program terminated because the execution reached the limit.
/// - invalidGlyph:
///     Invalid glyph identifier.
public enum Blend2DError: Error, CustomStringConvertible {
    case outOfMemory
    case invalidValue
    case invalidState
    case invalidHandle
    case valueTooLarge
    case notInitialized
    case notImplemented
    case notPermitted
    case io
    case busy
    case interrupted
    case tryAgain
    case timedOut
    case brokenPipe
    case invalidSeek
    case symlinkLoop
    case fileTooLarge
    case alreadyExists
    case accessDenied
    case mediaChanged
    case readOnlyFs
    case noDevice
    case noEntry
    case noMedia
    case noMoreData
    case noMoreFiles
    case noSpaceLeft
    case notEmpty
    case notFile
    case notDirectory
    case notSameDevice
    case notBlockDevice
    case invalidFileName
    case fileNameTooLong
    case tooManyOpenFiles
    case tooManyOpenFilesByOs
    case tooManyLinks
    case tooManyThreads
    case fileEmpty
    case openFailed
    case notRootDevice
    case unknownSystemError
    case invalidSignature
    case invalidData
    case invalidString
    case dataTruncated
    case dataTooLarge
    case decompressionFailed
    case invalidGeometry
    case noMatchingVertex
    case noMatchingCookie
    case noStatesToRestore
    case imageTooLarge
    case imageNoMatchingCodec
    case imageUnknownFileFormat
    case imageDecoderNotProvided
    case imageEncoderNotProvided
    case pngMultipleIhdr
    case pngInvalidIdat
    case pngInvalidIend
    case pngInvalidPlte
    case pngInvalidTrns
    case pngInvalidFilter
    case jpegUnsupportedFeature
    case jpegInvalidSos
    case jpegInvalidSof
    case jpegMultipleSof
    case jpegUnsupportedSof
    case fontNoCharacterMapping
    case fontMissingImportantTable
    case fontFeatureNotAvailable
    case fontCffInvalidData
    case fontProgramTerminated
    case invalidGlyph

    public var description: String {
        switch self {
        case .outOfMemory:
            return "Out of memory"
        case .invalidValue:
            return "Invalid value/argument"
        case .invalidState:
            return "Invalid state"
        case .invalidHandle:
            return "Invalid handle or file."
        case .valueTooLarge:
            return "Value too large"
        case .notInitialized:
            return "Not initialize (some instance is built-in none when it shouldn't be)."
        case .notImplemented:
            return "Not implemented"
        case .notPermitted:
            return "Operation not permitted"
        case .io:
            return "IO error"
        case .busy:
            return "Device or resource busy"
        case .interrupted:
            return "Operation interrupted"
        case .tryAgain:
            return "Try again"
        case .timedOut:
            return "Timed out"
        case .brokenPipe:
            return "Broken pipe"
        case .invalidSeek:
            return "File is not seekable"
        case .symlinkLoop:
            return "Too many levels of symlinks"
        case .fileTooLarge:
            return "File is too large"
        case .alreadyExists:
            return "File/directory already exists"
        case .accessDenied:
            return "Access denied"
        case .mediaChanged:
            return "Media changed."
        case .readOnlyFs:
            return "The file/FS is read-only"
        case .noDevice:
            return "Device doesn't exist"
        case .noEntry:
            return "No such file or directory"
        case .noMedia:
            return "No media in drive/device"
        case .noMoreData:
            return "No more data / end of file"
        case .noMoreFiles:
            return "No more files"
        case .noSpaceLeft:
            return "No space left on device"
        case .notEmpty:
            return "Directory is not empty"
        case .notFile:
            return "Not a file"
        case .notDirectory:
            return "Not a directory"
        case .notSameDevice:
            return "Not same device"
        case .notBlockDevice:
            return "Not a block device"
        case .invalidFileName:
            return "File/path name is invalid."
        case .fileNameTooLong:
            return "File/path name is too long"
        case .tooManyOpenFiles:
            return "Too many open files"
        case .tooManyOpenFilesByOs:
            return "Too many open files by OS"
        case .tooManyLinks:
            return "Too many symbolic links on FS"
        case .tooManyThreads:
            return "Too many threads"
        case .fileEmpty:
            return "File is empty."
        case .openFailed:
            return "File open failed."
        case .notRootDevice:
            return "Not a root device/directory."
        case .unknownSystemError:
            return "Unknown system error that failed to translate to Blend2D result code."
        case .invalidSignature:
            return "Invalid data signature or header."
        case .invalidData:
            return "Invalid or corrupted data."
        case .invalidString:
            return "Invalid string (invalid data of either UTF8 UTF16 or UTF32)."
        case .dataTruncated:
            return "Truncated data (more data required than memory/stream provides)."
        case .dataTooLarge:
            return "Input data too large to be processed."
        case .decompressionFailed:
            return "Decompression failed due to invalid data (RLE Huffman etc)."
        case .invalidGeometry:
            return "Invalid geometry (invalid path data or shape)."
        case .noMatchingVertex:
            return "Returned when there is no matching vertex in path data."
        case .noMatchingCookie:
            return "No matching cookie (BLContext)."
        case .noStatesToRestore:
            return "No states to restore (BLContext)."
        case .imageTooLarge:
            return "The size of the image is too large."
        case .imageNoMatchingCodec:
            return "Image codec for a required format doesn't exist."
        case .imageUnknownFileFormat:
            return "Unknown or invalid file format that cannot be read."
        case .imageDecoderNotProvided:
            return "Image codec doesn't support reading the file format."
        case .imageEncoderNotProvided:
            return "Image codec doesn't support writing the file format."
        case .pngMultipleIhdr:
            return "Multiple IHDR chunks are not allowed (PNG)."
        case .pngInvalidIdat:
            return "Invalid IDAT chunk (PNG)."
        case .pngInvalidIend:
            return "Invalid IEND chunk (PNG)."
        case .pngInvalidPlte:
            return "Invalid PLTE chunk (PNG)."
        case .pngInvalidTrns:
            return "Invalid tRNS chunk (PNG)."
        case .pngInvalidFilter:
            return "Invalid filter type (PNG)."
        case .jpegUnsupportedFeature:
            return "Unsupported feature (JPEG)."
        case .jpegInvalidSos:
            return "Invalid SOS marker or header (JPEG)."
        case .jpegInvalidSof:
            return "Invalid SOF marker (JPEG)."
        case .jpegMultipleSof:
            return "Multiple SOF markers (JPEG)."
        case .jpegUnsupportedSof:
            return "Unsupported SOF marker (JPEG)."
        case .fontNoCharacterMapping:
            return "Font has no character to glyph mapping data."
        case .fontMissingImportantTable:
            return "Font has missing an important table."
        case .fontFeatureNotAvailable:
            return "Font feature is not available."
        case .fontCffInvalidData:
            return "Font has an invalid CFF data."
        case .fontProgramTerminated:
            return "Font program terminated because the execution reached the limit."
        case .invalidGlyph:
            return "Invalid glyph identifier."
        }
    }

    public var resultCode: BLResultCode {
        switch self {
        case .outOfMemory:
            return BL_ERROR_OUT_OF_MEMORY
        case .invalidValue:
            return BL_ERROR_INVALID_VALUE
        case .invalidState:
            return BL_ERROR_INVALID_STATE
        case .invalidHandle:
            return BL_ERROR_INVALID_HANDLE
        case .valueTooLarge:
            return BL_ERROR_VALUE_TOO_LARGE
        case .notInitialized:
            return BL_ERROR_NOT_INITIALIZED
        case .notImplemented:
            return BL_ERROR_NOT_IMPLEMENTED
        case .notPermitted:
            return BL_ERROR_NOT_PERMITTED
        case .io:
            return BL_ERROR_IO
        case .busy:
            return BL_ERROR_BUSY
        case .interrupted:
            return BL_ERROR_INTERRUPTED
        case .tryAgain:
            return BL_ERROR_TRY_AGAIN
        case .timedOut:
            return BL_ERROR_TIMED_OUT
        case .brokenPipe:
            return BL_ERROR_BROKEN_PIPE
        case .invalidSeek:
            return BL_ERROR_INVALID_SEEK
        case .symlinkLoop:
            return BL_ERROR_SYMLINK_LOOP
        case .fileTooLarge:
            return BL_ERROR_FILE_TOO_LARGE
        case .alreadyExists:
            return BL_ERROR_ALREADY_EXISTS
        case .accessDenied:
            return BL_ERROR_ACCESS_DENIED
        case .mediaChanged:
            return BL_ERROR_MEDIA_CHANGED
        case .readOnlyFs:
            return BL_ERROR_READ_ONLY_FS
        case .noDevice:
            return BL_ERROR_NO_DEVICE
        case .noEntry:
            return BL_ERROR_NO_ENTRY
        case .noMedia:
            return BL_ERROR_NO_MEDIA
        case .noMoreData:
            return BL_ERROR_NO_MORE_DATA
        case .noMoreFiles:
            return BL_ERROR_NO_MORE_FILES
        case .noSpaceLeft:
            return BL_ERROR_NO_SPACE_LEFT
        case .notEmpty:
            return BL_ERROR_NOT_EMPTY
        case .notFile:
            return BL_ERROR_NOT_FILE
        case .notDirectory:
            return BL_ERROR_NOT_DIRECTORY
        case .notSameDevice:
            return BL_ERROR_NOT_SAME_DEVICE
        case .notBlockDevice:
            return BL_ERROR_NOT_BLOCK_DEVICE
        case .invalidFileName:
            return BL_ERROR_INVALID_FILE_NAME
        case .fileNameTooLong:
            return BL_ERROR_FILE_NAME_TOO_LONG
        case .tooManyOpenFiles:
            return BL_ERROR_TOO_MANY_OPEN_FILES
        case .tooManyOpenFilesByOs:
            return BL_ERROR_TOO_MANY_OPEN_FILES_BY_OS
        case .tooManyLinks:
            return BL_ERROR_TOO_MANY_LINKS
        case .tooManyThreads:
            return BL_ERROR_TOO_MANY_THREADS
        case .fileEmpty:
            return BL_ERROR_FILE_EMPTY
        case .openFailed:
            return BL_ERROR_OPEN_FAILED
        case .notRootDevice:
            return BL_ERROR_NOT_ROOT_DEVICE
        case .unknownSystemError:
            return BL_ERROR_UNKNOWN_SYSTEM_ERROR
        case .invalidSignature:
            return BL_ERROR_INVALID_SIGNATURE
        case .invalidData:
            return BL_ERROR_INVALID_DATA
        case .invalidString:
            return BL_ERROR_INVALID_STRING
        case .dataTruncated:
            return BL_ERROR_DATA_TRUNCATED
        case .dataTooLarge:
            return BL_ERROR_DATA_TOO_LARGE
        case .decompressionFailed:
            return BL_ERROR_DECOMPRESSION_FAILED
        case .invalidGeometry:
            return BL_ERROR_INVALID_GEOMETRY
        case .noMatchingVertex:
            return BL_ERROR_NO_MATCHING_VERTEX
        case .noMatchingCookie:
            return BL_ERROR_NO_MATCHING_COOKIE
        case .noStatesToRestore:
            return BL_ERROR_NO_STATES_TO_RESTORE
        case .imageTooLarge:
            return BL_ERROR_IMAGE_TOO_LARGE
        case .imageNoMatchingCodec:
            return BL_ERROR_IMAGE_NO_MATCHING_CODEC
        case .imageUnknownFileFormat:
            return BL_ERROR_IMAGE_UNKNOWN_FILE_FORMAT
        case .imageDecoderNotProvided:
            return BL_ERROR_IMAGE_DECODER_NOT_PROVIDED
        case .imageEncoderNotProvided:
            return BL_ERROR_IMAGE_ENCODER_NOT_PROVIDED
        case .pngMultipleIhdr:
            return BL_ERROR_PNG_MULTIPLE_IHDR
        case .pngInvalidIdat:
            return BL_ERROR_PNG_INVALID_IDAT
        case .pngInvalidIend:
            return BL_ERROR_PNG_INVALID_IEND
        case .pngInvalidPlte:
            return BL_ERROR_PNG_INVALID_PLTE
        case .pngInvalidTrns:
            return BL_ERROR_PNG_INVALID_TRNS
        case .pngInvalidFilter:
            return BL_ERROR_PNG_INVALID_FILTER
        case .jpegUnsupportedFeature:
            return BL_ERROR_JPEG_UNSUPPORTED_FEATURE
        case .jpegInvalidSos:
            return BL_ERROR_JPEG_INVALID_SOS
        case .jpegInvalidSof:
            return BL_ERROR_JPEG_INVALID_SOF
        case .jpegMultipleSof:
            return BL_ERROR_JPEG_MULTIPLE_SOF
        case .jpegUnsupportedSof:
            return BL_ERROR_JPEG_UNSUPPORTED_SOF
        case .fontNoCharacterMapping:
            return BL_ERROR_FONT_NO_CHARACTER_MAPPING
        case .fontMissingImportantTable:
            return BL_ERROR_FONT_MISSING_IMPORTANT_TABLE
        case .fontFeatureNotAvailable:
            return BL_ERROR_FONT_FEATURE_NOT_AVAILABLE
        case .fontCffInvalidData:
            return BL_ERROR_FONT_CFF_INVALID_DATA
        case .fontProgramTerminated:
            return BL_ERROR_FONT_PROGRAM_TERMINATED
        case .invalidGlyph:
            return BL_ERROR_INVALID_GLYPH
        }
    }
}

/// Base class for internal Swift-wrapped Blend2D errors.
public class SwiftBlend2DError: Error, CustomStringConvertible {
    public let description: String

    @usableFromInline
    var result: BLResultCode
    @usableFromInline
    var error: Blend2DError

    @inlinable
    init(description: String, resultCode: BLResultCode, error: Blend2DError) {
        self.description = description
        self.result = resultCode
        self.error = error
    }
}

public extension SwiftBlend2DError {
    class FileError: SwiftBlend2DError {
        @inlinable
        public init(filePath: String) {
            super.init(description: "No such file or directory \(filePath)",
                       resultCode: BL_ERROR_NO_ENTRY,
                       error: .noEntry)
        }

        @inlinable
        public init(fileNotOpenAtPath filePath: String?) {
            if let filePath = filePath {
                super.init(description: "File is no longer open at path \(filePath)",
                    resultCode: BL_ERROR_INVALID_HANDLE,
                    error: .invalidHandle)
            } else {
                super.init(description: "No file open",
                    resultCode: BL_ERROR_INVALID_HANDLE,
                    error: .invalidHandle)
            }
        }
    }
}

@inlinable
func mapError(_ operation: @escaping () -> BLResult) -> Blend2DErrorMapper {
    return Blend2DErrorMapper(operation: operation)
}

@usableFromInline
@discardableResult
func resultToError(_ operation: @autoclosure () -> BLResult) throws -> BLResult {
    let value = operation()
    
    if let error = errorForResult(value) {
        throw error
    }

    return value
}

func errorForResult(_ result: BLResult) -> Blend2DError? {
    switch result {
    case BL_SUCCESS.rawValue:
        return nil

    case BL_ERROR_OUT_OF_MEMORY.rawValue:
        return Blend2DError.outOfMemory
    case BL_ERROR_INVALID_VALUE.rawValue:
        return Blend2DError.invalidValue
    case BL_ERROR_INVALID_STATE.rawValue:
        return Blend2DError.invalidState
    case BL_ERROR_INVALID_HANDLE.rawValue:
        return Blend2DError.invalidHandle
    case BL_ERROR_VALUE_TOO_LARGE.rawValue:
        return Blend2DError.valueTooLarge
    case BL_ERROR_NOT_INITIALIZED.rawValue:
        return Blend2DError.notInitialized
    case BL_ERROR_NOT_IMPLEMENTED.rawValue:
        return Blend2DError.notImplemented
    case BL_ERROR_NOT_PERMITTED.rawValue:
        return Blend2DError.notPermitted
    case BL_ERROR_IO.rawValue:
        return Blend2DError.io
    case BL_ERROR_BUSY.rawValue:
        return Blend2DError.busy
    case BL_ERROR_INTERRUPTED.rawValue:
        return Blend2DError.interrupted
    case BL_ERROR_TRY_AGAIN.rawValue:
        return Blend2DError.tryAgain
    case BL_ERROR_TIMED_OUT.rawValue:
        return Blend2DError.timedOut
    case BL_ERROR_BROKEN_PIPE.rawValue:
        return Blend2DError.brokenPipe
    case BL_ERROR_INVALID_SEEK.rawValue:
        return Blend2DError.invalidSeek
    case BL_ERROR_SYMLINK_LOOP.rawValue:
        return Blend2DError.symlinkLoop
    case BL_ERROR_FILE_TOO_LARGE.rawValue:
        return Blend2DError.fileTooLarge
    case BL_ERROR_ALREADY_EXISTS.rawValue:
        return Blend2DError.alreadyExists
    case BL_ERROR_ACCESS_DENIED.rawValue:
        return Blend2DError.accessDenied
    case BL_ERROR_MEDIA_CHANGED.rawValue:
        return Blend2DError.mediaChanged
    case BL_ERROR_READ_ONLY_FS.rawValue:
        return Blend2DError.readOnlyFs
    case BL_ERROR_NO_DEVICE.rawValue:
        return Blend2DError.noDevice
    case BL_ERROR_NO_ENTRY.rawValue:
        return Blend2DError.noEntry
    case BL_ERROR_NO_MEDIA.rawValue:
        return Blend2DError.noMedia
    case BL_ERROR_NO_MORE_DATA.rawValue:
        return Blend2DError.noMoreData
    case BL_ERROR_NO_MORE_FILES.rawValue:
        return Blend2DError.noMoreFiles
    case BL_ERROR_NO_SPACE_LEFT.rawValue:
        return Blend2DError.noSpaceLeft
    case BL_ERROR_NOT_EMPTY.rawValue:
        return Blend2DError.notEmpty
    case BL_ERROR_NOT_FILE.rawValue:
        return Blend2DError.notFile
    case BL_ERROR_NOT_DIRECTORY.rawValue:
        return Blend2DError.notDirectory
    case BL_ERROR_NOT_SAME_DEVICE.rawValue:
        return Blend2DError.notSameDevice
    case BL_ERROR_NOT_BLOCK_DEVICE.rawValue:
        return Blend2DError.notBlockDevice
    case BL_ERROR_INVALID_FILE_NAME.rawValue:
        return Blend2DError.invalidFileName
    case BL_ERROR_FILE_NAME_TOO_LONG.rawValue:
        return Blend2DError.fileNameTooLong
    case BL_ERROR_TOO_MANY_OPEN_FILES.rawValue:
        return Blend2DError.tooManyOpenFiles
    case BL_ERROR_TOO_MANY_OPEN_FILES_BY_OS.rawValue:
        return Blend2DError.tooManyOpenFilesByOs
    case BL_ERROR_TOO_MANY_LINKS.rawValue:
        return Blend2DError.tooManyLinks
    case BL_ERROR_TOO_MANY_THREADS.rawValue:
        return Blend2DError.tooManyThreads
    case BL_ERROR_FILE_EMPTY.rawValue:
        return Blend2DError.fileEmpty
    case BL_ERROR_OPEN_FAILED.rawValue:
        return Blend2DError.openFailed
    case BL_ERROR_NOT_ROOT_DEVICE.rawValue:
        return Blend2DError.notRootDevice
    case BL_ERROR_UNKNOWN_SYSTEM_ERROR.rawValue:
        return Blend2DError.unknownSystemError
    case BL_ERROR_INVALID_SIGNATURE.rawValue:
        return Blend2DError.invalidSignature
    case BL_ERROR_INVALID_DATA.rawValue:
        return Blend2DError.invalidData
    case BL_ERROR_INVALID_STRING.rawValue:
        return Blend2DError.invalidString
    case BL_ERROR_DATA_TRUNCATED.rawValue:
        return Blend2DError.dataTruncated
    case BL_ERROR_DATA_TOO_LARGE.rawValue:
        return Blend2DError.dataTooLarge
    case BL_ERROR_DECOMPRESSION_FAILED.rawValue:
        return Blend2DError.decompressionFailed
    case BL_ERROR_INVALID_GEOMETRY.rawValue:
        return Blend2DError.invalidGeometry
    case BL_ERROR_NO_MATCHING_VERTEX.rawValue:
        return Blend2DError.noMatchingVertex
    case BL_ERROR_NO_MATCHING_COOKIE.rawValue:
        return Blend2DError.noMatchingCookie
    case BL_ERROR_NO_STATES_TO_RESTORE.rawValue:
        return Blend2DError.noStatesToRestore
    case BL_ERROR_IMAGE_TOO_LARGE.rawValue:
        return Blend2DError.imageTooLarge
    case BL_ERROR_IMAGE_NO_MATCHING_CODEC.rawValue:
        return Blend2DError.imageNoMatchingCodec
    case BL_ERROR_IMAGE_UNKNOWN_FILE_FORMAT.rawValue:
        return Blend2DError.imageUnknownFileFormat
    case BL_ERROR_IMAGE_DECODER_NOT_PROVIDED.rawValue:
        return Blend2DError.imageDecoderNotProvided
    case BL_ERROR_IMAGE_ENCODER_NOT_PROVIDED.rawValue:
        return Blend2DError.imageEncoderNotProvided
    case BL_ERROR_PNG_MULTIPLE_IHDR.rawValue:
        return Blend2DError.pngMultipleIhdr
    case BL_ERROR_PNG_INVALID_IDAT.rawValue:
        return Blend2DError.pngInvalidIdat
    case BL_ERROR_PNG_INVALID_IEND.rawValue:
        return Blend2DError.pngInvalidIend
    case BL_ERROR_PNG_INVALID_PLTE.rawValue:
        return Blend2DError.pngInvalidPlte
    case BL_ERROR_PNG_INVALID_TRNS.rawValue:
        return Blend2DError.pngInvalidTrns
    case BL_ERROR_PNG_INVALID_FILTER.rawValue:
        return Blend2DError.pngInvalidFilter
    case BL_ERROR_JPEG_UNSUPPORTED_FEATURE.rawValue:
        return Blend2DError.jpegUnsupportedFeature
    case BL_ERROR_JPEG_INVALID_SOS.rawValue:
        return Blend2DError.jpegInvalidSos
    case BL_ERROR_JPEG_INVALID_SOF.rawValue:
        return Blend2DError.jpegInvalidSof
    case BL_ERROR_JPEG_MULTIPLE_SOF.rawValue:
        return Blend2DError.jpegMultipleSof
    case BL_ERROR_JPEG_UNSUPPORTED_SOF.rawValue:
        return Blend2DError.jpegUnsupportedSof
    case BL_ERROR_FONT_NO_CHARACTER_MAPPING.rawValue:
        return Blend2DError.fontNoCharacterMapping
    case BL_ERROR_FONT_MISSING_IMPORTANT_TABLE.rawValue:
        return Blend2DError.fontMissingImportantTable
    case BL_ERROR_FONT_FEATURE_NOT_AVAILABLE.rawValue:
        return Blend2DError.fontFeatureNotAvailable
    case BL_ERROR_FONT_CFF_INVALID_DATA.rawValue:
        return Blend2DError.fontCffInvalidData
    case BL_ERROR_FONT_PROGRAM_TERMINATED.rawValue:
        return Blend2DError.fontProgramTerminated
    case BL_ERROR_INVALID_GLYPH.rawValue:
        return Blend2DError.invalidGlyph

    default:
        return nil
    }
}
