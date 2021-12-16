// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// \ingroup blend2d_api_globals
/// 
/// Blend2D result code.
public extension BLResultCode {
    /// Successful result code.
    static let success = BL_SUCCESS
    
    static let errorStartIndex = BL_ERROR_START_INDEX
    
    /// Out of memory                 [ENOMEM].
    static let errorOutOfMemory = BL_ERROR_OUT_OF_MEMORY
    
    /// Invalid value/argument        [EINVAL].
    static let errorInvalidValue = BL_ERROR_INVALID_VALUE
    
    /// Invalid state                 [EFAULT].
    static let errorInvalidState = BL_ERROR_INVALID_STATE
    
    /// Invalid handle or file.       [EBADF].
    static let errorInvalidHandle = BL_ERROR_INVALID_HANDLE
    
    /// Invalid conversion.
    static let errorInvalidConversion = BL_ERROR_INVALID_CONVERSION
    
    /// Overflow or value too large   [EOVERFLOW].
    static let errorOverflow = BL_ERROR_OVERFLOW
    
    /// Object not initialized.
    static let errorNotInitialized = BL_ERROR_NOT_INITIALIZED
    
    /// Not implemented               [ENOSYS].
    static let errorNotImplemented = BL_ERROR_NOT_IMPLEMENTED
    
    /// Operation not permitted       [EPERM].
    static let errorNotPermitted = BL_ERROR_NOT_PERMITTED
    
    /// IO error                      [EIO].
    static let errorIo = BL_ERROR_IO
    
    /// Device or resource busy       [EBUSY].
    static let errorBusy = BL_ERROR_BUSY
    
    /// Operation interrupted         [EINTR].
    static let errorInterrupted = BL_ERROR_INTERRUPTED
    
    /// Try again                     [EAGAIN].
    static let errorTryAgain = BL_ERROR_TRY_AGAIN
    
    /// Timed out                     [ETIMEDOUT].
    static let errorTimedOut = BL_ERROR_TIMED_OUT
    
    /// Broken pipe                   [EPIPE].
    static let errorBrokenPipe = BL_ERROR_BROKEN_PIPE
    
    /// File is not seekable          [ESPIPE].
    static let errorInvalidSeek = BL_ERROR_INVALID_SEEK
    
    /// Too many levels of symlinks   [ELOOP].
    static let errorSymlinkLoop = BL_ERROR_SYMLINK_LOOP
    
    /// File is too large             [EFBIG].
    static let errorFileTooLarge = BL_ERROR_FILE_TOO_LARGE
    
    /// File/directory already exists [EEXIST].
    static let errorAlreadyExists = BL_ERROR_ALREADY_EXISTS
    
    /// Access denied                 [EACCES].
    static let errorAccessDenied = BL_ERROR_ACCESS_DENIED
    
    /// Media changed                 [Windows::ERROR_MEDIA_CHANGED].
    static let errorMediaChanged = BL_ERROR_MEDIA_CHANGED
    
    /// The file/FS is read-only      [EROFS].
    static let errorReadOnlyFs = BL_ERROR_READ_ONLY_FS
    
    /// Device doesn't exist          [ENXIO].
    static let errorNoDevice = BL_ERROR_NO_DEVICE
    
    /// Not found, no entry (fs)      [ENOENT].
    static let errorNoEntry = BL_ERROR_NO_ENTRY
    
    /// No media in drive/device      [ENOMEDIUM].
    static let errorNoMedia = BL_ERROR_NO_MEDIA
    
    /// No more data / end of file    [ENODATA].
    static let errorNoMoreData = BL_ERROR_NO_MORE_DATA
    
    /// No more files                 [ENMFILE].
    static let errorNoMoreFiles = BL_ERROR_NO_MORE_FILES
    
    /// No space left on device       [ENOSPC].
    static let errorNoSpaceLeft = BL_ERROR_NO_SPACE_LEFT
    
