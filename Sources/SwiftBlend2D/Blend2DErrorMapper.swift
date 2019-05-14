import blend2d

@usableFromInline
class Blend2DErrorMapper {
    @usableFromInline
    var assertions: [(() -> Bool, () -> SwiftBlend2DError)] = []
    @usableFromInline
    var mappings: [BLResult: () -> SwiftBlend2DError] = [:]
    @usableFromInline
    let operation: () -> BLResult

    @inlinable
    init(operation: @escaping () -> BLResult) {
        self.operation = operation
    }

    @inlinable
    func asserting(_ assertion: @autoclosure @escaping () -> Bool, swiftError: @autoclosure @escaping () -> SwiftBlend2DError) -> Blend2DErrorMapper {
        assertions.append((assertion, swiftError))
        return self
    }

    @inlinable
    func map(blend2DError errorCode: Blend2DError, swiftError: @autoclosure @escaping () -> SwiftBlend2DError) -> Blend2DErrorMapper {
        mappings[errorCode.resultCode.rawValue] = swiftError
        return self
    }

    /// Adds common error mapping for `BL_ERROR_INVALID_HANDLE` errors for a given
    /// file path.
    ///
    /// If `filePath` is `nil`, a non-specific file error is generated, instead.
    @inlinable
    func addFileErrorMappings(filePath: String?) -> Blend2DErrorMapper {
        return map(blend2DError: .invalidHandle, swiftError: SwiftBlend2DError.FileError(fileNotOpenAtPath: filePath))
    }

    @discardableResult
    func execute() throws -> BLResult {
        // Sanitize values, first
        for (assertion, error) in assertions {
            if !assertion() {
                throw error()
            }
        }

        let result = operation()

        if result == BL_SUCCESS.rawValue {
            return BL_SUCCESS.rawValue
        }

        if let mapping = mappings[result] {
            throw mapping()
        } else if let error = errorForResult(result) {
            throw error
        }

        return result
    }
}
