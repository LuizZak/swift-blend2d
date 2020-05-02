import blend2d

extension BLResultCode: Error { }
public extension BLResultCode {
    /// Successful result code.
    static let success = BL_SUCCESS

    static let startIndex = BL_ERROR_START_INDEX

    /// Out of memory                 [ENOMEM].
    static let outOfMemory = BL_ERROR_OUT_OF_MEMORY
    /// Invalid value/argument        [EINVAL].
    static let invalidValue = BL_ERROR_INVALID_VALUE
    /// Invalid state                 [EFAULT].
    static let invalidState = BL_ERROR_INVALID_STATE
    /// Invalid handle or file.       [EBADF].
    static let invalidHandle = BL_ERROR_INVALID_HANDLE
    /// Value too large               [EOVERFLOW].
    static let valueTooLarge = BL_ERROR_VALUE_TOO_LARGE
    /// Not initialized (some instance is built-in none when it shouldn't be).
    static let notInitialized = BL_ERROR_NOT_INITIALIZED
    /// Not implemented               [ENOSYS].
    static let notImplemented = BL_ERROR_NOT_IMPLEMENTED
    /// Operation not permitted       [EPERM].
    static let notPermitted = BL_ERROR_NOT_PERMITTED

    /// IO error                      [EIO].
    static let io = BL_ERROR_IO
    /// Device or resource busy       [EBUSY].
    static let busy = BL_ERROR_BUSY
    /// Operation interrupted         [EINTR].
    static let interrupted = BL_ERROR_INTERRUPTED
    /// Try again                     [EAGAIN].
    static let tryAgain = BL_ERROR_TRY_AGAIN
    /// Timed out                     [ETIMEDOUT].
    static let timedOut = BL_ERROR_TIMED_OUT
    /// Broken pipe                   [EPIPE].
    static let brokenPipe = BL_ERROR_BROKEN_PIPE
    /// File is not seekable          [ESPIPE].
    static let invalidSeek = BL_ERROR_INVALID_SEEK
    /// Too many levels of symlinks   [ELOOP].
    static let symlinkLoop = BL_ERROR_SYMLINK_LOOP
    /// File is too large             [EFBIG].
    static let fileTooLarge = BL_ERROR_FILE_TOO_LARGE
    /// File/directory already exists [EEXIST].
    static let alreadyExists = BL_ERROR_ALREADY_EXISTS
    /// Access denied                 [EACCES].
    static let accessDenied = BL_ERROR_ACCESS_DENIED
    /// Media changed                 [Windows::ERROR_MEDIA_CHANGED].
    static let mediaChanged = BL_ERROR_MEDIA_CHANGED
    /// The file/FS is read-only      [EROFS].
    static let readOnlyFs = BL_ERROR_READ_ONLY_FS
    /// Device doesn't exist          [ENXIO].
    static let noDevice = BL_ERROR_NO_DEVICE
    /// Not found no entry (fs)      [ENOENT].
    static let noEntry = BL_ERROR_NO_ENTRY
    /// No media in drive/device      [ENOMEDIUM].
    static let noMedia = BL_ERROR_NO_MEDIA
    /// No more data / end of file    [ENODATA].
    static let noMoreData = BL_ERROR_NO_MORE_DATA
    /// No more files                 [ENMFILE].
    static let noMoreFiles = BL_ERROR_NO_MORE_FILES
    /// No space left on device       [ENOSPC].
    static let noSpaceLeft = BL_ERROR_NO_SPACE_LEFT
    /// Directory is not empty        [ENOTEMPTY].
    static let notEmpty = BL_ERROR_NOT_EMPTY
    /// Not a file                    [EISDIR].
    static let notFile = BL_ERROR_NOT_FILE
    /// Not a directory               [ENOTDIR].
    static let notDirectory = BL_ERROR_NOT_DIRECTORY
    /// Not same device               [EXDEV].
    static let notSameDevice = BL_ERROR_NOT_SAME_DEVICE
    /// Not a block device            [ENOTBLK].
    static let notBlockDevice = BL_ERROR_NOT_BLOCK_DEVICE

    /// File/path name is invalid     [n/a].
    static let invalidFileName = BL_ERROR_INVALID_FILE_NAME
    /// File/path name is too long    [ENAMETOOLONG].
    static let fileNameTooLong = BL_ERROR_FILE_NAME_TOO_LONG

    /// Too many open files           [EMFILE].
    static let tooManyOpenFiles = BL_ERROR_TOO_MANY_OPEN_FILES
    /// Too many open files by OS     [ENFILE].
    static let tooManyOpenFilesByOs = BL_ERROR_TOO_MANY_OPEN_FILES_BY_OS
    /// Too many symbolic links on FS [EMLINK].
    static let tooManyLinks = BL_ERROR_TOO_MANY_LINKS
    /// Too many threads              [EAGAIN].
    static let tooManyThreads = BL_ERROR_TOO_MANY_THREADS

    /// File is empty (not specific to any OS error).
    static let fileEmpty = BL_ERROR_FILE_EMPTY
    /// File open failed              [Windows::ERROR_OPEN_FAILED].
    static let openFailed = BL_ERROR_OPEN_FAILED
    /// Not a root device/directory   [Windows::ERROR_DIR_NOT_ROOT].
    static let notRootDevice = BL_ERROR_NOT_ROOT_DEVICE

    /// Unknown system error that failed to translate to Blend2D result code.
    static let unknownSystemError = BL_ERROR_UNKNOWN_SYSTEM_ERROR

    /// Invalid data alignment.
    static let invalidAlignment = BL_ERROR_INVALID_ALIGNMENT
    /// Invalid data signature or header.
    static let invalidSignature = BL_ERROR_INVALID_SIGNATURE
    /// Invalid or corrupted data.
    static let invalidData = BL_ERROR_INVALID_DATA
    /// Invalid string (invalid data of either UTF8, UTF16, or UTF32).
    static let invalidString = BL_ERROR_INVALID_STRING
    /// Truncated data (more data required than memory/stream provides).
    static let dataTruncated = BL_ERROR_DATA_TRUNCATED
    /// Input data too large to be processed.
    static let dataTooLarge = BL_ERROR_DATA_TOO_LARGE
    /// Decompression failed due to invalid data (RLE, Huffman, etc).
    static let decompressionFailed = BL_ERROR_DECOMPRESSION_FAILED

    /// Invalid geometry (invalid path data or shape).
    static let invalidGeometry = BL_ERROR_INVALID_GEOMETRY
    /// Returned when there is no matching vertex in path data.
    static let noMatchingVertex = BL_ERROR_NO_MATCHING_VERTEX

    /// No matching cookie (BLContext).
    static let noMatchingCookie = BL_ERROR_NO_MATCHING_COOKIE
    /// No states to restore (BLContext).
    static let noStatesToRestore = BL_ERROR_NO_STATES_TO_RESTORE

    /// The size of the image is too large.
    static let imageTooLarge = BL_ERROR_IMAGE_TOO_LARGE
    /// Image codec for a required format doesn't exist.
    static let imageNoMatchingCodec = BL_ERROR_IMAGE_NO_MATCHING_CODEC
    /// Unknown or invalid file format that cannot be read.
    static let imageUnknownFileFormat = BL_ERROR_IMAGE_UNKNOWN_FILE_FORMAT
    /// Image codec doesn't support reading the file format.
    static let imageDecoderNotProvided = BL_ERROR_IMAGE_DECODER_NOT_PROVIDED
    /// Image codec doesn't support writing the file format.
    static let imageEncoderNotProvided = BL_ERROR_IMAGE_ENCODER_NOT_PROVIDED

