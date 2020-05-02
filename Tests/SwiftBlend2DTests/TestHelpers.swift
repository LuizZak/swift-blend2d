import Foundation

// TODO: Make this path shenanigans portable to Windows

let rootPath: String = "/"
let pathSeparator: Character = "/"

func pathToSnapshots() -> String {
    let file = #file

    return rootPath + file.split(separator: pathSeparator).dropLast().joined(separator: String(pathSeparator)) + "\(pathSeparator)Snapshots"
}

func pathToSnapshotFailures() -> String {
    let file = #file

    return rootPath + file.split(separator: pathSeparator).dropLast().joined(separator: String(pathSeparator))
        + "\(pathSeparator)SnapshotFailures" /* This path should be kept in .gitignore */
}

func pathToResources() -> String {
    let file = #file
    
    return rootPath + file.split(separator: pathSeparator).dropLast(3).joined(separator: String(pathSeparator))
        + "\(pathSeparator)Resources"
}

func pathToTestTexture() -> String {
    return "\(pathToResources())/texture.jpeg"
}

func pathToTestFontFace() -> String {
    return "\(pathToResources())/NotoSans-Regular.ttf"
}

func pathExists(_ path: String, isDirectory: inout Bool) -> Bool {
    var objcBool: ObjCBool = ObjCBool(false)
    defer {
        isDirectory = objcBool.boolValue
    }
    return FileManager.default.fileExists(atPath: path, isDirectory: &objcBool)
}

func createDirectory(atPath path: String) throws {
    try FileManager.default.createDirectory(at: URL(fileURLWithPath: path),
                                            withIntermediateDirectories: true,
                                            attributes: nil)
}

func copyFile(source: String, dest: String) throws {
    if FileManager.default.fileExists(atPath: dest) {
        try FileManager.default.removeItem(atPath: dest)
    }
    try FileManager.default.copyItem(atPath: source, toPath: dest)
}
