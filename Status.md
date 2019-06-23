This is a brief status report of what is and isn't ported yet. Contributions to help create Swift wrapper structures are welcome.

Some of the C structures (like `BLLine`, `BLBox`, `BLMatrix2D` etc.) are already visible to Swift but lack many operators that are implemented only in C++. It'd be nice to port such operators to Swift using public extensions of the original data types.

This may change at any moment.

| Structure | Status | Notes |
|-----|-----|-----|
`BLApproximationOptions` | ✅ Done | |
`BLArc` | ✅ Done | Arc specified as [cx, cy, rx, ry, start, sweep[ using double as a storage type |
`BLArray` | ✅ Done | Array container (template) [C++ API]|
`BLArrayView` | ✅ Done | |
`BLBox` | ✅ Done | Box specified as [x0, y0, x1, y1] using double as a storage type |
`BLBoxI` | ✅ Done | Box specified as [x0, y0, x1, y1] using int as a storage type |
`BLCircle` | ✅ Done | Circle specified as [cx, cy, r] using double as a storage type |
`BLConicalGradientValues` | ℹ️ No work required | Conical gradient values packed into a structure |
`BLContext` | 🕒 Partial | Rendering context [C++ API]|
`BLContextCookie` | ✅ Done | |
`BLContextCreateInfo` | ✅ Done | Information that can be used to customize the rendering context |
`BLContextHints` | ✅ Done | Rendering context hints |
`BLContextState` | ℹ️ No work required | |
`BLCreateForeignInfo` | ℹ️ No work required | |
`BLEllipse` | ✅ Done | Ellipse specified as [cx, cy, rx, ry] using double as a storage type |
`BLExternalImplPreface` | ℹ️ No work required | |
`BLFile` | ✅ Done | |
`BLFont` | ✅ Done | Font [C++ API]|
`BLFontData` | ✅ Done | Font data [C++ API] `(Missing Swift tests)` |
`BLFontDesignMetrics` | ℹ️ No work required | |
`BLFontFace` | ✅ Done | Font face [C++ API] `(Missing Swift tests)` |
`BLFontFaceInfo` | ℹ️ No work required | Information of BLFontFace `(Would be nice to convert enum fields into Swift enums, however)` |
`BLFontFeature` | ℹ️ No work required | |
`BLFontLoader` | 🕒 Partial | `(Missing Swift tests)` |
`BLFontMatrix` | ℹ️ No work required | |
`BLFontMetrics` | ℹ️ No work required | Scaled BLFontDesignMetrics based on font size and other properties |
`BLFontPanose` | ℹ️ No work required | Font PANOSE classification |
`BLFontTable` | ✅ Done | A read only data that represents a font table or its sub-table |
`BLFontUnicodeCoverage` | ✅ Done | |
`BLFontVariation` | ✅ Done | |
`BLFormatInfo` | ✅ Done | |
`BLGlyphBuffer` | ✅ Done | |
`BLGlyphBufferImpl` | ℹ️ No work required | Glyph buffer [C Data]|
`BLGlyphInfo` | ℹ️ No work required | |
`BLGlyphItem` | ✅ Done | |
`BLGlyphMappingState` | ℹ️ No work required | Character to glyph mapping state |
`BLGlyphOutlineSinkInfo` | ℹ️ No work required | Information passed to a BLPathSinkFunc sink by BLFont::getGlyphOutlines()|
`BLGlyphPlacement` | ℹ️ No work required | |
`BLGlyphRun` | 🕒 Partial | `(Missing Swift tests)` |
`BLGlyphRunIterator` | 🕒 Partial | `(Missing Swift tests)` |
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
`BLLinearGradientValues` | ℹ️ No work required | Linear gradient values packed into a structure |
`BLMatrix2D` | 🕒 Partial | `(Missing Swift tests)` |
`BLPath` | 🕒 Partial | 2D vector path [C++ API]|
`BLPathView` | ℹ️ No work required | |
`BLPattern` | 🕒 Partial | Pattern [C++ API] `(Missing Swift tests)` |
`BLPixelConverter` | ❌ Unstarted | |
`BLPixelConverterOptions` | ❌ Unstarted | Pixel conversion options |
`BLPoint` | ✅ Done | Point specified as [x, y] using double as a storage type |
`BLPointI` | ✅ Done | Point specified as [x, y] using int as a storage type |
`BLRadialGradientValues` | ℹ️ No work required | Radial gradient values packed into a structure |
`BLRandom` | ✅ Done | |
`BLRange` | ✅ Done | |
`BLRect` | ✅ Done | Rectangle specified as [x, y, w, h] using double as a storage type |
`BLRectI` | ✅ Done | Rectangle specified as [x, y, w, h] using int as a storage type |
`BLRegion` | 🕒 Partial | `(Missing Swift tests)` |
`BLRgba128` | ✅ Done | 128-bit RGBA color stored as 4 32-bit floating point values in [RGBA] order |
`BLRgba32` | ✅ Done | 32-bit RGBA color (8-bit per component) stored as 0xAARRGGBB |
`BLRgba64` | ✅ Done | 64-bit RGBA color (16-bit per component) stored as 0xAAAARRRRGGGGBBBB |
`BLRoundRect` | ✅ Done | Rounded rectangle specified as [x, y, w, h, rx, ry] using double as a storage type |
`BLRuntimeBuildInfo` | ✅ Done | Blend2D build information |
`BLRuntimeSystemInfo` | ✅ Done | System information queried by the runtime. |
`BLRuntimeMemoryInfo` | ✅ Done | Blend2D memory information that provides how much memory Blend2D allocated and some other details about memory use. |
`BLSize` | ✅ Done | Size specified as [w, h] using double as a storage type |
`BLSizeI` | ✅ Done | Size specified as [w, h] using int as a storage type |
`BLString` | 🕒 Partial | |
`BLStrokeOptions` | 🕒 Partial | `(Missing Swift tests)` |
`BLTextMetrics` | ❌ Unstarted | Text metrics |
`BLTriangle` | ✅ Done | Triangle data speciied as [x0, y0, x1, y1, x2, y2] using double as a storage type |
`BLVariant` | ❌ Unstarted | |
`BLVariantImpl` | ❌ Unstarted |