    /// Multiple IHDR chunks are not allowed (PNG).
    static let pngMultipleIhdr = BL_ERROR_PNG_MULTIPLE_IHDR
    /// Invalid IDAT chunk (PNG).
    static let pngInvalidIdat = BL_ERROR_PNG_INVALID_IDAT
    /// Invalid IEND chunk (PNG).
    static let pngInvalidIend = BL_ERROR_PNG_INVALID_IEND
    /// Invalid PLTE chunk (PNG).
    static let pngInvalidPlte = BL_ERROR_PNG_INVALID_PLTE
    /// Invalid tRNS chunk (PNG).
    static let pngInvalidTrns = BL_ERROR_PNG_INVALID_TRNS
    /// Invalid filter type (PNG).
    static let pngInvalidFilter = BL_ERROR_PNG_INVALID_FILTER

    /// Unsupported feature (JPEG).
    static let jpegUnsupportedFeature = BL_ERROR_JPEG_UNSUPPORTED_FEATURE
    /// Invalid SOS marker or header (JPEG).
    static let jpegInvalidSos = BL_ERROR_JPEG_INVALID_SOS
    /// Invalid SOF marker (JPEG).
    static let jpegInvalidSof = BL_ERROR_JPEG_INVALID_SOF
    /// Multiple SOF markers (JPEG).
    static let jpegMultipleSof = BL_ERROR_JPEG_MULTIPLE_SOF
    /// Unsupported SOF marker (JPEG).
    static let jpegUnsupportedSof = BL_ERROR_JPEG_UNSUPPORTED_SOF

    /// Font doesn't have any data as it's not initialized.
    static let fontNotInitialized = BL_ERROR_FONT_NOT_INITIALIZED
    /// Font or font-face was not matched (BLFontManager).
    static let fontNoMatch = BL_ERROR_FONT_NO_MATCH
    /// Font has no character to glyph mapping data.
    static let fontNoCharacterMapping = BL_ERROR_FONT_NO_CHARACTER_MAPPING
    /// Font has missing an important table.
    static let fontMissingImportantTable = BL_ERROR_FONT_MISSING_IMPORTANT_TABLE
    /// Font feature is not available.
    static let fontFeatureNotAvailable = BL_ERROR_FONT_FEATURE_NOT_AVAILABLE
    /// Font has an invalid CFF data.
    static let fontCffInvalidData = BL_ERROR_FONT_CFF_INVALID_DATA
    /// Font program terminated because the execution reached the limit.
    static let fontProgramTerminated = BL_ERROR_FONT_PROGRAM_TERMINATED

    /// Invalid glyph identifier.
    static let invalidGlyph = BL_ERROR_INVALID_GLYPH

    var description: String {
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
        case .fontNotInitialized:
            return "Font doesn't have any data as it's not initialized."
        case .fontNoMatch:
            return "Font or font-face was not matched (BLFontManager)."
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
        default:
            return "Unknown error"
        }
    }
}

public extension BLHitTest {
    /// Fully in.
    static let `in` = BL_HIT_TEST_IN
    /// Partially in/out.
    static let partial = BL_HIT_TEST_PART
    /// Fully out.
    static let out = BL_HIT_TEST_OUT
}

public extension BLFillRule {
    /// Non-zero fill-rule.
    static let nonZero = BL_FILL_RULE_NON_ZERO
    /// Even-odd fill-rule.
    static let evenOdd = BL_FILL_RULE_EVEN_ODD
}

public extension BLPathReverseMode {
    /// Reverse each figure and their order as well (default).
    static let complete = BL_PATH_REVERSE_MODE_COMPLETE
    
    /// Reverse each figure separately (keeps their order).
    static let separate = BL_PATH_REVERSE_MODE_SEPARATE
}

public extension BLGeometryDirection {
    /// No direction specified.
    static let none = BL_GEOMETRY_DIRECTION_NONE
    /// Clockwise direction.
    static let cw = BL_GEOMETRY_DIRECTION_CW
    /// Counter-clockwise direction.
    static let ccw = BL_GEOMETRY_DIRECTION_CCW
}

public extension BLStrokeJoin {
    /// Miter-join possibly clipped at `miterLimit` [default].
    static let miterClip = BL_STROKE_JOIN_MITER_CLIP
    /// Miter-join or bevel-join depending on miterLimit condition.
    static let miterBevel = BL_STROKE_JOIN_MITER_BEVEL
    /// Miter-join or round-join depending on miterLimit condition.
    static let miterRound = BL_STROKE_JOIN_MITER_ROUND
    /// Bevel-join.
    static let bevel = BL_STROKE_JOIN_BEVEL
    /// Round-join.
    static let round = BL_STROKE_JOIN_ROUND
}

public extension BLStrokeCapPosition {
    /// Start of the path.
    static let start = BL_STROKE_CAP_POSITION_START
    /// End of the path.
    static let end = BL_STROKE_CAP_POSITION_END
}

public extension BLStrokeCap {
    /// Butt cap [default].
    static let butt = BL_STROKE_CAP_BUTT
    /// Square cap.
    static let square = BL_STROKE_CAP_SQUARE
    /// Round cap.
    static let round = BL_STROKE_CAP_ROUND
    /// Round cap reversed.
    static let roundReversed = BL_STROKE_CAP_ROUND_REV
    /// Triangle cap.
    static let triangle = BL_STROKE_CAP_TRIANGLE
    /// Triangle cap reversed.
    static let triangleReversed = BL_STROKE_CAP_TRIANGLE_REV
}

public extension BLStrokeTransformOrder {
    /// Transform after stroke  => `Transform(Stroke(Input))` [default].
    static let after = BL_STROKE_TRANSFORM_ORDER_AFTER
    /// Transform before stroke => `Stroke(Transform(Input))`.
    static let before = BL_STROKE_TRANSFORM_ORDER_BEFORE
}

public extension BLGeometryType {
    /// No geometry provided.
    static let none = BL_GEOMETRY_TYPE_NONE
    /// `BLBoxI` struct.
    static let boxI = BL_GEOMETRY_TYPE_BOXI
    /// `BLBox` struct.
    static let boxD = BL_GEOMETRY_TYPE_BOXD
    /// `BLRectI` struct.
    static let rectI = BL_GEOMETRY_TYPE_RECTI
    /// `BLRect` struct.
    static let rectD = BL_GEOMETRY_TYPE_RECTD
    /// `BLCircle` struct.
    static let circle = BL_GEOMETRY_TYPE_CIRCLE
    /// `BLEllipse` struct.
    static let ellipse = BL_GEOMETRY_TYPE_ELLIPSE
    /// `BLRoundRect` struct.
    static let roundRect = BL_GEOMETRY_TYPE_ROUND_RECT
    /// `BLArc` struct.
    static let arc = BL_GEOMETRY_TYPE_ARC
    /// `BLArc` struct representing chord.
    static let chord = BL_GEOMETRY_TYPE_CHORD
    /// `BLArc` struct representing pie.
    static let pie = BL_GEOMETRY_TYPE_PIE
    /// `BLLine` struct.
    static let line = BL_GEOMETRY_TYPE_LINE
    /// `BLTriangle` struct.
    static let triangle = BL_GEOMETRY_TYPE_TRIANGLE
    /// `BLArrayView<BLPointI>` representing a polyline.
    static let polylineI = BL_GEOMETRY_TYPE_POLYLINEI
    /// `BLArrayView<BLPoint>` representing a polyline.
    static let polylineD = BL_GEOMETRY_TYPE_POLYLINED
    /// `BLArrayView<BLPointI>` representing a polygon.
    static let polygonI = BL_GEOMETRY_TYPE_POLYGONI
    /// `BLArrayView<BLPoint>` representing a polygon.
    static let polygonD = BL_GEOMETRY_TYPE_POLYGOND
    /// `BLArrayView<BLBoxI>` struct.
    static let arrayViewBoxI = BL_GEOMETRY_TYPE_ARRAY_VIEW_BOXI
    /// `BLArrayView<BLBox>` struct.
    static let arrayViewBoxD = BL_GEOMETRY_TYPE_ARRAY_VIEW_BOXD
    /// `BLArrayView<BLRectI>` struct.
    static let arrayViewRectI = BL_GEOMETRY_TYPE_ARRAY_VIEW_RECTI
    /// `BLArrayView<BLRect>` struct.
    static let arrayViewRectD = BL_GEOMETRY_TYPE_ARRAY_VIEW_RECTD
    /// `BLPath` (or `BLPathCore`).
    static let path = BL_GEOMETRY_TYPE_PATH
    /// `BLRegion` (or `BLRegionCore`).
    static let region = BL_GEOMETRY_TYPE_REGION
}

