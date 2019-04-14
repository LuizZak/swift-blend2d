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
public enum Blend2DError: String, Error {
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
}

func handleErrorResults(_ operation: @autoclosure () -> BLResult) throws {
    switch operation() {
    case BL_SUCCESS.rawValue:
        return
        
    case BL_ERROR_OUT_OF_MEMORY.rawValue:
        throw Blend2DError.outOfMemory
    case BL_ERROR_INVALID_VALUE.rawValue:
        throw Blend2DError.invalidValue
    case BL_ERROR_INVALID_STATE.rawValue:
        throw Blend2DError.invalidState
    case BL_ERROR_INVALID_HANDLE.rawValue:
        throw Blend2DError.invalidHandle
    case BL_ERROR_VALUE_TOO_LARGE.rawValue:
        throw Blend2DError.valueTooLarge
    case BL_ERROR_NOT_INITIALIZED.rawValue:
        throw Blend2DError.notInitialized
    case BL_ERROR_NOT_IMPLEMENTED.rawValue:
        throw Blend2DError.notImplemented
    case BL_ERROR_NOT_PERMITTED.rawValue:
        throw Blend2DError.notPermitted
    case BL_ERROR_IO.rawValue:
        throw Blend2DError.io
    case BL_ERROR_BUSY.rawValue:
        throw Blend2DError.busy
    case BL_ERROR_INTERRUPTED.rawValue:
        throw Blend2DError.interrupted
    case BL_ERROR_TRY_AGAIN.rawValue:
        throw Blend2DError.tryAgain
    case BL_ERROR_BROKEN_PIPE.rawValue:
        throw Blend2DError.brokenPipe
    case BL_ERROR_INVALID_SEEK.rawValue:
        throw Blend2DError.invalidSeek
    case BL_ERROR_SYMLINK_LOOP.rawValue:
        throw Blend2DError.symlinkLoop
    case BL_ERROR_FILE_TOO_LARGE.rawValue:
        throw Blend2DError.fileTooLarge
    case BL_ERROR_ALREADY_EXISTS.rawValue:
        throw Blend2DError.alreadyExists
    case BL_ERROR_ACCESS_DENIED.rawValue:
        throw Blend2DError.accessDenied
    case BL_ERROR_MEDIA_CHANGED.rawValue:
        throw Blend2DError.mediaChanged
    case BL_ERROR_READ_ONLY_FS.rawValue:
        throw Blend2DError.readOnlyFs
    case BL_ERROR_NO_DEVICE.rawValue:
        throw Blend2DError.noDevice
    case BL_ERROR_NO_ENTRY.rawValue:
        throw Blend2DError.noEntry
    case BL_ERROR_NO_MEDIA.rawValue:
        throw Blend2DError.noMedia
    case BL_ERROR_NO_MORE_DATA.rawValue:
        throw Blend2DError.noMoreData
    case BL_ERROR_NO_MORE_FILES.rawValue:
        throw Blend2DError.noMoreFiles
    case BL_ERROR_NO_SPACE_LEFT.rawValue:
        throw Blend2DError.noSpaceLeft
    case BL_ERROR_NOT_EMPTY.rawValue:
        throw Blend2DError.notEmpty
    case BL_ERROR_NOT_FILE.rawValue:
        throw Blend2DError.notFile
    case BL_ERROR_NOT_DIRECTORY.rawValue:
        throw Blend2DError.notDirectory
    case BL_ERROR_NOT_SAME_DEVICE.rawValue:
        throw Blend2DError.notSameDevice
    case BL_ERROR_NOT_BLOCK_DEVICE.rawValue:
        throw Blend2DError.notBlockDevice
    case BL_ERROR_INVALID_FILE_NAME.rawValue:
        throw Blend2DError.invalidFileName
    case BL_ERROR_FILE_NAME_TOO_LONG.rawValue:
        throw Blend2DError.fileNameTooLong
    case BL_ERROR_TOO_MANY_OPEN_FILES.rawValue:
        throw Blend2DError.tooManyOpenFiles
    case BL_ERROR_TOO_MANY_OPEN_FILES_BY_OS.rawValue:
        throw Blend2DError.tooManyOpenFilesByOs
    case BL_ERROR_TOO_MANY_LINKS.rawValue:
        throw Blend2DError.tooManyLinks
    case BL_ERROR_FILE_EMPTY.rawValue:
        throw Blend2DError.fileEmpty
    case BL_ERROR_OPEN_FAILED.rawValue:
        throw Blend2DError.openFailed
    case BL_ERROR_NOT_ROOT_DEVICE.rawValue:
        throw Blend2DError.notRootDevice
    case BL_ERROR_UNKNOWN_SYSTEM_ERROR.rawValue:
        throw Blend2DError.unknownSystemError
    case BL_ERROR_INVALID_SIGNATURE.rawValue:
        throw Blend2DError.invalidSignature
    case BL_ERROR_INVALID_DATA.rawValue:
        throw Blend2DError.invalidData
    case BL_ERROR_INVALID_STRING.rawValue:
        throw Blend2DError.invalidString
    case BL_ERROR_DATA_TRUNCATED.rawValue:
        throw Blend2DError.dataTruncated
    case BL_ERROR_DATA_TOO_LARGE.rawValue:
        throw Blend2DError.dataTooLarge
    case BL_ERROR_DECOMPRESSION_FAILED.rawValue:
        throw Blend2DError.decompressionFailed
    case BL_ERROR_INVALID_GEOMETRY.rawValue:
        throw Blend2DError.invalidGeometry
    case BL_ERROR_NO_MATCHING_VERTEX.rawValue:
        throw Blend2DError.noMatchingVertex
    case BL_ERROR_NO_MATCHING_COOKIE.rawValue:
        throw Blend2DError.noMatchingCookie
    case BL_ERROR_NO_STATES_TO_RESTORE.rawValue:
        throw Blend2DError.noStatesToRestore
    case BL_ERROR_IMAGE_TOO_LARGE.rawValue:
        throw Blend2DError.imageTooLarge
    case BL_ERROR_IMAGE_NO_MATCHING_CODEC.rawValue:
        throw Blend2DError.imageNoMatchingCodec
    case BL_ERROR_IMAGE_UNKNOWN_FILE_FORMAT.rawValue:
        throw Blend2DError.imageUnknownFileFormat
    case BL_ERROR_IMAGE_DECODER_NOT_PROVIDED.rawValue:
        throw Blend2DError.imageDecoderNotProvided
    case BL_ERROR_IMAGE_ENCODER_NOT_PROVIDED.rawValue:
        throw Blend2DError.imageEncoderNotProvided
    case BL_ERROR_PNG_MULTIPLE_IHDR.rawValue:
        throw Blend2DError.pngMultipleIhdr
    case BL_ERROR_PNG_INVALID_IDAT.rawValue:
        throw Blend2DError.pngInvalidIdat
    case BL_ERROR_PNG_INVALID_IEND.rawValue:
        throw Blend2DError.pngInvalidIend
    case BL_ERROR_PNG_INVALID_PLTE.rawValue:
        throw Blend2DError.pngInvalidPlte
    case BL_ERROR_PNG_INVALID_TRNS.rawValue:
        throw Blend2DError.pngInvalidTrns
    case BL_ERROR_PNG_INVALID_FILTER.rawValue:
        throw Blend2DError.pngInvalidFilter
    case BL_ERROR_JPEG_UNSUPPORTED_FEATURE.rawValue:
        throw Blend2DError.jpegUnsupportedFeature
    case BL_ERROR_JPEG_INVALID_SOS.rawValue:
        throw Blend2DError.jpegInvalidSos
    case BL_ERROR_JPEG_INVALID_SOF.rawValue:
        throw Blend2DError.jpegInvalidSof
    case BL_ERROR_JPEG_MULTIPLE_SOF.rawValue:
        throw Blend2DError.jpegMultipleSof
    case BL_ERROR_JPEG_UNSUPPORTED_SOF.rawValue:
        throw Blend2DError.jpegUnsupportedSof
    case BL_ERROR_FONT_NO_CHARACTER_MAPPING.rawValue:
        throw Blend2DError.fontNoCharacterMapping
    case BL_ERROR_FONT_MISSING_IMPORTANT_TABLE.rawValue:
        throw Blend2DError.fontMissingImportantTable
    case BL_ERROR_FONT_FEATURE_NOT_AVAILABLE.rawValue:
        throw Blend2DError.fontFeatureNotAvailable
    case BL_ERROR_FONT_CFF_INVALID_DATA.rawValue:
        throw Blend2DError.fontCffInvalidData
    case BL_ERROR_FONT_PROGRAM_TERMINATED.rawValue:
        throw Blend2DError.fontProgramTerminated
    case BL_ERROR_INVALID_GLYPH.rawValue:
        throw Blend2DError.invalidGlyph
        
    // TODO: Throw an unknownError
    default:
        return
    }
}
