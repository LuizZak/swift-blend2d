import blend2d

@usableFromInline
class SwiftBlend2DErrorMapper {
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
    func asserting(_ assertion: @autoclosure @escaping () -> Bool, swiftError: @autoclosure @escaping () -> SwiftBlend2DError) -> SwiftBlend2DErrorMapper {
        assertions.append((assertion, swiftError))
        return self
    }

    @inlinable
    func map(blend2DError errorCode: BLResultCode, swiftError: @autoclosure @escaping () -> SwiftBlend2DError) -> SwiftBlend2DErrorMapper {
        mappings[BLResult(errorCode.rawValue)] = swiftError
        return self
    }

    /// Adds common error mapping for `BL_ERROR_INVALID_HANDLE` errors for a given
    /// file path.
    ///
    /// If `filePath` is `nil`, a non-specific file error is generated, instead.
    @inlinable
    func addFileErrorMappings(filePath: String?) -> SwiftBlend2DErrorMapper {
        map(blend2DError: .errorInvalidHandle, swiftError: SwiftBlend2DError.FileError(fileNotOpenAtPath: filePath))
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

        if result == BLResultCode.success.rawValue {
            return result
        }

        if let mapping = mappings[result] {
            throw mapping()
        }

        throw BLResultCode(BLResultCode.RawValue(result))
    }
}