public extension BLContextFlushFlags {
    /// Wait for completion (block).
    static let sync = BL_CONTEXT_FLUSH_SYNC
}

public extension BLRenderingQuality {
    /// Render using anti-aliasing.
    static let antialias = BL_RENDERING_QUALITY_ANTIALIAS
}

public extension BLPatternQuality {
    /// Nearest neighbor.
    static let nearestNeighbor = BL_PATTERN_QUALITY_NEAREST
    /// Bilinear.
    static let bilinear = BL_PATTERN_QUALITY_BILINEAR
}

public extension BLGradientQuality {
    /// Nearest neighbor.
    static let nearest = BL_GRADIENT_QUALITY_NEAREST
}

public extension BLFlattenMode {
    /// Use default mode (decided by Blend2D).
    static let `default` = BL_FLATTEN_MODE_DEFAULT
    /// Recursive subdivision flattening.
    static let recursive = BL_FLATTEN_MODE_RECURSIVE
}

public extension BLTextEncoding {
    /// UTF-8 encoding.
    static let utf8 = BL_TEXT_ENCODING_UTF8
    /// UTF-16 encoding (native endian).
    static let utf16 = BL_TEXT_ENCODING_UTF16
    /// UTF-32 encoding (native endian).
    static let utf32 = BL_TEXT_ENCODING_UTF32
    /// LATIN1 encoding (one byte per character).
    static let latin1 = BL_TEXT_ENCODING_LATIN1
    
    /// Platform native `wchar_t` (or Windows `WCHAR`) encoding, alias to
    /// either UTF-32, UTF-16, or UTF-8 depending on `sizeof(wchar_t)`.
    static let wchar = BL_TEXT_ENCODING_WCHAR
}

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
}

public extension BLImplType {
    /// Type is `Null`.
    static let null = BL_IMPL_TYPE_NULL
    
    /// Type is `BLBitArray`.
    static let bitArray = BL_IMPL_TYPE_BIT_ARRAY
    
    /// Type is `BLString`.
    static let string = BL_IMPL_TYPE_STRING
    
    /// Type is `BLArray<T>` where `T` is `BLVariant` or other ref-counted type.
    static let arrayOfVar = BL_IMPL_TYPE_ARRAY_VAR
    
    /// Type is `BLArray<T>` where `T` matches 8-bit signed integral type.
    static let arrayOfInt8 = BL_IMPL_TYPE_ARRAY_I8
    
    /// Type is `BLArray<T>` where `T` matches 8-bit unsigned integral type.
    static let arrayOfUInt8 = BL_IMPL_TYPE_ARRAY_U8
    
    /// Type is `BLArray<T>` where `T` matches 16-bit signed integral type.
    static let arrayOfInt16 = BL_IMPL_TYPE_ARRAY_I16
    
    /// Type is `BLArray<T>` where `T` matches 16-bit unsigned integral type.
    static let arrayOfUInt16 = BL_IMPL_TYPE_ARRAY_U16
    
    /// Type is `BLArray<T>` where `T` matches 32-bit signed integral type.
    static let arrayOfInt32 = BL_IMPL_TYPE_ARRAY_I32
    
    /// Type is `BLArray<T>` where `T` matches 32-bit unsigned integral type.
    static let arrayOfUInt32 = BL_IMPL_TYPE_ARRAY_U32
    
    /// Type is `BLArray<T>` where `T` matches 64-bit signed integral type.
    static let arrayOfInt64 = BL_IMPL_TYPE_ARRAY_I64
    
    /// Type is `BLArray<T>` where `T` matches 64-bit unsigned integral type.
    static let arrayOfUInt64 = BL_IMPL_TYPE_ARRAY_U64
    
    /// Type is `BLArray<T>` where `T` matches 32-bit floating point type.
    static let arrayOfFloat32 = BL_IMPL_TYPE_ARRAY_F32
    
    /// Type is `BLArray<T>` where `T` matches 64-bit floating point type.
    static let arrayOfFloat64 = BL_IMPL_TYPE_ARRAY_F64
    
    /// Type is `BLArray<T>` where `T` is a struct of size 1.
    static let arrayOfStruct_1 = BL_IMPL_TYPE_ARRAY_STRUCT_1
    
    /// Type is `BLArray<T>` where `T` is a struct of size 2.
    static let arrayOfStruct_2 = BL_IMPL_TYPE_ARRAY_STRUCT_2
    
    /// Type is `BLArray<T>` where `T` is a struct of size 3.
    static let arrayOfStruct_3 = BL_IMPL_TYPE_ARRAY_STRUCT_3
    
    /// Type is `BLArray<T>` where `T` is a struct of size 4.
    static let arrayOfStruct_4 = BL_IMPL_TYPE_ARRAY_STRUCT_4
    
    /// Type is `BLArray<T>` where `T` is a struct of size 6.
    static let arrayOfStruct_6 = BL_IMPL_TYPE_ARRAY_STRUCT_6
    
    /// Type is `BLArray<T>` where `T` is a struct of size 8.
    static let arrayOfStruct_8 = BL_IMPL_TYPE_ARRAY_STRUCT_8
    
    /// Type is `BLArray<T>` where `T` is a struct of size 10.
    static let arrayOfStruct_10 = BL_IMPL_TYPE_ARRAY_STRUCT_10
    
    /// Type is `BLArray<T>` where `T` is a struct of size 12.
    static let arrayOfStruct_12 = BL_IMPL_TYPE_ARRAY_STRUCT_12
    
    /// Type is `BLArray<T>` where `T` is a struct of size 16.
    static let arrayOfStruct_16 = BL_IMPL_TYPE_ARRAY_STRUCT_16
    
    /// Type is `BLArray<T>` where `T` is a struct of size 20.
    static let arrayOfStruct_20 = BL_IMPL_TYPE_ARRAY_STRUCT_20
    
    /// Type is `BLArray<T>` where `T` is a struct of size 24.
    static let arrayOfStruct_24 = BL_IMPL_TYPE_ARRAY_STRUCT_24
    
    /// Type is `BLArray<T>` where `T` is a struct of size 32.
    static let arrayOfStruct_32 = BL_IMPL_TYPE_ARRAY_STRUCT_32
    
    /// Type is `BLPath`.
    static let path = BL_IMPL_TYPE_PATH
    
    /// Type is `BLRegion`.
    static let region = BL_IMPL_TYPE_REGION
    
    /// Type is `BLImage`.
    static let image = BL_IMPL_TYPE_IMAGE
    
    /// Type is `BLImageCodec`.
    static let imageCodec = BL_IMPL_TYPE_IMAGE_CODEC
    
    /// Type is `BLImageDecoder`.
    static let imageDecoder = BL_IMPL_TYPE_IMAGE_DECODER
    
    /// Type is `BLImageEncoder`.
    static let imageEncoder = BL_IMPL_TYPE_IMAGE_ENCODER
    
    /// Type is `BLGradient`.
    static let gradient = BL_IMPL_TYPE_GRADIENT
    
    /// Type is `BLPattern`.
    static let pattern = BL_IMPL_TYPE_PATTERN
    
    /// Type is `BLContext`.
    static let context = BL_IMPL_TYPE_CONTEXT
    
    /// Type is `BLFont`.
    static let font = BL_IMPL_TYPE_FONT
    
