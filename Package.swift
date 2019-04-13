// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "SwiftBlend2D",
    products: [
        .library(
            name: "SwiftBlend2D",
            targets: ["SwiftBlend2D"]),
    ],
    targets: [
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
                .define("ASMJIT_BUILD_X86", .when(platforms: [.macOS, .linux])),
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