    /// Directory is not empty        [ENOTEMPTY].
    static let errorNotEmpty = BL_ERROR_NOT_EMPTY
    
    /// Not a file                    [EISDIR].
    static let errorNotFile = BL_ERROR_NOT_FILE
    
    /// Not a directory               [ENOTDIR].
    static let errorNotDirectory = BL_ERROR_NOT_DIRECTORY
    
    /// Not same device               [EXDEV].
    static let errorNotSameDevice = BL_ERROR_NOT_SAME_DEVICE
    
    /// Not a block device            [ENOTBLK].
    static let errorNotBlockDevice = BL_ERROR_NOT_BLOCK_DEVICE
    
    /// File/path name is invalid     [n/a].
    static let errorInvalidFileName = BL_ERROR_INVALID_FILE_NAME
    
    /// File/path name is too long    [ENAMETOOLONG].
    static let errorFileNameTooLong = BL_ERROR_FILE_NAME_TOO_LONG
    
    /// Too many open files           [EMFILE].
    static let errorTooManyOpenFiles = BL_ERROR_TOO_MANY_OPEN_FILES
    
    /// Too many open files by OS     [ENFILE].
    static let errorTooManyOpenFilesByOs = BL_ERROR_TOO_MANY_OPEN_FILES_BY_OS
    
    /// Too many symbolic links on FS [EMLINK].
    static let errorTooManyLinks = BL_ERROR_TOO_MANY_LINKS
    
    /// Too many threads              [EAGAIN].
    static let errorTooManyThreads = BL_ERROR_TOO_MANY_THREADS
    
    /// Thread pool is exhausted and couldn't acquire the requested thread count.
    static let errorThreadPoolExhausted = BL_ERROR_THREAD_POOL_EXHAUSTED
    
    /// File is empty (not specific to any OS error).
    static let errorFileEmpty = BL_ERROR_FILE_EMPTY
    
    /// File open failed              [Windows::ERROR_OPEN_FAILED].
    static let errorOpenFailed = BL_ERROR_OPEN_FAILED
    
    /// Not a root device/directory   [Windows::ERROR_DIR_NOT_ROOT].
    static let errorNotRootDevice = BL_ERROR_NOT_ROOT_DEVICE
    
    /// Unknown system error that failed to translate to Blend2D result code.
    static let errorUnknownSystemError = BL_ERROR_UNKNOWN_SYSTEM_ERROR
    
    /// Invalid data alignment.
    static let errorInvalidAlignment = BL_ERROR_INVALID_ALIGNMENT
    
    /// Invalid data signature or header.
    static let errorInvalidSignature = BL_ERROR_INVALID_SIGNATURE
    
    /// Invalid or corrupted data.
    static let errorInvalidData = BL_ERROR_INVALID_DATA
    
    /// Invalid string (invalid data of either UTF8, UTF16, or UTF32).
    static let errorInvalidString = BL_ERROR_INVALID_STRING
    
    /// Invalid key or property.
    static let errorInvalidKey = BL_ERROR_INVALID_KEY
    
    /// Truncated data (more data required than memory/stream provides).
    static let errorDataTruncated = BL_ERROR_DATA_TRUNCATED
    
    /// Input data too large to be processed.
    static let errorDataTooLarge = BL_ERROR_DATA_TOO_LARGE
    
    /// Decompression failed due to invalid data (RLE, Huffman, etc).
    static let errorDecompressionFailed = BL_ERROR_DECOMPRESSION_FAILED
    
    /// Invalid geometry (invalid path data or shape).
    static let errorInvalidGeometry = BL_ERROR_INVALID_GEOMETRY
    
    /// Returned when there is no matching vertex in path data.
    static let errorNoMatchingVertex = BL_ERROR_NO_MATCHING_VERTEX
    
    /// Invalid create flags (BLContext).
    static let errorInvalidCreateFlags = BL_ERROR_INVALID_CREATE_FLAGS
    