    /// Type is `BLFontFace`.
    static let fontFace = BL_IMPL_TYPE_FONT_FACE
    
    /// Type is `BLFontData`.
    static let fontData = BL_IMPL_TYPE_FONT_DATA
    
    /// Type is `BLFontManager`.
    static let fontLoader = BL_IMPL_TYPE_FONT_MANAGER
    
    /// Type is `BLFontFeatureOptions`.
    static let fontFeatureOptions = BL_IMPL_TYPE_FONT_FEATURE_OPTIONS
    
    /// Type is `BLFontVariationOptions`.
    static let fontVariationOptions = BL_IMPL_TYPE_FONT_VARIATION_OPTIONS
}

public extension BLImageCodecFeatures {
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

public extension BLFileOpenFlags {
    /// Opens the file for reading.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_RDONLY` (Posix)
    ///   * `GENERIC_READ` (Windows)
    static let openRead = BL_FILE_OPEN_READ
    
    /// Opens the file for writing:
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_WRONLY` (Posix)
    ///   * `GENERIC_WRITE` (Windows)
    static let openWrite = BL_FILE_OPEN_WRITE
    
    /// Opens the file for reading & writing.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_RDWR` (Posix)
    ///   * `GENERIC_READ | GENERIC_WRITE` (Windows)
    static let openRw = BL_FILE_OPEN_RW
    
    /// Creates the file if it doesn't exist or opens it if it does.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_CREAT` (Posix)
    ///   * `CREATE_ALWAYS` or `OPEN_ALWAYS` depending on other flags (Windows)
    static let openCreate = BL_FILE_OPEN_CREATE
    
    /// Opens the file for deleting or renaming (Windows).
    ///
    /// Adds `DELETE` flag when opening the file to `ACCESS_MASK`.
    static let openDelete = BL_FILE_OPEN_DELETE
    
    /// Truncates the file.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_TRUNC` (Posix)
    ///   * `TRUNCATE_EXISTING` (Windows)
    static let openTruncate = BL_FILE_OPEN_TRUNCATE
    
    /// Opens the file for reading in exclusive mode (Windows).
    ///
    /// Exclusive mode means to not specify the `FILE_SHARE_READ` option.
    static let openReadExclusive = BL_FILE_OPEN_READ_EXCLUSIVE
    
    /// Opens the file for writing in exclusive mode (Windows).
    ///
    /// Exclusive mode means to not specify the `FILE_SHARE_WRITE` option.
    static let openWriteExclusive = BL_FILE_OPEN_WRITE_EXCLUSIVE
    
    /// Opens the file for both reading and writing (Windows).
    ///
    /// This is a combination of both `BLFileOpenFlags.openReadExclusive` and
    /// `BLFileOpenFlags.openWriteExclusive`.
    static let openRwExclusive = BL_FILE_OPEN_RW_EXCLUSIVE
    
    /// Creates the file in exclusive mode - fails if the file already exists.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_EXCL` (Posix)
    ///   * `CREATE_NEW` (Windows)
    static let openCreateExclusive = BL_FILE_OPEN_CREATE_EXCLUSIVE
    
    /// Opens the file for deleting or renaming in exclusive mode (Windows).
    ///
    /// Exclusive mode means to not specify the `FILE_SHARE_DELETE` option.
    static let openDeleteExclusive = BL_FILE_OPEN_DELETE_EXCLUSIVE
}

public extension BLFileSeek {
    /// Seek from the beginning of the file (SEEK_SET).
    static let set = BL_FILE_SEEK_SET
    /// Seek from the current position (SEEK_CUR).
    static let cur = BL_FILE_SEEK_CUR
    /// Seek from the end of the file (SEEK_END).
    static let end = BL_FILE_SEEK_END
}

public extension BLMatrix2DOp {
    /// Reset matrix to identity (argument ignored, should be nil).
    static let reset = BL_MATRIX2D_OP_RESET
    /// Assign (copy) the other matrix.
    static let assign = BL_MATRIX2D_OP_ASSIGN
    
    /// Translate the matrix by [x, y].
    static let translate = BL_MATRIX2D_OP_TRANSLATE
    /// Scale the matrix by [x, y].
    static let scale = BL_MATRIX2D_OP_SCALE
    /// Skew the matrix by [x, y].
    static let skew = BL_MATRIX2D_OP_SKEW
    /// Rotate the matrix by the given angle about [0, 0].
    static let rotate = BL_MATRIX2D_OP_ROTATE
    /// Rotate the matrix by the given angle about [x, y].
    static let rotatePt = BL_MATRIX2D_OP_ROTATE_PT
    /// Transform this matrix by other `BLMatrix2D`.
    static let transform = BL_MATRIX2D_OP_TRANSFORM
    
    /// Post-translate the matrix by [x, y].
    static let postTranslate = BL_MATRIX2D_OP_POST_TRANSLATE
    /// Post-scale the matrix by [x, y].
    static let postScale = BL_MATRIX2D_OP_POST_SCALE
    /// Post-skew the matrix by [x, y].
    static let postSkew = BL_MATRIX2D_OP_POST_SKEW
    /// Post-rotate the matrix about [0, 0].
    static let postRotate = BL_MATRIX2D_OP_POST_ROTATE
    /// Post-rotate the matrix about a reference `BLPoint`.
    static let postRotatePt = BL_MATRIX2D_OP_POST_ROTATE_PT
    /// Post-transform this matrix by other `BLMatrix2D`.
    static let postTransform = BL_MATRIX2D_OP_POST_TRANSFORM
}

public extension BLGradientType {
    /// Linear gradient type.
    static let linear = BL_GRADIENT_TYPE_LINEAR
    /// Radial gradient type.
    static let radial = BL_GRADIENT_TYPE_RADIAL
    /// Conical gradient type.
    static let conical = BL_GRADIENT_TYPE_CONICAL
}

public extension BLExtendMode {
    /// Pad extend [default].
    static let pad = BL_EXTEND_MODE_PAD
    /// Repeat extend.
    static let `repeat` = BL_EXTEND_MODE_REPEAT
    /// Reflect extend.
    static let reflect = BL_EXTEND_MODE_REFLECT
    
