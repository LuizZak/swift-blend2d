// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftBlend2D",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftBlend2D",
            targets: ["SwiftBlend2D"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftBlend2D",
            dependencies: ["blend2d"]),
        .target(
            name: "SwiftBlend2DSample",
            dependencies: ["SwiftBlend2D", "blend2d"]),
        .target(
            name: "asmjit",
            dependencies: [],
            cxxSettings: [
                .define("ASMJIT_BUILD_X86", .when(platforms: [.macOS])),
                .define("ASMJIT_BUILD_ARM", .when(platforms: [.iOS]))
            ]),
        .target(
            name: "blend2d",
            dependencies: ["asmjit"]),
        .testTarget(
            name: "SwiftBlend2DTests",
            dependencies: ["SwiftBlend2D"]),
    ],
    cxxLanguageStandard: .cxx1z
)