    /// No matching cookie (BLContext).
    static let errorNoMatchingCookie = BL_ERROR_NO_MATCHING_COOKIE
    
    /// No states to restore (BLContext).
    static let errorNoStatesToRestore = BL_ERROR_NO_STATES_TO_RESTORE
    
    /// The size of the image is too large.
    static let errorImageTooLarge = BL_ERROR_IMAGE_TOO_LARGE
    
    /// Image codec for a required format doesn't exist.
    static let errorImageNoMatchingCodec = BL_ERROR_IMAGE_NO_MATCHING_CODEC
    
    /// Unknown or invalid file format that cannot be read.
    static let errorImageUnknownFileFormat = BL_ERROR_IMAGE_UNKNOWN_FILE_FORMAT
    
    /// Image codec doesn't support reading the file format.
    static let errorImageDecoderNotProvided = BL_ERROR_IMAGE_DECODER_NOT_PROVIDED
    
    /// Image codec doesn't support writing the file format.
    static let errorImageEncoderNotProvided = BL_ERROR_IMAGE_ENCODER_NOT_PROVIDED
    
    /// Multiple IHDR chunks are not allowed (PNG).
    static let errorPngMultipleIhdr = BL_ERROR_PNG_MULTIPLE_IHDR
    
    /// Invalid IDAT chunk (PNG).
    static let errorPngInvalidIdat = BL_ERROR_PNG_INVALID_IDAT
    
    /// Invalid IEND chunk (PNG).
    static let errorPngInvalidIend = BL_ERROR_PNG_INVALID_IEND
    
    /// Invalid PLTE chunk (PNG).
    static let errorPngInvalidPlte = BL_ERROR_PNG_INVALID_PLTE
    
    /// Invalid tRNS chunk (PNG).
    static let errorPngInvalidTrns = BL_ERROR_PNG_INVALID_TRNS
    
    /// Invalid filter type (PNG).
    static let errorPngInvalidFilter = BL_ERROR_PNG_INVALID_FILTER
    
    /// Unsupported feature (JPEG).
    static let errorJpegUnsupportedFeature = BL_ERROR_JPEG_UNSUPPORTED_FEATURE
    
    /// Invalid SOS marker or header (JPEG).
    static let errorJpegInvalidSos = BL_ERROR_JPEG_INVALID_SOS
    
    /// Invalid SOF marker (JPEG).
    static let errorJpegInvalidSof = BL_ERROR_JPEG_INVALID_SOF
    
    /// Multiple SOF markers (JPEG).
    static let errorJpegMultipleSof = BL_ERROR_JPEG_MULTIPLE_SOF
    
    /// Unsupported SOF marker (JPEG).
    static let errorJpegUnsupportedSof = BL_ERROR_JPEG_UNSUPPORTED_SOF
    
    /// Font doesn't have any data as it's not initialized.
    static let errorFontNotInitialized = BL_ERROR_FONT_NOT_INITIALIZED
    
    /// Font or font-face was not matched (BLFontManager).
    static let errorFontNoMatch = BL_ERROR_FONT_NO_MATCH
    
    /// Font has no character to glyph mapping data.
    static let errorFontNoCharacterMapping = BL_ERROR_FONT_NO_CHARACTER_MAPPING
    
    /// Font has missing an important table.
    static let errorFontMissingImportantTable = BL_ERROR_FONT_MISSING_IMPORTANT_TABLE
    
    /// Font feature is not available.
    static let errorFontFeatureNotAvailable = BL_ERROR_FONT_FEATURE_NOT_AVAILABLE
    
    /// Font has an invalid CFF data.
    static let errorFontCffInvalidData = BL_ERROR_FONT_CFF_INVALID_DATA
    
    /// Font program terminated because the execution reached the limit.
    static let errorFontProgramTerminated = BL_ERROR_FONT_PROGRAM_TERMINATED
    
    /// Invalid glyph identifier.
    static let errorInvalidGlyph = BL_ERROR_INVALID_GLYPH
}
