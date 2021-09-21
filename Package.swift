// swift-tools-version:5.0

import PackageDescription

var dependencies: [Package.Dependency] = []
var testTarget = Target.testTarget(
    name: "SwiftBlend2DTests",
    dependencies: ["TigerSample", "SwiftBlend2D", "blend2d", "asmjit"]
)

#if !os(Windows)

testTarget.dependencies.append(
    "LibPNG"
)

dependencies.append(
    .package(url: "https://github.com/LuizZak/swift-libpng.git", .branch("master"))
)

#endif

let package = Package(
    name: "SwiftBlend2D",
    products: [
        .library(
            name: "SwiftBlend2D",
            targets: ["SwiftBlend2D"]),
        .executable(
            name: "SwiftBlend2DSample",
            targets: ["SwiftBlend2DSample"])
    ],
    dependencies: dependencies,
    targets: [
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
                .define("ASMJIT_BUILD_NO_STDCXX"),
                .define("ASMJIT_STATIC"),
            ],
            linkerSettings: [
                .linkedLibrary("rt", .when(platforms: [.linux])),
                .linkedLibrary("pthread", .when(platforms: [.linux]))
            ]),
        .target(
            name: "blend2d",
            dependencies: ["asmjit"],
            cxxSettings: [
                .define("BL_BUILD_OPT_SSE2"),
                .define("BL_BUILD_OPT_SSE3"),
                .define("BL_BUILD_OPT_SSE4_1", .when(platforms: [.macOS])),
                .define("BL_BUILD_OPT_SSE4_2", .when(platforms: [.macOS])),
                .define("BL_BUILD_NO_STDCXX"),
                .define("BL_STATIC")
            ]
        ),
        testTarget
    ],
    cxxLanguageStandard: .cxx14
)