    /// Alias to `BLExtendMode.pad`.
    static let padXPadY = BL_EXTEND_MODE_PAD_X_PAD_Y
    /// Alias to `BLExtendMode.repeat`.
    static let repeatXRepeatY = BL_EXTEND_MODE_REPEAT_X_REPEAT_Y
    /// Alias to `BLExtendMode.reflect`.
    static let reflectXReflectY = BL_EXTEND_MODE_REFLECT_X_REFLECT_Y
    /// Pad X and repeat Y.
    static let padXRepeatY = BL_EXTEND_MODE_PAD_X_REPEAT_Y
    /// Pad X and reflect Y.
    static let padXReflectY = BL_EXTEND_MODE_PAD_X_REFLECT_Y
    /// Repeat X and pad Y.
    static let repeatXPadY = BL_EXTEND_MODE_REPEAT_X_PAD_Y
    /// Repeat X and reflect Y.
    static let repeatXReflectY = BL_EXTEND_MODE_REPEAT_X_REFLECT_Y
    /// Reflect X and pad Y.
    static let reflectXPadY = BL_EXTEND_MODE_REFLECT_X_PAD_Y
    /// Reflect X and repeat Y.
    static let reflectXRepeatY = BL_EXTEND_MODE_REFLECT_X_REPEAT_Y
}

/// Blend2D runtime limits.
///
/// - note: These constanst are used across Blend2D, but they are not designed
/// to be ABI stable. New versions of Blend2D can increase certain limits without
/// notice. Use runtime to query the limits dynamically, see `BLRuntimeBuildInfo`.
public extension BLRuntimeLimits {
    /// Maximum width and height of an image.
    static let imageSize = BL_RUNTIME_MAX_IMAGE_SIZE
    /// Maximum number of threads for asynchronous operations (including rendering).
    static let threadCount = BL_RUNTIME_MAX_THREAD_COUNT
}

public extension BLRuntimeInfoType {
    /// Blend2D build information.
    static let build = BL_RUNTIME_INFO_TYPE_BUILD
    /// System information (includes CPU architecture, features, cores, etc...).
    static let memory = BL_RUNTIME_INFO_TYPE_MEMORY
    /// Runtime information regarding memory used, reserved, etc...
    static let system = BL_RUNTIME_INFO_TYPE_SYSTEM
}

/// Blend2D runtime build type.
public extension BLRuntimeBuildType {
  /// Describes a Blend2D debug build.
  static let debug = BL_RUNTIME_BUILD_TYPE_DEBUG
  /// Describes a Blend2D release build.
  static let release = BL_RUNTIME_BUILD_TYPE_RELEASE
}

/// CPU architecture that can be queried by `BLRuntime::querySystemInfo()`.
public extension BLRuntimeCpuArch {
    /// Unknown architecture.
    static let unknown = BL_RUNTIME_CPU_ARCH_UNKNOWN
    /// 32-bit or 64-bit X86 architecture.
    static let x86 = BL_RUNTIME_CPU_ARCH_X86
    /// 32-bit or 64-bit ARM architecture.
    static let arm = BL_RUNTIME_CPU_ARCH_ARM
    /// 32-bit or 64-bit MIPS architecture.
    static let mips = BL_RUNTIME_CPU_ARCH_MIPS
}

/// CPU features Blend2D supports.
public extension BLRuntimeCpuFeatures {
    static let x86_sse2 = BL_RUNTIME_CPU_FEATURE_X86_SSE2
    static let x86_sse3 = BL_RUNTIME_CPU_FEATURE_X86_SSE3
    static let x86_ssse3 = BL_RUNTIME_CPU_FEATURE_X86_SSSE3
    static let x86_sse4_1 = BL_RUNTIME_CPU_FEATURE_X86_SSE4_1
    static let x86_sse4_2 = BL_RUNTIME_CPU_FEATURE_X86_SSE4_2
    static let x86_avx = BL_RUNTIME_CPU_FEATURE_X86_AVX
    static let x86_avx2 = BL_RUNTIME_CPU_FEATURE_X86_AVX2
}

/// Runtime cleanup flags that can be used through `BLRuntime::cleanup()`.
public extension BLRuntimeCleanupFlags {
    /// Cleanup object memory pool.
    static let objectPool = BL_RUNTIME_CLEANUP_OBJECT_POOL
    /// Cleanup zeroed memory pool.
    static let zeroedPool = BL_RUNTIME_CLEANUP_ZEROED_POOL
    /// Cleanup thread pool (would join unused threads).
    static let threadPool = BL_RUNTIME_CLEANUP_THREAD_POOL

    /// Cleanup everything.
    static let everything = BL_RUNTIME_CLEANUP_EVERYTHING
}

/// Rendering context type.
public extension BLContextType {
    /// No rendering context.
    static let none = BL_CONTEXT_TYPE_NONE
    /// Dummy rendering context.
    static let dummy = BL_CONTEXT_TYPE_DUMMY
    /// Software-accelerated rendering context.
    static let raster = BL_CONTEXT_TYPE_RASTER
}

public extension BLBooleanOp {
    /// Result = B.
    static let copy = BL_BOOLEAN_OP_COPY
    /// Result = A & B.
    static let and = BL_BOOLEAN_OP_AND
    /// Result = A | B.
    static let or = BL_BOOLEAN_OP_OR
    /// Result = A ^ B.
    static let xor = BL_BOOLEAN_OP_XOR
    /// Result = A - B.
    static let sub = BL_BOOLEAN_OP_SUB
}

public extension BLRegionType {
    /// Region is empty (has no rectangles).
    static let empty = BL_REGION_TYPE_EMPTY
    /// Region has one rectangle (rectangular).
    static let rect = BL_REGION_TYPE_RECT
    /// Region has more YX sorted rectangles.
    static let complex = BL_REGION_TYPE_COMPLEX
}

public extension BLMatrix2DType {
    /// Identity matrix.
    static let identity = BL_MATRIX2D_TYPE_IDENTITY
    /// Has translation part (the rest is like identity).
    static let translate = BL_MATRIX2D_TYPE_TRANSLATE
    /// Has translation and scaling parts.
    static let scale = BL_MATRIX2D_TYPE_SCALE
    /// Has translation and scaling parts, however scaling swaps X/Y.
    static let swap = BL_MATRIX2D_TYPE_SWAP
    /// Generic affine matrix.
    static let affine = BL_MATRIX2D_TYPE_AFFINE
    /// Invalid/degenerate matrix not useful for transformations.
    static let invalid = BL_MATRIX2D_TYPE_INVALID
}

public extension BLImplTraits {
    /// The data this container holds is mutable if `refCount == 1`.
    static let mutable = BL_IMPL_TRAIT_MUTABLE
    /// The data this container holds is always immutable.
    static let immutable = BL_IMPL_TRAIT_IMMUTABLE
    /// Set if the impl uses an external data (data is not part of impl).
    static let external = BL_IMPL_TRAIT_EXTERNAL
    /// Set if the impl was not allocated by `blRuntimeAllocImpl()`.
    static let foreign = BL_IMPL_TRAIT_FOREIGN
    /// Set if the impl provides a virtual function table (first member).
    static let virt = BL_IMPL_TRAIT_VIRT
    /// Set if the impl is a built-in null instance (default constructed).
    static let null = BL_IMPL_TRAIT_NULL
}

public extension BLGradientValue {
    /// x0 - start 'x' for Linear/Radial and center 'x' for Conical.
    static let commonX0 = BL_GRADIENT_VALUE_COMMON_X0
    /// y0 - start 'y' for Linear/Radial and center 'y' for Conical.
    static let commonY0 = BL_GRADIENT_VALUE_COMMON_Y0
    /// x1 - end 'x' for Linear/Radial.
    static let commonX1 = BL_GRADIENT_VALUE_COMMON_X1
    /// y1 - end 'y' for Linear/Radial.
    static let commonY1 = BL_GRADIENT_VALUE_COMMON_Y1
    /// Radial gradient r0 radius.
    static let radialR0 = BL_GRADIENT_VALUE_RADIAL_R0
    /// Conical gradient angle.
    static let conicalAngle = BL_GRADIENT_VALUE_CONICAL_ANGLE
}

public extension BLFormatFlags {
    /// Pixel format provides RGB components.
    static let rgb = BL_FORMAT_FLAG_RGB
    /// Pixel format provides only alpha component.
    static let alpha = BL_FORMAT_FLAG_ALPHA
    /// A combination of `BL_FORMAT_FLAG_RGB | BL_FORMAT_FLAG_ALPHA`.
    static let rgba = BL_FORMAT_FLAG_RGBA
    /// Pixel format provides LUM component (and not RGB components).
    static let lum = BL_FORMAT_FLAG_LUM
    /// A combination of `BL_FORMAT_FLAG_LUM | BL_FORMAT_FLAG_ALPHA`.
    static let luma = BL_FORMAT_FLAG_LUMA
    /// Indexed pixel format the requres a palette (I/O only).
    static let indexed = BL_FORMAT_FLAG_INDEXED
    /// RGB components are premultiplied by alpha component.
    static let premultiplied = BL_FORMAT_FLAG_PREMULTIPLIED
    /// Pixel format doesn't use native byte-order (I/O only).
    static let byteSwap = BL_FORMAT_FLAG_BYTE_SWAP
    
    // The following flags are only informative. They are part of `blFormatInfo[]`,
    // but doesn't have to be passed to `BLPixelConverter` as they can be easily
    // calculated.
    
