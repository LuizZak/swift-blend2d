This is a brief status report of what is and isn't ported yet. Contributions to help create Swift wrapper structures are welcome.

Some of the C structures (like `BLLine`, `BLBox`, `BLMatrix2D` etc.) are already visible in Swift but lack many operators that are implemented only in C++. It'd be nice to port such operators to Swift using public extensions.

This may change at any moment.

| Structure | Status | Notes |
|-----|-----|-----|
`BLApproximationOptions` | ✅ Done | |
`BLArc` | ✅ Done | Arc specified as [cx, cy, rx, ry, start, sweep[ using double as a storage type |
`BLArray` | 🕒 Partial | Array container (template) [C++ API]|
`BLArrayView` | ❌ Unstarted | |
`BLBox` | ✅ Done | Box specified as [x0, y0, x1, y1] using double as a storage type |
`BLBoxI` | ✅ Done | Box specified as [x0, y0, x1, y1] using int as a storage type |
`BLCircle` | ✅ Done | Circle specified as [cx, cy, r] using double as a storage type |
`BLConicalGradientValues` | ❌ Unstarted | Conical gradient values packed into a structure |
`BLContext` | 🕒 Partial | Rendering context [C++ API]|
`BLContextCookie` | ✅ Done | |
`BLContextCreateInfo` | ✅ Done | Information that can be used to customize the rendering context |
`BLContextHints` | ❌ Unstarted | Rendering context hints |
`BLContextState` | ✅ Done | `(No work needed)` |
`BLCreateForeignInfo` | ❌ Unstarted | |
`BLEllipse` | ✅ Done | Ellipse specified as [cx, cy, rx, ry] using double as a storage type |
`BLExternalImplPreface` | ❌ Unstarted | |
`BLFile` | ✅ Done | |
`BLFont` | 🕒 Partial | Font [C++ API]|
`BLFontData` | ❌ Unstarted | Font data [C++ API]|
`BLFontDesignMetrics` | ❌ Unstarted | |
`BLFontFace` | ❌ Unstarted | Font face [C++ API]|
`BLFontFaceInfo` | ❌ Unstarted | Information of BLFontFace |
`BLFontFeature` | ❌ Unstarted | |
`BLFontLoader` | ❌ Unstarted | Font loader [C++ API]|
`BLFontMatrix` | ❌ Unstarted | |
`BLFontMetrics` | ❌ Unstarted | Scaled BLFontDesignMetrics based on font size and other properties |
`BLFontPanose` | ❌ Unstarted | Font PANOSE classification |
`BLFontTable` | ❌ Unstarted | A read only data that represents a font table or its sub-table |
`BLFontUnicodeCoverage` | ❌ Unstarted | |
`BLFontVariation` | ❌ Unstarted | |
`BLFormatInfo` | ❌ Unstarted | |
`BLGlyphBuffer` | ✅ Done | |
`BLGlyphBufferData` | ❌ Unstarted | Glyph buffer [C Data]|
`BLGlyphInfo` | ❌ Unstarted | |
`BLGlyphItem` | ❌ Unstarted | |
`BLGlyphMappingState` | ❌ Unstarted | Character to glyph mapping state |
`BLGlyphOutlineSinkInfo` | ❌ Unstarted | Information passed to a BLPathSinkFunc sink by BLFont::getGlyphOutlines()|
`BLGlyphPlacement` | ❌ Unstarted | |
`BLGlyphRun` | ❌ Unstarted | |
`BLGlyphRunIterator` | ❌ Unstarted | |
`BLGradient` | 🕒 Partial | Gradient [C++ API]|
`BLGradientStop` | ✅ Done | |
`BLImage` | 🕒 Partial | 2D raster image [C++ API]|
`BLImageCodec` | 🕒 Partial | |
`BLImageData` | ✅ Done | Data that describes a raster image. Used by BLImage |
`BLImageDecoder` | ❌ Unstarted | Image decoder [C++ API]|
`BLImageEncoder` | ❌ Unstarted | Image encoder [C++ API]|
`BLImageInfo` | ❌ Unstarted | Image information provided by image codecs |
`BLImageScaleOptions` | ❌ Unstarted | Options that can used to customize image scaling |
`BLInternalCastImpl` | ❌ Unstarted | |
`BLLine` | ✅ Done | Line specified as [x0, y0, x1, y1] using double as a storage type |
`BLLinearGradientValues` | ❌ Unstarted | Linear gradient values packed into a structure |
`BLMatrix2D` | 🕒 Partial | Missing Swift tests |
`BLPath` | 🕒 Partial | 2D vector path [C++ API]|
`BLPathView` | ❌ Unstarted | |
`BLPattern` | ❌ Unstarted | Pattern [C++ API]|
`BLPixelConverter` | ❌ Unstarted | |
`BLPixelConverterOptions` | ❌ Unstarted | Pixel conversion options |
`BLPoint` | ✅ Done | Point specified as [x, y] using double as a storage type |
`BLPointI` | ✅ Done | Point specified as [x, y] using int as a storage type |
`BLRadialGradientValues` | ❌ Unstarted | Radial gradient values packed into a structure |
`BLRandom` | ❌ Unstarted | |
`BLRange` | ✅ Done | |
`BLRect` | ✅ Done | Rectangle specified as [x, y, w, h] using double as a storage type |
`BLRectI` | ✅ Done | Rectangle specified as [x, y, w, h] using int as a storage type |
`BLRegion` | ❌ Unstarted | |
`BLRgba128` | ✅ Done | 128-bit RGBA color stored as 4 32-bit floating point values in [RGBA] order |
`BLRgba32` | ✅ Done | 32-bit RGBA color (8-bit per component) stored as 0xAARRGGBB |
`BLRgba64` | ✅ Done | 64-bit RGBA color (16-bit per component) stored as 0xAAAARRRRGGGGBBBB |
`BLRoundRect` | ✅ Done | Rounded rectangle specified as [x, y, w, h, rx, ry] using double as a storage type |
`BLRuntimeBuildInfo` | ✅ Done | Blend2D build information |
`BLRuntimeCpuInfo` | ❌ Unstarted | CPU information queried by the runtime |
`BLRuntimeMemoryInfo` | ❌ Unstarted | |
`BLSize` | ✅ Done | Size specified as [w, h] using double as a storage type |
`BLSizeI` | ✅ Done | Size specified as [w, h] using int as a storage type |
`BLString` | 🕒 Partial | |
`BLStrokeOptions` | 🕒 Partial | (Missing Swift tests) |
`BLTextMetrics` | ❌ Unstarted | Text metrics |
`BLTriangle` | ✅ Done | Triangle data speciied as [x0, y0, x1, y1, x2, y2] using double as a storage type |
`BLVariant` | ❌ Unstarted | |
`BLVariantImpl` | ❌ Unstarted |
