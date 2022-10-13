import Foundation

// MARK: - URL computing for folders of interest

private let testFolderName = "SwiftBlend2DTests"

func rootProjectFolderURL() -> URL {
    let file = #filePath
    let fileUrl = URL(fileURLWithPath: file)

    return cdToParentPath(fileUrl, count: 3)
}

func testFolderURL() -> URL {
    cdPath(rootProjectFolderURL(), folders: ["Tests", testFolderName])
}

func resourcesFolderURL() -> URL {
    cdPath(rootProjectFolderURL(), folder: "Resources")
}

// MARK: - Path computing

func pathToSnapshots() -> String {
    cdPath(testFolderURL(), folder: "Snapshots").path
}

func pathToSnapshotFailures() -> String {
    cdPath(testFolderURL(), folder: "SnapshotFailures").path /* This path should be kept in .gitignore */
}

func pathToResources() -> String {
    let rootUrl = rootProjectFolderURL()

    return cdPath(rootUrl, folder: "Resources").path
}

func pathToTestTexture() -> String {
    let resources = resourcesFolderURL()

    return fileIn(folder: resources, fileName: "texture", extension: "jpeg").path
}

func pathToTestFontFace() -> String {
    let resources = resourcesFolderURL()

    return fileIn(folder: resources, fileName: "NotoSans-Regular", extension: "ttf").path
}

// MARK: - Path Helper Functions

func cdToParentPath(_ path: URL, count: Int) -> URL {
    var newPath = path
    for _ in 0..<count {
       newPath.deleteLastPathComponent()
    }

    return newPath
}

func cdPath(_ path: URL, folder: String) -> URL {
    path.appendingPathComponent(folder)
}

func cdPath(_ path: URL, folders: [String]) -> URL {
    folders.reduce(path, { cdPath($0, folder: $1) })
}

func fileIn(folder: URL, fileName: String, extension ext: String) -> URL {
    folder.appendingPathComponent(fileName).appendingPathExtension(ext)
}

func pathExists(_ path: String, isDirectory: inout Bool) -> Bool {
    var objcBool: ObjCBool = ObjCBool(false)
    defer {
        isDirectory = objcBool.boolValue
    }
    return FileManager.default.fileExists(atPath: path, isDirectory: &objcBool)
}

func createDirectory(atPath path: String) throws {
    try FileManager.default.createDirectory(
        at: URL(fileURLWithPath: path),
        withIntermediateDirectories: true,
        attributes: nil
    )
}

func copyFile(source: String, dest: String) throws {
    if FileManager.default.fileExists(atPath: dest) {
        try FileManager.default.removeItem(atPath: dest)
    }
    try FileManager.default.copyItem(atPath: source, toPath: dest)
}
