This is a brief status report of what is and isn't ported yet. Contributions to help create Swift wrapper structures are welcome.

This may change at any moment.

| Structure | Status | Notes |
|-----|-----|-----|
`CBLApproximationOptions` | ❌ Unstarted | |
`CBLArc` | ❌ Unstarted | Arc specified as [cx, cy, rx, ry, start, sweep[ using double as a storage type |
`CBLArray` | ❌ Unstarted | Array container (template) [C++ API]|
`CBLArrayView` | ❌ Unstarted | |
`CBLBox` | ❌ Unstarted | Box specified as [x0, y0, x1, y1] using double as a storage type |
`CBLBoxI` | ❌ Unstarted | Box specified as [x0, y0, x1, y1] using int as a storage type |
`CBLCircle` | ❌ Unstarted | Circle specified as [cx, cy, r] using double as a storage type |
`CBLConicalGradientValues` | ❌ Unstarted | Conical gradient values packed into a structure |
`CBLContext` | ❌ Unstarted | Rendering context [C++ API]|
`CBLContextCookie` | ❌ Unstarted | |
`CBLContextCreateOptions` | ❌ Unstarted | Information that can be used to customize the rendering context |
`CBLContextHints` | ❌ Unstarted | Rendering context hints |
`CBLContextState` | ❌ Unstarted | |
`CBLCreateForeignInfo` | ❌ Unstarted | |
`CBLEllipse` | ❌ Unstarted | Ellipse specified as [cx, cy, rx, ry] using double as a storage type |
`CBLExternalImplPreface` | ❌ Unstarted | |
`CBLFile` | ❌ Unstarted | |
`CBLFont` | ❌ Unstarted | Font [C++ API]|
`CBLFontData` | ❌ Unstarted | Font data [C++ API]|
`CBLFontDesignMetrics` | ❌ Unstarted | |
`CBLFontFace` | ❌ Unstarted | Font face [C++ API]|
`CBLFontFaceInfo` | ❌ Unstarted | Information of BLFontFace |
`CBLFontFeature` | ❌ Unstarted | |
`CBLFontLoader` | ❌ Unstarted | Font loader [C++ API]|
`CBLFontMatrix` | ❌ Unstarted | |
`CBLFontMetrics` | ❌ Unstarted | Scaled BLFontDesignMetrics based on font size and other properties |
`CBLFontPanose` | ❌ Unstarted | Font PANOSE classification |
`CBLFontTable` | ❌ Unstarted | A read only data that represents a font table or its sub-table |
`CBLFontUnicodeCoverage` | ❌ Unstarted | |
`CBLFontVariation` | ❌ Unstarted | |
`CBLFormatInfo` | ❌ Unstarted | |
`CBLGlyphBuffer` | ❌ Unstarted | |
`CBLGlyphBufferData` | ❌ Unstarted | Glyph buffer [C Data]|
`CBLGlyphInfo` | ❌ Unstarted | |
`CBLGlyphItem` | ❌ Unstarted | |
`CBLGlyphMappingState` | ❌ Unstarted | Character to glyph mapping state |
`CBLGlyphOutlineSinkInfo` | ❌ Unstarted | Information passed to a BLPathSinkFunc sink by BLFont::getGlyphOutlines()|
`CBLGlyphPlacement` | ❌ Unstarted | |
`CBLGlyphRun` | ❌ Unstarted | |
`CBLGlyphRunIterator` | ❌ Unstarted | |
`CBLGradient` | ❌ Unstarted | Gradient [C++ API]|
`CBLGradientStop` | ❌ Unstarted | |
`CBLImage` | ❌ Unstarted | 2D raster image [C++ API]|
`CBLImageCodec` | ❌ Unstarted | |
`CBLImageData` | ❌ Unstarted | Data that describes a raster image. Used by BLImage |
`CBLImageDecoder` | ❌ Unstarted | Image decoder [C++ API]|
`CBLImageEncoder` | ❌ Unstarted | Image encoder [C++ API]|
`CBLImageInfo` | ❌ Unstarted | Image information provided by image codecs |
`CBLImageScaleOptions` | ❌ Unstarted | Options that can used to customize image scaling |
`CBLInternalCastImpl` | ❌ Unstarted | |
`CBLLine` | ❌ Unstarted | Line specified as [x0, y0, x1, y1] using double as a storage type |
`CBLLinearGradientValues` | ❌ Unstarted | Linear gradient values packed into a structure |
`CBLMatrix2D` | ❌ Unstarted | |
`CBLPath` | ❌ Unstarted | 2D vector path [C++ API]|
`CBLPathView` | ❌ Unstarted | |
`CBLPattern` | ❌ Unstarted | Pattern [C++ API]|
`CBLPixelConverter` | ❌ Unstarted | |
`CBLPixelConverterOptions` | ❌ Unstarted | Pixel conversion options |
`CBLPoint` | ❌ Unstarted | Point specified as [x, y] using double as a storage type |
`CBLPointI` | ❌ Unstarted | Point specified as [x, y] using int as a storage type |
`CBLRadialGradientValues` | ❌ Unstarted | Radial gradient values packed into a structure |
`CBLRandom` | ❌ Unstarted | |
`CBLRange` | ❌ Unstarted | |
`CBLRect` | ❌ Unstarted | Rectangle specified as [x, y, w, h] using double as a storage type |
`CBLRectI` | ❌ Unstarted | Rectangle specified as [x, y, w, h] using int as a storage type |
`CBLRegion` | ❌ Unstarted | |
`CBLRgba128` | ❌ Unstarted | 128-bit RGBA color stored as 4 32-bit floating point values in [RGBA] order |
`CBLRgba32` | ❌ Unstarted | 32-bit RGBA color (8-bit per component) stored as 0xAARRGGBB |
`CBLRgba64` | ❌ Unstarted | 64-bit RGBA color (16-bit per component) stored as 0xAAAARRRRGGGGBBBB |
`CBLRoundRect` | ❌ Unstarted | Rounded rectangle specified as [x, y, w, h, rx, ry] using double as a storage type |
`CBLRuntimeBuildInfo` | ❌ Unstarted | Blend2D build information |
`CBLRuntimeCpuInfo` | ❌ Unstarted | CPU information queried by the runtime |
`CBLRuntimeMemoryInfo` | ❌ Unstarted | |
`CBLSize` | ❌ Unstarted | Size specified as [w, h] using double as a storage type |
`CBLSizeI` | ❌ Unstarted | Size specified as [w, h] using int as a storage type |
`CBLString` | ❌ Unstarted | |
`CBLStrokeOptions` | ❌ Unstarted | |
`CBLStrokeOptionsCore` | ❌ Unstarted | |
`CBLTextMetrics` | ❌ Unstarted | Text metrics |
`CBLTriangle` | ❌ Unstarted | Triangle data speciied as [x0, y0, x1, y1, x2, y2] using double as a storage type |
`CBLVariant` | ❌ Unstarted | |
`CBLVariantImpl` | ❌ Unstarted |
