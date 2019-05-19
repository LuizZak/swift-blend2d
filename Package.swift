// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "SwiftBlend2D",
    products: [
        .library(
            name: "SwiftBlend2D",
            targets: ["SwiftBlend2D"]),
        .library(
            name: "CLibPNG",
            type: .static,
            targets: ["CLibPNG"]),
        .executable(
            name: "SwiftBlend2DSample",
            targets: ["SwiftBlend2DSample"])
    ],
    targets: [
        .target(
            name: "CLibPNG",
            linkerSettings: [
                .linkedLibrary("z")
            ]),
        .target(
            name: "LibPNG",
            dependencies: ["CLibPNG"]),
        .target(
            name: "SwiftBlend2D",
            dependencies: ["blend2d"]),
        .target(
            name: "TigerSample",
            dependencies: ["blend2d", "SwiftBlend2D"]),
        .target(
            name: "SwiftBlend2DSample",
            dependencies: ["TigerSample", "SwiftBlend2D", "blend2d"]),
        .target(
            name: "asmjit",
            dependencies: [],
            cxxSettings: [
                .define("ASMJIT_BUILD_X86", .when(platforms: [.macOS, .linux])),
                .define("ASMJIT_BUILD_ARM", .when(platforms: [.iOS])),
                .define("ASMJIT_BUILD_EMBED"),
                .define("ASMJIT_BUILD_STATIC"),
                .define("ASMJIT_BUILD_NO_STDCXX")
            ],
            linkerSettings: [
                .linkedLibrary("rt", .when(platforms: [.linux])),
                .linkedLibrary("pthread")
            ]),
        .target(
            name: "blend2d",
            dependencies: ["asmjit"],
            cxxSettings: [
                .define("BL_BUILD_OPT_SSE2"),
                .define("BL_BUILD_OPT_SSE3"),
                .define("BL_BUILD_OPT_SSE4_1", .when(platforms: [.macOS])),
                .define("BL_BUILD_OPT_SSE4_2", .when(platforms: [.macOS])),
                .define("BL_BUILD_NO_STDCXX")
            ]
        ),
        .testTarget(
            name: "LibPNGTests",
            dependencies: ["LibPNG"]),
        .testTarget(
            name: "SwiftBlend2DTests",
            dependencies: ["TigerSample", "SwiftBlend2D", "blend2d", "asmjit", "LibPNG"]),
    ],
    cxxLanguageStandard: .cxx11
)