    /// Pixel components are byte aligned (all 8bpp).
    static let byteAligned = BL_FORMAT_FLAG_BYTE_ALIGNED
}

public extension BLCompOp {
    /// Source-over [default].
    static let sourceOver = BL_COMP_OP_SRC_OVER
    /// Source-copy.
    static let sourceCopy = BL_COMP_OP_SRC_COPY
    /// Source-in.
    static let sourceIn = BL_COMP_OP_SRC_IN
    /// Source-out.
    static let sourceOut = BL_COMP_OP_SRC_OUT
    /// Source-atop.
    static let sourceAtop = BL_COMP_OP_SRC_ATOP
    /// Destination-over.
    static let destinationOver = BL_COMP_OP_DST_OVER
    /// Destination-copy [nop].
    static let destinationCopy = BL_COMP_OP_DST_COPY
    /// Destination-in.
    static let destinationIn = BL_COMP_OP_DST_IN
    /// Destination-out.
    static let destinationOut = BL_COMP_OP_DST_OUT
    /// Destination-atop.
    static let destinationAtop = BL_COMP_OP_DST_ATOP
    /// Xor.
    static let xor = BL_COMP_OP_XOR
    /// Clear.
    static let clear = BL_COMP_OP_CLEAR
    /// Plus.
    static let plus = BL_COMP_OP_PLUS
    /// Minus.
    static let minus = BL_COMP_OP_MINUS
    /// Modulate.
    static let modulate = BL_COMP_OP_MODULATE
    /// Multiply.
    static let multiply = BL_COMP_OP_MULTIPLY
    /// Screen.
    static let screen = BL_COMP_OP_SCREEN
    /// Overlay.
    static let overlay = BL_COMP_OP_OVERLAY
    /// Darken.
    static let darken = BL_COMP_OP_DARKEN
    /// Lighten.
    static let lighten = BL_COMP_OP_LIGHTEN
    /// Color dodge.
    static let colorDodge = BL_COMP_OP_COLOR_DODGE
    /// Color burn.
    static let colorBurn = BL_COMP_OP_COLOR_BURN
    /// Linear burn.
    static let linearBurn = BL_COMP_OP_LINEAR_BURN
    /// Linear light.
    static let linearLight = BL_COMP_OP_LINEAR_LIGHT
    /// Pin light.
    static let pinLight = BL_COMP_OP_PIN_LIGHT
    /// Hard-light.
    static let hardLight = BL_COMP_OP_HARD_LIGHT
    /// Soft-light.
    static let softLight = BL_COMP_OP_SOFT_LIGHT
    /// Difference.
    static let difference = BL_COMP_OP_DIFFERENCE
    /// Exclusion.
    static let exclusion = BL_COMP_OP_EXCLUSION
}

public extension BLFormat {
    /// None or invalid pixel format.
    static let none = BL_FORMAT_NONE
    /// 32-bit premultiplied ARGB pixel format (8-bit components).
    static let prgb32 = BL_FORMAT_PRGB32
    /// 32-bit (X)RGB pixel format (8-bit components, alpha ignored).
    static let xrgb32 = BL_FORMAT_XRGB32
    /// 8-bit alpha-only pixel format.
    static let a8 = BL_FORMAT_A8
}

public extension BLContextHint {
    /// Rendering quality.
    static let renderingQuality = BL_CONTEXT_HINT_RENDERING_QUALITY
    /// Gradient quality.
    static let gradientQuality = BL_CONTEXT_HINT_GRADIENT_QUALITY
    /// Pattern quality.
    static let patternQuality = BL_CONTEXT_HINT_PATTERN_QUALITY
}

public extension BLContextOpType {
    /// Fill operation type.
    static let fill = BL_CONTEXT_OP_TYPE_FILL
    /// Stroke operation type.
    static let stroke = BL_CONTEXT_OP_TYPE_STROKE
}

public extension BLStyleType {
    /// No style, nothing will be paint.
    static let none = BL_STYLE_TYPE_NONE
    /// Solid color style.
    static let solid = BL_STYLE_TYPE_SOLID
    /// Pattern style.
    static let pattern = BL_STYLE_TYPE_PATTERN
    /// Gradient style.
    static let gradient = BL_STYLE_TYPE_GRADIENT
}

public extension BLByteOrder {
    /// Little endian byte-order.
    static let le = BL_BYTE_ORDER_LE
    /// Big endian byte-order.
    static let be = BL_BYTE_ORDER_BE
    
    /// Native (host) byte-order.
    static let native = BL_BYTE_ORDER_NATIVE
    /// Swapped byte-order (BE if host is LE and vice versa).
    static let swapped = BL_BYTE_ORDER_SWAPPED
}

public extension BLFontStyle {
    /// Normal style.
    static let normal = BL_FONT_STYLE_NORMAL
    /// Oblique.
    static let oblique = BL_FONT_STYLE_OBLIQUE
    /// Italic.
    static let italic = BL_FONT_STYLE_ITALIC
}

public extension BLFontStretch {
    /// Ultra condensed stretch.
    static let ultraCondensed = BL_FONT_STRETCH_ULTRA_CONDENSED
    /// Extra condensed stretch.
    static let extraCondensed = BL_FONT_STRETCH_EXTRA_CONDENSED
    /// Condensed stretch.
    static let condensed = BL_FONT_STRETCH_CONDENSED
    /// Semi condensed stretch.
    static let semiCondensed = BL_FONT_STRETCH_SEMI_CONDENSED
    /// Normal stretch.
    static let normal = BL_FONT_STRETCH_NORMAL
    /// Semi expanded stretch.
    static let semiExpanded = BL_FONT_STRETCH_SEMI_EXPANDED
    /// Expanded stretch.
    static let expanded = BL_FONT_STRETCH_EXPANDED
    /// Extra expanded stretch.
    static let extraExpanded = BL_FONT_STRETCH_EXTRA_EXPANDED
    /// Ultra expanded stretch.
    static let ultraExpanded = BL_FONT_STRETCH_ULTRA_EXPANDED
}

public extension BLFontWeight {
    /// Thin weight (100).
    static let thin = BL_FONT_WEIGHT_THIN
    /// Extra light weight (200).
    static let extraLight = BL_FONT_WEIGHT_EXTRA_LIGHT
    /// Light weight (300).
    static let light = BL_FONT_WEIGHT_LIGHT
    /// Semi light weight (350).
    static let semiLight = BL_FONT_WEIGHT_SEMI_LIGHT
    /// Normal weight (400).
    static let normal = BL_FONT_WEIGHT_NORMAL
    /// Medium weight (500).
    static let medium = BL_FONT_WEIGHT_MEDIUM
    /// Semi bold weight (600).
    static let semiBold = BL_FONT_WEIGHT_SEMI_BOLD
    /// Bold weight (700).
    static let bold = BL_FONT_WEIGHT_BOLD
    /// Extra bold weight (800).
    static let extraBold = BL_FONT_WEIGHT_EXTRA_BOLD
    /// Black weight (900).
    static let black = BL_FONT_WEIGHT_BLACK
    /// Extra black weight (950).
    static let extraBlack = BL_FONT_WEIGHT_EXTRA_BLACK
}

public extension BLFontFaceType {
    /// None or unknown font type.
    static let none = BL_FONT_FACE_TYPE_NONE
    /// TrueType/OpenType font type.
    static let openType = BL_FONT_FACE_TYPE_OPENTYPE
}

public extension BLFontFaceFlags {
    /// Font uses typographic family and subfamily names.
    static let typographicNames = BL_FONT_FACE_FLAG_TYPOGRAPHIC_NAMES
    /// Font uses typographic metrics.
    static let typographicMetrics = BL_FONT_FACE_FLAG_TYPOGRAPHIC_METRICS
    /// Character to glyph mapping is available.
    static let charToGlyphMapping = BL_FONT_FACE_FLAG_CHAR_TO_GLYPH_MAPPING
    /// Horizontal glyph metrics (advances, side bearings) is available.
    static let horizontalMetircs = BL_FONT_FACE_FLAG_HORIZONTAL_METIRCS
    /// Vertical glyph metrics (advances, side bearings) is available.
    static let verticalMetrics = BL_FONT_FACE_FLAG_VERTICAL_METRICS
    /// Legacy horizontal kerning feature ('kern' table with horizontal kerning data).
    static let horizontalKerning = BL_FONT_FACE_FLAG_HORIZONTAL_KERNING
    /// Legacy vertical kerning feature ('kern' table with vertical kerning data).
    static let verticalKerning = BL_FONT_FACE_FLAG_VERTICAL_KERNING
    /// OpenType features (GDEF, GPOS, GSUB) are available.
    static let opentypeFeatures = BL_FONT_FACE_FLAG_OPENTYPE_FEATURES
    /// OpenType BLFont Variations feature is available.
    static let opentypeVariations = BL_FONT_FACE_FLAG_OPENTYPE_VARIATIONS
    /// Panose classification is available.
    static let panoseData = BL_FONT_FACE_FLAG_PANOSE_DATA
    /// Unicode coverage information is available.
    static let unicodeCoverage = BL_FONT_FACE_FLAG_UNICODE_COVERAGE
    /// Unicode variation sequences feature is available.
    static let variationSequences = BL_FONT_FACE_FLAG_VARIATION_SEQUENCES
    /// This is a symbol font.
    static let symbolFont = BL_FONT_FACE_FLAG_SYMBOL_FONT
    /// This is a last resort font.
    static let lastResortFont = BL_FONT_FACE_FLAG_LAST_RESORT_FONT
}

public extension BLFontFaceDiagFlags {
    /// Wront data in 'name' table.
    static let wrongNameData = BL_FONT_FACE_DIAG_WRONG_NAME_DATA
    /// Fixed data read from 'name' table and possibly fixed font family/subfamily name.
    static let fixedNameData = BL_FONT_FACE_DIAG_FIXED_NAME_DATA

