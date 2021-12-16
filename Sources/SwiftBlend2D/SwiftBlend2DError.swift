import blend2d

/// Base class for internal Swift-wrapped Blend2D errors.
public class SwiftBlend2DError: Error, CustomStringConvertible {
    public let description: String

    @usableFromInline
    var result: BLResultCode

    @inlinable
    init(description: String, resultCode: BLResultCode) {
        self.description = description
        self.result = resultCode
    }
}

public extension SwiftBlend2DError {
    class FileError: SwiftBlend2DError {
        @inlinable
        public init(filePath: String) {
            super.init(description: "No such file or directory \(filePath)",
                       resultCode: .errorNoEntry)
        }

        @inlinable
        public init(fileNotOpenAtPath filePath: String?) {
            if let filePath = filePath {
                super.init(description: "File is no longer open at path \(filePath)",
                           resultCode: .errorInvalidHandle)
            } else {
                super.init(description: "No file open",
                           resultCode: .errorInvalidHandle)
            }
        }
    }
}

@inlinable
func mapError(_ operation: @escaping () -> BLResult) -> SwiftBlend2DErrorMapper {
    return SwiftBlend2DErrorMapper(operation: operation)
}

@usableFromInline
@discardableResult
func resultToError(_ operation: @autoclosure () -> BLResult) throws -> BLResult {
    let value = operation()
    let statusCode = BLResultCode(BLResultCode.RawValue(value))
    
    if statusCode != .success {
        throw statusCode
    }

    return value
}
