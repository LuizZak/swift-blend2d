This is a brief status report of what is and isn't ported yet. Contributions to help create Swift wrapper structures are welcome.

This may change at any moment.

| Structure | Status | Notes |
|-----|-----|-----|
`BLApproximationOptions` | ❌ Unstarted | |
`BLArc` | ❌ Unstarted | Arc specified as [cx, cy, rx, ry, start, sweep[ using double as a storage type |
`BLArray` | ❌ Unstarted | Array container (template) [C++ API]|
`BLArrayView` | ❌ Unstarted | |
`BLBox` | ❌ Unstarted | Box specified as [x0, y0, x1, y1] using double as a storage type |
`BLBoxI` | ❌ Unstarted | Box specified as [x0, y0, x1, y1] using int as a storage type |
`BLCircle` | ❌ Unstarted | Circle specified as [cx, cy, r] using double as a storage type |
`BLConicalGradientValues` | ❌ Unstarted | Conical gradient values packed into a structure |
`BLContext` | ❌ Unstarted | Rendering context [C++ API]|
`BLContextCookie` | ❌ Unstarted | |
`BLContextCreateOptions` | ❌ Unstarted | Information that can be used to customize the rendering context |
`BLContextHints` | ❌ Unstarted | Rendering context hints |
`BLContextState` | ❌ Unstarted | |
`BLCreateForeignInfo` | ❌ Unstarted | |
`BLEllipse` | ❌ Unstarted | Ellipse specified as [cx, cy, rx, ry] using double as a storage type |
`BLExternalImplPreface` | ❌ Unstarted | |
`BLFile` | ❌ Unstarted | |
`BLFont` | ❌ Unstarted | Font [C++ API]|
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
`BLGlyphBuffer` | ❌ Unstarted | |
`BLGlyphBufferData` | ❌ Unstarted | Glyph buffer [C Data]|
`BLGlyphInfo` | ❌ Unstarted | |
`BLGlyphItem` | ❌ Unstarted | |
`BLGlyphMappingState` | ❌ Unstarted | Character to glyph mapping state |
`BLGlyphOutlineSinkInfo` | ❌ Unstarted | Information passed to a BLPathSinkFunc sink by BLFont::getGlyphOutlines()|
`BLGlyphPlacement` | ❌ Unstarted | |
`BLGlyphRun` | ❌ Unstarted | |
`BLGlyphRunIterator` | ❌ Unstarted | |
`BLGradient` | ❌ Unstarted | Gradient [C++ API]|
`BLGradientStop` | ❌ Unstarted | |
`BLImage` | ❌ Unstarted | 2D raster image [C++ API]|
`BLImageCodec` | ❌ Unstarted | |
`BLImageData` | ❌ Unstarted | Data that describes a raster image. Used by BLImage |
`BLImageDecoder` | ❌ Unstarted | Image decoder [C++ API]|
`BLImageEncoder` | ❌ Unstarted | Image encoder [C++ API]|
`BLImageInfo` | ❌ Unstarted | Image information provided by image codecs |
`BLImageScaleOptions` | ❌ Unstarted | Options that can used to customize image scaling |
`BLInternalCastImpl` | ❌ Unstarted | |
`BLLine` | ❌ Unstarted | Line specified as [x0, y0, x1, y1] using double as a storage type |
`BLLinearGradientValues` | ❌ Unstarted | Linear gradient values packed into a structure |
`BLMatrix2D` | ❌ Unstarted | |
`BLPath` | ❌ Unstarted | 2D vector path [C++ API]|
`BLPathView` | ❌ Unstarted | |
`BLPattern` | ❌ Unstarted | Pattern [C++ API]|
`BLPixelConverter` | ❌ Unstarted | |
`BLPixelConverterOptions` | ❌ Unstarted | Pixel conversion options |
`BLPoint` | ❌ Unstarted | Point specified as [x, y] using double as a storage type |
`BLPointI` | ❌ Unstarted | Point specified as [x, y] using int as a storage type |
`BLRadialGradientValues` | ❌ Unstarted | Radial gradient values packed into a structure |
`BLRandom` | ❌ Unstarted | |
`BLRange` | ❌ Unstarted | |
`BLRect` | ❌ Unstarted | Rectangle specified as [x, y, w, h] using double as a storage type |
`BLRectI` | ❌ Unstarted | Rectangle specified as [x, y, w, h] using int as a storage type |
`BLRegion` | ❌ Unstarted | |
`BLRgba128` | ❌ Unstarted | 128-bit RGBA color stored as 4 32-bit floating point values in [RGBA] order |
`BLRgba32` | ❌ Unstarted | 32-bit RGBA color (8-bit per component) stored as 0xAARRGGBB |
`BLRgba64` | ❌ Unstarted | 64-bit RGBA color (16-bit per component) stored as 0xAAAARRRRGGGGBBBB |
`BLRoundRect` | ❌ Unstarted | Rounded rectangle specified as [x, y, w, h, rx, ry] using double as a storage type |
`BLRuntimeBuildInfo` | ❌ Unstarted | Blend2D build information |
`BLRuntimeCpuInfo` | ❌ Unstarted | CPU information queried by the runtime |
`BLRuntimeMemoryInfo` | ❌ Unstarted | |
`BLSize` | ❌ Unstarted | Size specified as [w, h] using double as a storage type |
`BLSizeI` | ❌ Unstarted | Size specified as [w, h] using int as a storage type |
`BLString` | ❌ Unstarted | |
`BLStrokeOptions` | ❌ Unstarted | |
`BLStrokeOptionsCore` | ❌ Unstarted | |
`BLTextMetrics` | ❌ Unstarted | Text metrics |
`BLTriangle` | ❌ Unstarted | Triangle data speciied as [x0, y0, x1, y1, x2, y2] using double as a storage type |
`BLVariant` | ❌ Unstarted | |
`BLVariantImpl` | ❌ Unstarted |
