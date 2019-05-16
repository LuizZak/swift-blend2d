import blend2d

extension BLRgba128 {
    /// Transparent black color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 0
    /// Alpha: 0
    static let transparentBlack = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 0 / 255.0)
    
    /// Transparent white color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 255
    /// Alpha: 0
    static let transparentWhite = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 0 / 255.0)
    
    /// Alice blue color
    ///
    /// Red: 240
    /// Green: 248
    /// Blue: 255
    /// Alpha: 255
    static let aliceBlue = BLRgba128(r: 240 / 255.0, g: 248 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Antique white color
    ///
    /// Red: 250
    /// Green: 235
    /// Blue: 215
    /// Alpha: 255
    static let antiqueWhite = BLRgba128(r: 250 / 255.0, g: 235 / 255.0, b: 215 / 255.0, a: 255 / 255.0)
    
    /// Aqua color
    ///
    /// Red: 0
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let aqua = BLRgba128(r: 0 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Aquamarine color
    ///
    /// Red: 127
    /// Green: 255
    /// Blue: 212
    /// Alpha: 255
    static let aquamarine = BLRgba128(r: 127 / 255.0, g: 255 / 255.0, b: 212 / 255.0, a: 255 / 255.0)
    
    /// Azure color
    ///
    /// Red: 240
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let azure = BLRgba128(r: 240 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Beige color
    ///
    /// Red: 245
    /// Green: 245
    /// Blue: 220
    /// Alpha: 255
    static let beige = BLRgba128(r: 245 / 255.0, g: 245 / 255.0, b: 220 / 255.0, a: 255 / 255.0)
    
    /// Bisque color
    ///
    /// Red: 255
    /// Green: 228
    /// Blue: 196
    /// Alpha: 255
    static let bisque = BLRgba128(r: 255 / 255.0, g: 228 / 255.0, b: 196 / 255.0, a: 255 / 255.0)
    
    /// Black color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 0
    /// Alpha: 255
    static let black = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Blanched almond color
    ///
    /// Red: 255
    /// Green: 235
    /// Blue: 205
    /// Alpha: 255
    static let blanchedAlmond = BLRgba128(r: 255 / 255.0, g: 235 / 255.0, b: 205 / 255.0, a: 255 / 255.0)
    
    /// Blue color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 255
    /// Alpha: 255
    static let blue = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Blue violet color
    ///
    /// Red: 138
    /// Green: 43
    /// Blue: 226
    /// Alpha: 255
    static let blueViolet = BLRgba128(r: 138 / 255.0, g: 43 / 255.0, b: 226 / 255.0, a: 255 / 255.0)
    
    /// Brown color
    ///
    /// Red: 165
    /// Green: 42
    /// Blue: 42
    /// Alpha: 255
    static let brown = BLRgba128(r: 165 / 255.0, g: 42 / 255.0, b: 42 / 255.0, a: 255 / 255.0)
    
    /// Burly wood color
    ///
    /// Red: 222
    /// Green: 184
    /// Blue: 135
    /// Alpha: 255
    static let burlyWood = BLRgba128(r: 222 / 255.0, g: 184 / 255.0, b: 135 / 255.0, a: 255 / 255.0)
    
    /// Cadet blue color
    ///
    /// Red: 95
    /// Green: 158
    /// Blue: 160
    /// Alpha: 255
    static let cadetBlue = BLRgba128(r: 95 / 255.0, g: 158 / 255.0, b: 160 / 255.0, a: 255 / 255.0)
    
    /// Chartreuse color
    ///
    /// Red: 127
    /// Green: 255
    /// Blue: 0
    /// Alpha: 255
    static let chartreuse = BLRgba128(r: 127 / 255.0, g: 255 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Chocolate color
    ///
    /// Red: 210
    /// Green: 105
    /// Blue: 30
    /// Alpha: 255
    static let chocolate = BLRgba128(r: 210 / 255.0, g: 105 / 255.0, b: 30 / 255.0, a: 255 / 255.0)
    
    /// Coral color
    ///
    /// Red: 255
    /// Green: 127
    /// Blue: 80
    /// Alpha: 255
    static let coral = BLRgba128(r: 255 / 255.0, g: 127 / 255.0, b: 80 / 255.0, a: 255 / 255.0)
    
    /// Cornflower blue color
    ///
    /// Red: 100
    /// Green: 149
    /// Blue: 237
    /// Alpha: 255
    static let cornflowerBlue = BLRgba128(r: 100 / 255.0, g: 149 / 255.0, b: 237 / 255.0, a: 255 / 255.0)
    
    /// Cornsilk color
    ///
    /// Red: 255
    /// Green: 248
    /// Blue: 220
    /// Alpha: 255
    static let cornsilk = BLRgba128(r: 255 / 255.0, g: 248 / 255.0, b: 220 / 255.0, a: 255 / 255.0)
    
    /// Crimson color
    ///
    /// Red: 220
    /// Green: 20
    /// Blue: 60
    /// Alpha: 255
    static let crimson = BLRgba128(r: 220 / 255.0, g: 20 / 255.0, b: 60 / 255.0, a: 255 / 255.0)
    
    /// Cyan color
    ///
    /// Red: 0
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let cyan = BLRgba128(r: 0 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Dark blue color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 139
    /// Alpha: 255
    static let darkBlue = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark cyan color
    ///
    /// Red: 0
    /// Green: 139
    /// Blue: 139
    /// Alpha: 255
    static let darkCyan = BLRgba128(r: 0 / 255.0, g: 139 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark goldenrod color
    ///
    /// Red: 184
    /// Green: 134
    /// Blue: 11
    /// Alpha: 255
    static let darkGoldenrod = BLRgba128(r: 184 / 255.0, g: 134 / 255.0, b: 11 / 255.0, a: 255 / 255.0)
    
    /// Dark gray color
    ///
    /// Red: 169
    /// Green: 169
    /// Blue: 169
    /// Alpha: 255
    static let darkGray = BLRgba128(r: 169 / 255.0, g: 169 / 255.0, b: 169 / 255.0, a: 255 / 255.0)
    
    /// Dark green color
    ///
    /// Red: 0
    /// Green: 100
    /// Blue: 0
    /// Alpha: 255
    static let darkGreen = BLRgba128(r: 0 / 255.0, g: 100 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Dark khaki color
    ///
    /// Red: 189
    /// Green: 183
    /// Blue: 107
    /// Alpha: 255
    static let darkKhaki = BLRgba128(r: 189 / 255.0, g: 183 / 255.0, b: 107 / 255.0, a: 255 / 255.0)
    
    /// Dark magenta color
    ///
    /// Red: 139
    /// Green: 0
    /// Blue: 139
    /// Alpha: 255
    static let darkMagenta = BLRgba128(r: 139 / 255.0, g: 0 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark olive green color
    ///
    /// Red: 85
    /// Green: 107
    /// Blue: 47
    /// Alpha: 255
    static let darkOliveGreen = BLRgba128(r: 85 / 255.0, g: 107 / 255.0, b: 47 / 255.0, a: 255 / 255.0)
    
    /// Dark orange color
    ///
    /// Red: 255
    /// Green: 140
    /// Blue: 0
    /// Alpha: 255
    static let darkOrange = BLRgba128(r: 255 / 255.0, g: 140 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Dark orchid color
    ///
    /// Red: 153
    /// Green: 50
    /// Blue: 204
    /// Alpha: 255
    static let darkOrchid = BLRgba128(r: 153 / 255.0, g: 50 / 255.0, b: 204 / 255.0, a: 255 / 255.0)
    
    /// Dark red color
    ///
    /// Red: 139
    /// Green: 0
    /// Blue: 0
    /// Alpha: 255
    static let darkRed = BLRgba128(r: 139 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Dark salmon color
    ///
    /// Red: 233
    /// Green: 150
    /// Blue: 122
    /// Alpha: 255
    static let darkSalmon = BLRgba128(r: 233 / 255.0, g: 150 / 255.0, b: 122 / 255.0, a: 255 / 255.0)
    
    /// Dark sea green color
    ///
    /// Red: 143
    /// Green: 188
    /// Blue: 139
    /// Alpha: 255
    static let darkSeaGreen = BLRgba128(r: 143 / 255.0, g: 188 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark slate blue color
    ///
    /// Red: 72
    /// Green: 61
    /// Blue: 139
    /// Alpha: 255
    static let darkSlateBlue = BLRgba128(r: 72 / 255.0, g: 61 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark slate gray color
    ///
    /// Red: 47
    /// Green: 79
    /// Blue: 79
    /// Alpha: 255
    static let darkSlateGray = BLRgba128(r: 47 / 255.0, g: 79 / 255.0, b: 79 / 255.0, a: 255 / 255.0)
    
    /// Dark turquoise color
    ///
    /// Red: 0
    /// Green: 206
    /// Blue: 209
    /// Alpha: 255
    static let darkTurquoise = BLRgba128(r: 0 / 255.0, g: 206 / 255.0, b: 209 / 255.0, a: 255 / 255.0)
    
    /// Dark violet color
    ///
    /// Red: 148
    /// Green: 0
    /// Blue: 211
    /// Alpha: 255
    static let darkViolet = BLRgba128(r: 148 / 255.0, g: 0 / 255.0, b: 211 / 255.0, a: 255 / 255.0)
    
    /// Deep pink color
    ///
    /// Red: 255
    /// Green: 20
    /// Blue: 147
    /// Alpha: 255
    static let deepPink = BLRgba128(r: 255 / 255.0, g: 20 / 255.0, b: 147 / 255.0, a: 255 / 255.0)
    
    /// Deep sky blue color
    ///
    /// Red: 0
    /// Green: 191
    /// Blue: 255
    /// Alpha: 255
    static let deepSkyBlue = BLRgba128(r: 0 / 255.0, g: 191 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Dim gray color
    ///
    /// Red: 105
    /// Green: 105
    /// Blue: 105
    /// Alpha: 255
    static let dimGray = BLRgba128(r: 105 / 255.0, g: 105 / 255.0, b: 105 / 255.0, a: 255 / 255.0)
    
    /// Dodger blue color
    ///
    /// Red: 30
    /// Green: 144
    /// Blue: 255
    /// Alpha: 255
    static let dodgerBlue = BLRgba128(r: 30 / 255.0, g: 144 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Firebrick color
    ///
    /// Red: 178
    /// Green: 34
    /// Blue: 34
    /// Alpha: 255
    static let firebrick = BLRgba128(r: 178 / 255.0, g: 34 / 255.0, b: 34 / 255.0, a: 255 / 255.0)
    
    /// Floral white color
    ///
    /// Red: 255
    /// Green: 250
    /// Blue: 240
    /// Alpha: 255
    static let floralWhite = BLRgba128(r: 255 / 255.0, g: 250 / 255.0, b: 240 / 255.0, a: 255 / 255.0)
    
    /// Forest green color
    ///
    /// Red: 34
    /// Green: 139
    /// Blue: 34
    /// Alpha: 255
    static let forestGreen = BLRgba128(r: 34 / 255.0, g: 139 / 255.0, b: 34 / 255.0, a: 255 / 255.0)
    
    /// Fuchsia color
    ///
    /// Red: 255
    /// Green: 0
    /// Blue: 255
    /// Alpha: 255
    static let fuchsia = BLRgba128(r: 255 / 255.0, g: 0 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Gainsboro color
    ///
    /// Red: 220
    /// Green: 220
    /// Blue: 220
    /// Alpha: 255
    static let gainsboro = BLRgba128(r: 220 / 255.0, g: 220 / 255.0, b: 220 / 255.0, a: 255 / 255.0)
    
    /// Ghost white color
    ///
    /// Red: 248
    /// Green: 248
    /// Blue: 255
    /// Alpha: 255
    static let ghostWhite = BLRgba128(r: 248 / 255.0, g: 248 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Gold color
    ///
    /// Red: 255
    /// Green: 215
    /// Blue: 0
    /// Alpha: 255
    static let gold = BLRgba128(r: 255 / 255.0, g: 215 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Goldenrod color
    ///
    /// Red: 218
    /// Green: 165
    /// Blue: 32
    /// Alpha: 255
    static let goldenrod = BLRgba128(r: 218 / 255.0, g: 165 / 255.0, b: 32 / 255.0, a: 255 / 255.0)
    
    /// Gray color
    ///
    /// Red: 128
    /// Green: 128
    /// Blue: 128
    /// Alpha: 255
    static let gray = BLRgba128(r: 128 / 255.0, g: 128 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Green color
    ///
    /// Red: 0
    /// Green: 128
    /// Blue: 0
    /// Alpha: 255
    static let green = BLRgba128(r: 0 / 255.0, g: 128 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Green yellow color
    ///
    /// Red: 173
    /// Green: 255
    /// Blue: 47
    /// Alpha: 255
    static let greenYellow = BLRgba128(r: 173 / 255.0, g: 255 / 255.0, b: 47 / 255.0, a: 255 / 255.0)
    
    /// Honeydew color
    ///
    /// Red: 240
    /// Green: 255
    /// Blue: 240
    /// Alpha: 255
    static let honeydew = BLRgba128(r: 240 / 255.0, g: 255 / 255.0, b: 240 / 255.0, a: 255 / 255.0)
    
    /// Hot pink color
    ///
    /// Red: 255
    /// Green: 105
    /// Blue: 180
    /// Alpha: 255
    static let hotPink = BLRgba128(r: 255 / 255.0, g: 105 / 255.0, b: 180 / 255.0, a: 255 / 255.0)
    
    /// Indian red color
    ///
    /// Red: 205
    /// Green: 92
    /// Blue: 92
    /// Alpha: 255
    static let indianRed = BLRgba128(r: 205 / 255.0, g: 92 / 255.0, b: 92 / 255.0, a: 255 / 255.0)
    
    /// Indigo color
    ///
    /// Red: 75
    /// Green: 0
    /// Blue: 130
    /// Alpha: 255
    static let indigo = BLRgba128(r: 75 / 255.0, g: 0 / 255.0, b: 130 / 255.0, a: 255 / 255.0)
    
    /// Ivory color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 240
    /// Alpha: 255
    static let ivory = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 240 / 255.0, a: 255 / 255.0)
    
    /// Khaki color
    ///
    /// Red: 240
    /// Green: 230
    /// Blue: 140
    /// Alpha: 255
    static let khaki = BLRgba128(r: 240 / 255.0, g: 230 / 255.0, b: 140 / 255.0, a: 255 / 255.0)
    
    /// Lavender color
    ///
    /// Red: 230
    /// Green: 230
    /// Blue: 250
    /// Alpha: 255
    static let lavender = BLRgba128(r: 230 / 255.0, g: 230 / 255.0, b: 250 / 255.0, a: 255 / 255.0)
    
    /// Lavender blush color
    ///
    /// Red: 255
    /// Green: 240
    /// Blue: 245
    /// Alpha: 255
    static let lavenderBlush = BLRgba128(r: 255 / 255.0, g: 240 / 255.0, b: 245 / 255.0, a: 255 / 255.0)
    
    /// Lawn green color
    ///
    /// Red: 124
    /// Green: 252
    /// Blue: 0
    /// Alpha: 255
    static let lawnGreen = BLRgba128(r: 124 / 255.0, g: 252 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Lemon chiffon color
    ///
    /// Red: 255
    /// Green: 250
    /// Blue: 205
    /// Alpha: 255
    static let lemonChiffon = BLRgba128(r: 255 / 255.0, g: 250 / 255.0, b: 205 / 255.0, a: 255 / 255.0)
    
    /// Light blue color
    ///
    /// Red: 173
    /// Green: 216
    /// Blue: 230
    /// Alpha: 255
    static let lightBlue = BLRgba128(r: 173 / 255.0, g: 216 / 255.0, b: 230 / 255.0, a: 255 / 255.0)
    
    /// Light coral color
    ///
    /// Red: 240
    /// Green: 128
    /// Blue: 128
    /// Alpha: 255
    static let lightCoral = BLRgba128(r: 240 / 255.0, g: 128 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Light cyan color
    ///
    /// Red: 224
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let lightCyan = BLRgba128(r: 224 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Light goldenrod yellow color
    ///
    /// Red: 250
    /// Green: 250
    /// Blue: 210
    /// Alpha: 255
    static let lightGoldenrodYellow = BLRgba128(r: 250 / 255.0, g: 250 / 255.0, b: 210 / 255.0, a: 255 / 255.0)
    
    /// Light green color
    ///
    /// Red: 144
    /// Green: 238
    /// Blue: 144
    /// Alpha: 255
    static let lightGreen = BLRgba128(r: 144 / 255.0, g: 238 / 255.0, b: 144 / 255.0, a: 255 / 255.0)
    
    /// Light gray color
    ///
    /// Red: 211
    /// Green: 211
    /// Blue: 211
    /// Alpha: 255
    static let lightGray = BLRgba128(r: 211 / 255.0, g: 211 / 255.0, b: 211 / 255.0, a: 255 / 255.0)
    
    /// Light pink color
    ///
    /// Red: 255
    /// Green: 182
    /// Blue: 193
    /// Alpha: 255
    static let lightPink = BLRgba128(r: 255 / 255.0, g: 182 / 255.0, b: 193 / 255.0, a: 255 / 255.0)
    
    /// Light salmon color
    ///
    /// Red: 255
    /// Green: 160
    /// Blue: 122
    /// Alpha: 255
    static let lightSalmon = BLRgba128(r: 255 / 255.0, g: 160 / 255.0, b: 122 / 255.0, a: 255 / 255.0)
    
    /// Light sea green color
    ///
    /// Red: 32
    /// Green: 178
    /// Blue: 170
    /// Alpha: 255
    static let lightSeaGreen = BLRgba128(r: 32 / 255.0, g: 178 / 255.0, b: 170 / 255.0, a: 255 / 255.0)
    
    /// Light sky blue color
    ///
    /// Red: 135
    /// Green: 206
    /// Blue: 250
    /// Alpha: 255
    static let lightSkyBlue = BLRgba128(r: 135 / 255.0, g: 206 / 255.0, b: 250 / 255.0, a: 255 / 255.0)
    
    /// Light slate gray color
    ///
    /// Red: 119
    /// Green: 136
    /// Blue: 153
    /// Alpha: 255
    static let lightSlateGray = BLRgba128(r: 119 / 255.0, g: 136 / 255.0, b: 153 / 255.0, a: 255 / 255.0)
    
    /// Light steel blue color
    ///
    /// Red: 176
    /// Green: 196
    /// Blue: 222
    /// Alpha: 255
    static let lightSteelBlue = BLRgba128(r: 176 / 255.0, g: 196 / 255.0, b: 222 / 255.0, a: 255 / 255.0)
    
    /// Light yellow color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 224
    /// Alpha: 255
    static let lightYellow = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 224 / 255.0, a: 255 / 255.0)
    
    /// Lime color
    ///
    /// Red: 0
    /// Green: 255
    /// Blue: 0
    /// Alpha: 255
    static let lime = BLRgba128(r: 0 / 255.0, g: 255 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Lime green color
    ///
    /// Red: 50
    /// Green: 205
    /// Blue: 50
    /// Alpha: 255
    static let limeGreen = BLRgba128(r: 50 / 255.0, g: 205 / 255.0, b: 50 / 255.0, a: 255 / 255.0)
    
    /// Linen color
    ///
    /// Red: 250
    /// Green: 240
    /// Blue: 230
    /// Alpha: 255
    static let linen = BLRgba128(r: 250 / 255.0, g: 240 / 255.0, b: 230 / 255.0, a: 255 / 255.0)
    
    /// Magenta color
    ///
    /// Red: 255
    /// Green: 0
    /// Blue: 255
    /// Alpha: 255
    static let magenta = BLRgba128(r: 255 / 255.0, g: 0 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Maroon color
    ///
    /// Red: 128
    /// Green: 0
    /// Blue: 0
    /// Alpha: 255
    static let maroon = BLRgba128(r: 128 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Medium aquamarine color
    ///
    /// Red: 102
    /// Green: 205
    /// Blue: 170
    /// Alpha: 255
    static let mediumAquamarine = BLRgba128(r: 102 / 255.0, g: 205 / 255.0, b: 170 / 255.0, a: 255 / 255.0)
    
    /// Medium blue color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 205
    /// Alpha: 255
    static let mediumBlue = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 205 / 255.0, a: 255 / 255.0)
    
    /// Medium orchid color
    ///
    /// Red: 186
    /// Green: 85
    /// Blue: 211
    /// Alpha: 255
    static let mediumOrchid = BLRgba128(r: 186 / 255.0, g: 85 / 255.0, b: 211 / 255.0, a: 255 / 255.0)
    
    /// Medium purple color
    ///
    /// Red: 147
    /// Green: 112
    /// Blue: 219
    /// Alpha: 255
    static let mediumPurple = BLRgba128(r: 147 / 255.0, g: 112 / 255.0, b: 219 / 255.0, a: 255 / 255.0)
    
    /// Medium sea green color
    ///
    /// Red: 60
    /// Green: 179
    /// Blue: 113
    /// Alpha: 255
    static let mediumSeaGreen = BLRgba128(r: 60 / 255.0, g: 179 / 255.0, b: 113 / 255.0, a: 255 / 255.0)
    
    /// Medium slate blue color
    ///
    /// Red: 123
    /// Green: 104
    /// Blue: 238
    /// Alpha: 255
    static let mediumSlateBlue = BLRgba128(r: 123 / 255.0, g: 104 / 255.0, b: 238 / 255.0, a: 255 / 255.0)
    
    /// Medium spring green color
    ///
    /// Red: 0
    /// Green: 250
    /// Blue: 154
    /// Alpha: 255
    static let mediumSpringGreen = BLRgba128(r: 0 / 255.0, g: 250 / 255.0, b: 154 / 255.0, a: 255 / 255.0)
    
    /// Medium turquoise color
    ///
    /// Red: 72
    /// Green: 209
    /// Blue: 204
    /// Alpha: 255
    static let mediumTurquoise = BLRgba128(r: 72 / 255.0, g: 209 / 255.0, b: 204 / 255.0, a: 255 / 255.0)
    
    /// Medium violet red color
    ///
    /// Red: 199
    /// Green: 21
    /// Blue: 133
    /// Alpha: 255
    static let mediumVioletRed = BLRgba128(r: 199 / 255.0, g: 21 / 255.0, b: 133 / 255.0, a: 255 / 255.0)
    
    /// Midnight blue color
    ///
    /// Red: 25
    /// Green: 25
    /// Blue: 112
    /// Alpha: 255
    static let midnightBlue = BLRgba128(r: 25 / 255.0, g: 25 / 255.0, b: 112 / 255.0, a: 255 / 255.0)
    
    /// Mint cream color
    ///
    /// Red: 245
    /// Green: 255
    /// Blue: 250
    /// Alpha: 255
    static let mintCream = BLRgba128(r: 245 / 255.0, g: 255 / 255.0, b: 250 / 255.0, a: 255 / 255.0)
    
    /// Misty rose color
    ///
    /// Red: 255
    /// Green: 228
    /// Blue: 225
    /// Alpha: 255
    static let mistyRose = BLRgba128(r: 255 / 255.0, g: 228 / 255.0, b: 225 / 255.0, a: 255 / 255.0)
    
    /// Moccasin color
    ///
    /// Red: 255
    /// Green: 228
    /// Blue: 181
    /// Alpha: 255
    static let moccasin = BLRgba128(r: 255 / 255.0, g: 228 / 255.0, b: 181 / 255.0, a: 255 / 255.0)
    
    /// Navajo white color
    ///
    /// Red: 255
    /// Green: 222
    /// Blue: 173
    /// Alpha: 255
    static let navajoWhite = BLRgba128(r: 255 / 255.0, g: 222 / 255.0, b: 173 / 255.0, a: 255 / 255.0)
    
    /// Navy color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 128
    /// Alpha: 255
    static let navy = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Old lace color
    ///
    /// Red: 253
    /// Green: 245
    /// Blue: 230
    /// Alpha: 255
    static let oldLace = BLRgba128(r: 253 / 255.0, g: 245 / 255.0, b: 230 / 255.0, a: 255 / 255.0)
    
    /// Olive color
    ///
    /// Red: 128
    /// Green: 128
    /// Blue: 0
    /// Alpha: 255
    static let olive = BLRgba128(r: 128 / 255.0, g: 128 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Olive drab color
    ///
    /// Red: 107
    /// Green: 142
    /// Blue: 35
    /// Alpha: 255
    static let oliveDrab = BLRgba128(r: 107 / 255.0, g: 142 / 255.0, b: 35 / 255.0, a: 255 / 255.0)
    
    /// Orange color
    ///
    /// Red: 255
    /// Green: 165
    /// Blue: 0
    /// Alpha: 255
    static let orange = BLRgba128(r: 255 / 255.0, g: 165 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Orange red color
    ///
    /// Red: 255
    /// Green: 69
    /// Blue: 0
    /// Alpha: 255
    static let orangeRed = BLRgba128(r: 255 / 255.0, g: 69 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Orchid color
    ///
    /// Red: 218
    /// Green: 112
    /// Blue: 214
    /// Alpha: 255
    static let orchid = BLRgba128(r: 218 / 255.0, g: 112 / 255.0, b: 214 / 255.0, a: 255 / 255.0)
    
    /// Pale goldenrod color
    ///
    /// Red: 238
    /// Green: 232
    /// Blue: 170
    /// Alpha: 255
    static let paleGoldenrod = BLRgba128(r: 238 / 255.0, g: 232 / 255.0, b: 170 / 255.0, a: 255 / 255.0)
    
    /// Pale green color
    ///
    /// Red: 152
    /// Green: 251
    /// Blue: 152
    /// Alpha: 255
    static let paleGreen = BLRgba128(r: 152 / 255.0, g: 251 / 255.0, b: 152 / 255.0, a: 255 / 255.0)
    
    /// Pale turquoise color
    ///
    /// Red: 175
    /// Green: 238
    /// Blue: 238
    /// Alpha: 255
    static let paleTurquoise = BLRgba128(r: 175 / 255.0, g: 238 / 255.0, b: 238 / 255.0, a: 255 / 255.0)
    
    /// Pale violet red color
    ///
    /// Red: 219
    /// Green: 112
    /// Blue: 147
    /// Alpha: 255
    static let paleVioletRed = BLRgba128(r: 219 / 255.0, g: 112 / 255.0, b: 147 / 255.0, a: 255 / 255.0)
    
    /// Papaya whip color
    ///
    /// Red: 255
    /// Green: 239
    /// Blue: 213
    /// Alpha: 255
    static let papayaWhip = BLRgba128(r: 255 / 255.0, g: 239 / 255.0, b: 213 / 255.0, a: 255 / 255.0)
    
    /// Peach puff color
    ///
    /// Red: 255
    /// Green: 218
    /// Blue: 185
    /// Alpha: 255
    static let peachPuff = BLRgba128(r: 255 / 255.0, g: 218 / 255.0, b: 185 / 255.0, a: 255 / 255.0)
    
    /// Peru color
    ///
    /// Red: 205
    /// Green: 133
    /// Blue: 63
    /// Alpha: 255
    static let peru = BLRgba128(r: 205 / 255.0, g: 133 / 255.0, b: 63 / 255.0, a: 255 / 255.0)
    
    /// Pink color
    ///
    /// Red: 255
    /// Green: 192
    /// Blue: 203
    /// Alpha: 255
    static let pink = BLRgba128(r: 255 / 255.0, g: 192 / 255.0, b: 203 / 255.0, a: 255 / 255.0)
    
    /// Plum color
    ///
    /// Red: 221
    /// Green: 160
    /// Blue: 221
    /// Alpha: 255
    static let plum = BLRgba128(r: 221 / 255.0, g: 160 / 255.0, b: 221 / 255.0, a: 255 / 255.0)
    
    /// Powder blue color
    ///
    /// Red: 176
    /// Green: 224
    /// Blue: 230
    /// Alpha: 255
    static let powderBlue = BLRgba128(r: 176 / 255.0, g: 224 / 255.0, b: 230 / 255.0, a: 255 / 255.0)
    
    /// Purple color
    ///
    /// Red: 128
    /// Green: 0
    /// Blue: 128
    /// Alpha: 255
    static let purple = BLRgba128(r: 128 / 255.0, g: 0 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Red color
    ///
    /// Red: 255
    /// Green: 0
    /// Blue: 0
    /// Alpha: 255
    static let red = BLRgba128(r: 255 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Rosy brown color
    ///
    /// Red: 188
    /// Green: 143
    /// Blue: 143
    /// Alpha: 255
    static let rosyBrown = BLRgba128(r: 188 / 255.0, g: 143 / 255.0, b: 143 / 255.0, a: 255 / 255.0)
    
    /// Royal blue color
    ///
    /// Red: 65
    /// Green: 105
    /// Blue: 225
    /// Alpha: 255
    static let royalBlue = BLRgba128(r: 65 / 255.0, g: 105 / 255.0, b: 225 / 255.0, a: 255 / 255.0)
    
    /// Saddle brown color
    ///
    /// Red: 139
    /// Green: 69
    /// Blue: 19
    /// Alpha: 255
    static let saddleBrown = BLRgba128(r: 139 / 255.0, g: 69 / 255.0, b: 19 / 255.0, a: 255 / 255.0)
    
    /// Salmon color
    ///
    /// Red: 250
    /// Green: 128
    /// Blue: 114
    /// Alpha: 255
    static let salmon = BLRgba128(r: 250 / 255.0, g: 128 / 255.0, b: 114 / 255.0, a: 255 / 255.0)
    
    /// Sandy brown color
    ///
    /// Red: 244
    /// Green: 164
    /// Blue: 96
    /// Alpha: 255
    static let sandyBrown = BLRgba128(r: 244 / 255.0, g: 164 / 255.0, b: 96 / 255.0, a: 255 / 255.0)
    
    /// Sea green color
    ///
    /// Red: 46
    /// Green: 139
    /// Blue: 87
    /// Alpha: 255
    static let seaGreen = BLRgba128(r: 46 / 255.0, g: 139 / 255.0, b: 87 / 255.0, a: 255 / 255.0)
    
    /// Sea shell color
    ///
    /// Red: 255
    /// Green: 245
    /// Blue: 238
    /// Alpha: 255
    static let seaShell = BLRgba128(r: 255 / 255.0, g: 245 / 255.0, b: 238 / 255.0, a: 255 / 255.0)
    
    /// Sienna color
    ///
    /// Red: 160
    /// Green: 82
    /// Blue: 45
    /// Alpha: 255
    static let sienna = BLRgba128(r: 160 / 255.0, g: 82 / 255.0, b: 45 / 255.0, a: 255 / 255.0)
    
    /// Silver color
    ///
    /// Red: 192
    /// Green: 192
    /// Blue: 192
    /// Alpha: 255
    static let silver = BLRgba128(r: 192 / 255.0, g: 192 / 255.0, b: 192 / 255.0, a: 255 / 255.0)
    
    /// Sky blue color
    ///
    /// Red: 135
    /// Green: 206
    /// Blue: 235
    /// Alpha: 255
    static let skyBlue = BLRgba128(r: 135 / 255.0, g: 206 / 255.0, b: 235 / 255.0, a: 255 / 255.0)
    
    /// Slate blue color
    ///
    /// Red: 106
    /// Green: 90
    /// Blue: 205
    /// Alpha: 255
    static let slateBlue = BLRgba128(r: 106 / 255.0, g: 90 / 255.0, b: 205 / 255.0, a: 255 / 255.0)
    
    /// Slate gray color
    ///
    /// Red: 112
    /// Green: 128
    /// Blue: 144
    /// Alpha: 255
    static let slateGray = BLRgba128(r: 112 / 255.0, g: 128 / 255.0, b: 144 / 255.0, a: 255 / 255.0)
    
    /// Snow color
    ///
    /// Red: 255
    /// Green: 250
    /// Blue: 250
    /// Alpha: 255
    static let snow = BLRgba128(r: 255 / 255.0, g: 250 / 255.0, b: 250 / 255.0, a: 255 / 255.0)
    
    /// Spring green color
    ///
    /// Red: 0
    /// Green: 255
    /// Blue: 127
    /// Alpha: 255
    static let springGreen = BLRgba128(r: 0 / 255.0, g: 255 / 255.0, b: 127 / 255.0, a: 255 / 255.0)
    
    /// Steel blue color
    ///
    /// Red: 70
    /// Green: 130
    /// Blue: 180
    /// Alpha: 255
    static let steelBlue = BLRgba128(r: 70 / 255.0, g: 130 / 255.0, b: 180 / 255.0, a: 255 / 255.0)
    
    /// Tan color
    ///
    /// Red: 210
    /// Green: 180
    /// Blue: 140
    /// Alpha: 255
    static let tan = BLRgba128(r: 210 / 255.0, g: 180 / 255.0, b: 140 / 255.0, a: 255 / 255.0)
    
    /// Teal color
    ///
    /// Red: 0
    /// Green: 128
    /// Blue: 128
    /// Alpha: 255
    static let teal = BLRgba128(r: 0 / 255.0, g: 128 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Thistle color
    ///
    /// Red: 216
    /// Green: 191
    /// Blue: 216
    /// Alpha: 255
    static let thistle = BLRgba128(r: 216 / 255.0, g: 191 / 255.0, b: 216 / 255.0, a: 255 / 255.0)
    
    /// Tomato color
    ///
    /// Red: 255
    /// Green: 99
    /// Blue: 71
    /// Alpha: 255
    static let tomato = BLRgba128(r: 255 / 255.0, g: 99 / 255.0, b: 71 / 255.0, a: 255 / 255.0)
    
    /// Turquoise color
    ///
    /// Red: 64
    /// Green: 224
    /// Blue: 208
    /// Alpha: 255
    static let turquoise = BLRgba128(r: 64 / 255.0, g: 224 / 255.0, b: 208 / 255.0, a: 255 / 255.0)
    
    /// Violet color
    ///
    /// Red: 238
    /// Green: 130
    /// Blue: 238
    /// Alpha: 255
    static let violet = BLRgba128(r: 238 / 255.0, g: 130 / 255.0, b: 238 / 255.0, a: 255 / 255.0)
    
    /// Wheat color
    ///
    /// Red: 245
    /// Green: 222
    /// Blue: 179
    /// Alpha: 255
    static let wheat = BLRgba128(r: 245 / 255.0, g: 222 / 255.0, b: 179 / 255.0, a: 255 / 255.0)
    
    /// White color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let white = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// White smoke color
    ///
    /// Red: 245
    /// Green: 245
    /// Blue: 245
    /// Alpha: 255
    static let whiteSmoke = BLRgba128(r: 245 / 255.0, g: 245 / 255.0, b: 245 / 255.0, a: 255 / 255.0)
    
    /// Yellow color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 0
    /// Alpha: 255
    static let yellow = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Yellow green color
    ///
    /// Red: 154
    /// Green: 205
    /// Blue: 50
    /// Alpha: 255
    static let yellowGreen = BLRgba128(r: 154 / 255.0, g: 205 / 255.0, b: 50 / 255.0, a: 255 / 255.0)
}