    /// Wrong data in 'kern' table [kerning disabled].
    static let wrongKernData = BL_FONT_FACE_DIAG_WRONG_KERN_DATA
    /// Fixed data read from 'kern' table so it can be used.
    static let fixedKernData = BL_FONT_FACE_DIAG_FIXED_KERN_DATA

    /// Wrong data in 'cmap' table.
    static let wrongCmapData = BL_FONT_FACE_DIAG_WRONG_CMAP_DATA
    /// Wrong format in 'cmap' (sub)table.
    static let wrongCmapFormat = BL_FONT_FACE_DIAG_WRONG_CMAP_FORMAT

    /// Wrong data in 'GDEF' table.
    static let wrongGdefData = BL_FONT_FACE_DIAG_WRONG_GDEF_DATA
    /// Wrong data in 'GPOS' table.
    static let wrongGposData = BL_FONT_FACE_DIAG_WRONG_GPOS_DATA
    /// Wrong data in 'GSUB' table.
    static let wrongGsubData = BL_FONT_FACE_DIAG_WRONG_GSUB_DATA
}

public extension BLFontOutlineType {
    /// None.
    static let none = BL_FONT_OUTLINE_TYPE_NONE
    /// Truetype outlines.
    static let truetype = BL_FONT_OUTLINE_TYPE_TRUETYPE
    /// OpenType (CFF) outlines.
    static let cff = BL_FONT_OUTLINE_TYPE_CFF
    /// OpenType (CFF2) outlines (font variations support).
    static let cff2 = BL_FONT_OUTLINE_TYPE_CFF2
}

/// Flags used by `BLPixelConverter::create()` function.
public extension BLPixelConverterCreateFlags {
    /// Specifies that the source palette in `BLFormatInfo` doesn't have to by
    /// copied by `BLPixelConverter`. The caller must ensure that the palette
    /// would stay valid until the pixel converter is destroyed.
    static let dontCopyPallete = BL_PIXEL_CONVERTER_CREATE_FLAG_DONT_COPY_PALETTE

    /// Specifies that the source palette in `BLFormatInfo` is alterable and
    /// the pixel converter can modify it when preparing the conversion. The
    /// modification can be irreversible so only use this flag when you are sure
    /// that the palette passed to `BLPixelConverter::create()` won't be needed
    /// outside of pixel conversion.
    ///
    /// - Note: The flag `BL_PIXEL_CONVERTER_CREATE_FLAG_DONT_COPY_PALETTE` must be
    /// set as well, otherwise this flag would be ignored.
    static let alternablePalette = BL_PIXEL_CONVERTER_CREATE_FLAG_ALTERABLE_PALETTE
    
    /// When there is no built-in conversion betweeb the given pixel formats it's
    /// possible to use an intermediate format that is used during conversion. In
    /// such case the base pixel converter creates two more converters that are
    /// then used internally.
    ///
    /// This option disables such feature - creating a pixel converter would fail
    /// with `BL_ERROR_NOT_IMPLEMENTED` error if direct conversion is not possible.
    static let noMultiStep = BL_PIXEL_CONVERTER_CREATE_FLAG_NO_MULTI_STEP
}

/// Path command.
public extension BLPathCmd {
    /// Move-to command (starts a new figure).
    static let move = BL_PATH_CMD_MOVE
    /// On-path command (interpreted as line-to or the end of a curve).
    static let on = BL_PATH_CMD_ON
    /// Quad-to control point.
    static let quad = BL_PATH_CMD_QUAD
    /// Cubic-to control point (always used as a pair of commands).
    static let cubic = BL_PATH_CMD_CUBIC
    /// Close path.
    static let close = BL_PATH_CMD_CLOSE
    
