// swift-tools-version:5.4

import Foundation
import PackageDescription

// Platform per-architecture

var x86Platforms: [Platform] = [
    .macOS,
    .linux,
    .windows
]
var armPlatforms: [Platform] = [
    .android,
    .iOS,
    .tvOS,
    .watchOS
]

// Environment-based build flags

let hasEnv: (String) -> Bool = { ProcessInfo.processInfo.environment[$0] == "1" }
// List of recognized Blend2D build flags to pass down if present in env variables.
let knownBlend2DFlags: [String] = [
    "BL_BUILD_OPT_SSE3",
    "BL_BUILD_OPT_SSSE3",
    "BL_BUILD_OPT_SSE4_1",
    "BL_BUILD_OPT_SSE4_2",
    "BL_BUILT_OPT_AVX",
    "BL_BUILT_OPT_AVX2",
]

var extraBlend2DFlags = knownBlend2DFlags.filter { hasEnv($0) }

// Package / Target Setup

var dependencies: [Package.Dependency] = []
var testTarget = Target.testTarget(
    name: "SwiftBlend2DTests",
    dependencies: ["TigerSample", "SwiftBlend2D", "blend2d", "asmjit"],
    exclude: [
        "Snapshots",
        "SnapshotFailures"
    ]
)

var blend2DCXXSettings: [CXXSetting] = [
    .define("NDEBUG", .when(configuration: .release)),
    .define("BL_BUILD_OPT_SSE2", .when(platforms: x86Platforms)),
    .define("BL_BUILD_NO_STDCXX"),
    .define("BL_EMBED"),
    .define("BL_STATIC"),
]
blend2DCXXSettings.append(contentsOf: extraBlend2DFlags.map { .define($0) })

// LibPNG for snapshot testing

#if os(Linux) || os(macOS)

dependencies.append(
    .package(url: "https://github.com/LuizZak/swift-libpng.git", .branch("master"))
)
testTarget.dependencies.append(
    .product(name: "LibPNG", package: "swift-libpng")
)

#endif


// MARK: - Final Package Setup

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
        .executableTarget(
            name: "SwiftBlend2DSample",
            dependencies: ["TigerSample", "SwiftBlend2D", "blend2d"]),
        .target(
            name: "asmjit",
            dependencies: [],
            cxxSettings: [
                .define("NDEBUG", .when(configuration: .release)),
                .define("ASMJIT_NO_FOREIGN"),
                .define("ASMJIT_BUILD_NO_STDCXX"),
                .define("ASMJIT_EMBED"),
                .define("ASMJIT_STATIC"),
            ],
            linkerSettings: [
                .linkedLibrary("rt", .when(platforms: [.linux])),
                .linkedLibrary("pthread", .when(platforms: [.linux]))
            ]),
        .target(
            name: "blend2d",
            dependencies: ["asmjit"],
            exclude: [
                "blend2d.natvis"
            ],
            cxxSettings: blend2DCXXSettings
        ),
        testTarget
    ],
    cxxLanguageStandard: .cxx17
)
