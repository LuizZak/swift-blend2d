# SwiftBlend2D

| Platform | Build Status |
|----------|--------|
| macOS    | [![Build Status](https://dev.azure.com/luiz-fs/swift-blend2d/_apis/build/status/LuizZak.swift-blend2d?branchName=master&jobName=macOS)](https://dev.azure.com/luiz-fs/swift-blend2d/_build/latest?definitionId=5&branchName=master) ] |
| Linux    | [![Build Status](https://dev.azure.com/luiz-fs/swift-blend2d/_apis/build/status/LuizZak.swift-blend2d?branchName=master&jobName=Linux)](https://dev.azure.com/luiz-fs/swift-blend2d/_build/latest?definitionId=5&branchName=master) ] |

Work-in-progress Swift bindings for [Blend2D](https://github.com/blend2d/blend2d). This project makes use of the original source code of Blend2D and is in no way associated or supported by Blend2D.

For a brief report of what APIs are available in Swift, please check the [status page](/Status.md).

#### Sample usage

Taken from `sample1` from the [samples library](Sources/SwiftBlend2DSample/Samples.swift).

```swift
let img = BLImage(width: 480, height: 480, format: .prgb32)

// Attach a rendering context into `img`.
let ctx = BLContext(image: img)!

// Clear the image.
ctx.compOp = .sourceCopy
ctx.fillAll()

// Fill some path.
let path = BLPath()

path.moveTo(x: 26, y: 31)
path.cubicTo(x1: 642, y1: 132, x2: 587, y2: -136, x3: 25, y3: 464)
path.cubicTo(x1: 882, y1: 404, x2: 144, y2: 267, x3: 27, y3: 31)

ctx.compOp = .sourceOver
ctx.setFillStyleRgba32(0xFFFFFFFF)
ctx.fillPath(path)

// Detach the rendering context from `img`.
ctx.end()

// Let's use some built-in codecs provided by Blend2D.
let codec = BLImageCodec(builtInCodec: .bmp)

try img.writeToFile("bl-getting-started-1.bmp", codec: codec)
```

This should create an image in the current working directory like so:

![Sample 1](bl-getting-started-1.png)

There are more examples that reproduce each [sample from Blend2D's homepage](https://blend2d.com/doc/getting-started.html) within that file.

#### License

The source code for SwiftBlend2D is distributed under the [MIT license](https://tldrlegal.com/license/mit-license).

The incorporated source code from [Blend2D](https://blend2d.com) is licensed under the [zlib license](https://tldrlegal.com/license/zlib-libpng-license-(zlib)).

A modified source code for [libpng](https://libpng.org), which is included in this project, is licensed under the _PNG Reference Library License version 1_.