    /// Count of path commands.
    static let count = BL_PATH_CMD_COUNT
}

/// Path command (never stored in path).
public extension BLPathCmdExtra {
    /// Used by `BLPath.setVertexAt` to preserve the current command value.
    static let preserve = BL_PATH_CMD_PRESERVE
}

/// Path flags.
public extension BLPathFlags {
    /// Path is empty (no commands or close commands only).
    static let empty = BL_PATH_FLAG_EMPTY
    /// Path contains multiple figures.
    static let multiple = BL_PATH_FLAG_MULTIPLE
    /// Path contains quad curves (at least one).
    static let quads = BL_PATH_FLAG_QUADS
    /// Path contains cubic curves (at least one).
    static let cubics = BL_PATH_FLAG_CUBICS
    /// Path is invalid.
    static let invalid = BL_PATH_FLAG_INVALID
    /// Flags are dirty (not reflecting the current status).
    static let dirty = BL_PATH_FLAG_DIRTY
}

/// Placement of glyphs stored in a `BLGlyphRun`.
public extension BLGlyphPlacementType {
    /// No placement (custom handling by `BLPathSinkFunc`).
    static let none = BL_GLYPH_PLACEMENT_TYPE_NONE
    /// Each glyph has a BLGlyphPlacement (advance + offset).
    static let advanceOffset = BL_GLYPH_PLACEMENT_TYPE_ADVANCE_OFFSET
    /// Each glyph has a BLPoint offset in design-space units.
    static let designUnits = BL_GLYPH_PLACEMENT_TYPE_DESIGN_UNITS
    /// Each glyph has a BLPoint offset in user-space units.
    static let userUnits = BL_GLYPH_PLACEMENT_TYPE_USER_UNITS
    /// Each glyph has a BLPoint offset in absolute units.
    static let absoluteUnits = BL_GLYPH_PLACEMENT_TYPE_ABSOLUTE_UNITS
}

public extension BLGlyphRunFlags {
    /// Glyph-run contains USC-4 string and not glyphs (glyph-buffer only).
    static let ucs4Content = BL_GLYPH_RUN_FLAG_UCS4_CONTENT
    /// Glyph-run was created from text that was not a valid unicode.
    static let invalidText = BL_GLYPH_RUN_FLAG_INVALID_TEXT
    /// Not the whole text was mapped to glyphs (contains undefined glyphs).
    static let undefinedGlyphs = BL_GLYPH_RUN_FLAG_UNDEFINED_GLYPHS
    /// Encountered invalid font-data during text / glyph processing.
    static let invalidFontData = BL_GLYPH_RUN_FLAG_INVALID_FONT_DATA
}

public extension BLFontDataFlags {
    /// Font data references a font-collection.
    static let collection = BL_FONT_DATA_FLAG_COLLECTION
}

/// Text direction.
public extension BLTextDirection {
    /// Left-to-right direction.
    static let ltr = BL_TEXT_DIRECTION_LTR
    /// Right-to-left direction.
    static let rtl = BL_TEXT_DIRECTION_RTL
}

/// Text orientation.
public extension BLTextOrientation {
    /// Horizontal orientation.
    static let horizontal = BL_TEXT_ORIENTATION_HORIZONTAL
    /// Vertical orientation.
    static let vertical = BL_TEXT_ORIENTATION_VERTICAL
}

/// Font string identifiers used by OpenType 'name' table.
public extension BLFontStringId {
    /// Copyright notice.
    static let copyrightNotice = BL_FONT_STRING_COPYRIGHT_NOTICE
    /// Font family name.
    static let familyName = BL_FONT_STRING_FAMILY_NAME
    /// Font subfamily name.
    static let subfamilyName = BL_FONT_STRING_SUBFAMILY_NAME
    /// Unique font identifier.
    static let uniqueIdentifier = BL_FONT_STRING_UNIQUE_IDENTIFIER
    /// Full font name that reflects all family and relevant subfamily descriptors.
    static let fullName = BL_FONT_STRING_FULL_NAME
    /// Version string. Should begin with the synta `Version <number>.<number>`.
    static let versionString = BL_FONT_STRING_VERSION_STRING
    /// PostScript name for the font.
    static let postScriptName = BL_FONT_STRING_POST_SCRIPT_NAME
    /// Trademark notice/information for this font.
    static let trademark = BL_FONT_STRING_TRADEMARK
    /// Manufacturer name.
    static let manufacturerName = BL_FONT_STRING_MANUFACTURER_NAME
    /// Name of the designer of the typeface.
    static let designerName = BL_FONT_STRING_DESIGNER_NAME
    /// Description of the typeface.
    static let description = BL_FONT_STRING_DESCRIPTION
    /// URL of font vendor.
    static let vendorUrl = BL_FONT_STRING_VENDOR_URL
    /// URL of typeface designer.
    static let designerUrl = BL_FONT_STRING_DESIGNER_URL
    /// Description of how the font may be legally used.
    static let licenseDescription = BL_FONT_STRING_LICENSE_DESCRIPTION
    /// URL where additional licensing information can be found.
    static let licenseInfoUrl = BL_FONT_STRING_LICENSE_INFO_URL
    /// Reserved.
    static let reserved = BL_FONT_STRING_RESERVED
    /// Typographic family name.
    static let typographicFamilyName = BL_FONT_STRING_TYPOGRAPHIC_FAMILY_NAME
    /// Typographic subfamily name.
    static let typographicSubfamilyName = BL_FONT_STRING_TYPOGRAPHIC_SUBFAMILY_NAME
    /// Compatible full name (MAC only).
    static let compatibleFullName = BL_FONT_STRING_COMPATIBLE_FULL_NAME
    /// Sample text - font name or any other text from the designer.
    static let sampleText = BL_FONT_STRING_SAMPLE_TEXT
    /// PostScript CID findfont name.
    static let postScriptCidName = BL_FONT_STRING_POST_SCRIPT_CID_NAME
    /// WWS family name.
    static let wwsFamilyName = BL_FONT_STRING_WWS_FAMILY_NAME
    /// WWS subfamily name.
    static let wwsSubfamilyName = BL_FONT_STRING_WWS_SUBFAMILY_NAME
    /// Light background palette.
    static let lightBackgroundPalette = BL_FONT_STRING_LIGHT_BACKGROUND_PALETTE
    /// Dark background palette.
    static let darkBackgroundPalette = BL_FONT_STRING_DARK_BACKGROUND_PALETTE
    /// Variations PostScript name prefix.
    static let variationsPostScriptPrefix = BL_FONT_STRING_VARIATIONS_POST_SCRIPT_PREFIX
}

/// Rendering context create-flags.
public extension BLContextCreateFlags {
    /// Fallbacks to a synchronous rendering in case that acquiring threads
    /// from the thread-pool failed. This flag only makes sense when the
    /// asynchronous mode was specified by having `threadCount` greater than 0.
    /// If the rendering context fails to acquire at least one thread it would
    /// fallback to synchronous mode instead of staying asynchronous with no
    /// worker threads, which is possible.
    ///
    /// - note: If this flag is specified with `threadCount == 1` it means to
    /// immedialy fallback to synchronous rendering. It's only practical to
    /// use this flag with 2 threads and higher.
    static let fallbackToSync = BL_CONTEXT_CREATE_FLAG_FALLBACK_TO_SYNC

    /// If this flag is specified and asynchronous rendering is enabled then
    /// the context would create its own isolated thread-pool, which is useful
    /// for debugging purposes.
    ///
    /// Do not use this flag in production as rendering contexts with isolated
    /// thread-pool have to create and destroy all threads they use. This flag
    /// is only useful for testing, debugging, and isolated benchmarking.
    static let isolatedThreadPool = BL_CONTEXT_CREATE_FLAG_ISOLATED_THREAD_POOL

    /// If this flag is specified and JIT pipeline generation enabled then the
    /// rendering context would create its own isolated JIT runtime. which is
    /// useful for debugging purposes. This flag will be ignored if JIT pipeline
    /// generation is either not supported or was disabled by other flags.
    ///
    /// Do not use this flag in production as rendering contexts with isolated
    /// JIT runtime do not use global pipeline cache, that's it, after the
    /// rendering context is destroyed the JIT runtime is destroyed with it with
    /// all compiled pipelines. This flag is only useful for testing, debugging,
    /// and isolated benchmarking.
    static let isolatedJit = BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT

    /// Override CPU features when creating isolated context.
    static let overrideCpuFeatures = BL_CONTEXT_CREATE_FLAG_OVERRIDE_CPU_FEATURES
}

/// Clip mode.
public extension BLClipMode {
    /// Clipping to a rectangle that is aligned to the pixel grid.
    static let alignedRect = BL_CLIP_MODE_ALIGNED_RECT
    /// Clipping to a rectangle that is not aligned to pixel grid.
    static let unalignedRect = BL_CLIP_MODE_UNALIGNED_RECT
    /// Clipping to a non-rectangular area that is defined by using mask.
    static let mask = BL_CLIP_MODE_MASK
}

/// Flags used by `BLImageInfo`.
public extension BLImageInfoFlags {
  /// Progressive mode.
  static let progressive = BL_IMAGE_INFO_FLAG_PROGRESSIVE
}

/// Mode that specifies how to construct offset curves.
public extension BLOffsetMode {
  /// Use default mode (decided by Blend2D).
  static let `default` = BL_OFFSET_MODE_DEFAULT
  /// Iterative offset construction.
  static let iterative = BL_OFFSET_MODE_ITERATIVE
}

extension BLImageCodecFeatures: OptionSet { }
extension BLPathFlags: OptionSet { }
extension BLContextCreateFlags: OptionSet { }
extension BLContextFlushFlags: OptionSet { }
extension BLGlyphRunFlags: OptionSet { }
extension BLFontFaceFlags: OptionSet { }
extension BLFontFaceDiagFlags: OptionSet { }
extension BLFormatFlags: OptionSet { }
extension BLFileOpenFlags: OptionSet { }
extension BLFileReadFlags: OptionSet { }
extension BLFontDataFlags: OptionSet { }
extension BLImageInfoFlags: OptionSet { }
extension BLPixelConverterCreateFlags: OptionSet { }
