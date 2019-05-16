import blend2d

public extension BLRgba32 {
    /// Transparent black color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 0
    /// Alpha: 0
    static let transparentBlack = BLRgba32(r: 0, g: 0, b: 0, a: 0)
    
    /// Transparent white color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 255
    /// Alpha: 0
    static let transparentWhite = BLRgba32(r: 255, g: 255, b: 255, a: 0)
    
    /// Alice blue color
    ///
    /// Red: 240
    /// Green: 248
    /// Blue: 255
    /// Alpha: 255
    static let aliceBlue = BLRgba32(r: 240, g: 248, b: 255, a: 255)
    
    /// Antique white color
    ///
    /// Red: 250
    /// Green: 235
    /// Blue: 215
    /// Alpha: 255
    static let antiqueWhite = BLRgba32(r: 250, g: 235, b: 215, a: 255)
    
    /// Aqua color
    ///
    /// Red: 0
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let aqua = BLRgba32(r: 0, g: 255, b: 255, a: 255)
    
    /// Aquamarine color
    ///
    /// Red: 127
    /// Green: 255
    /// Blue: 212
    /// Alpha: 255
    static let aquamarine = BLRgba32(r: 127, g: 255, b: 212, a: 255)
    
    /// Azure color
    ///
    /// Red: 240
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let azure = BLRgba32(r: 240, g: 255, b: 255, a: 255)
    
    /// Beige color
    ///
    /// Red: 245
    /// Green: 245
    /// Blue: 220
    /// Alpha: 255
    static let beige = BLRgba32(r: 245, g: 245, b: 220, a: 255)
    
    /// Bisque color
    ///
    /// Red: 255
    /// Green: 228
    /// Blue: 196
    /// Alpha: 255
    static let bisque = BLRgba32(r: 255, g: 228, b: 196, a: 255)
    
    /// Black color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 0
    /// Alpha: 255
    static let black = BLRgba32(r: 0, g: 0, b: 0, a: 255)
    
    /// Blanched almond color
    ///
    /// Red: 255
    /// Green: 235
    /// Blue: 205
    /// Alpha: 255
    static let blanchedAlmond = BLRgba32(r: 255, g: 235, b: 205, a: 255)
    
    /// Blue color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 255
    /// Alpha: 255
    static let blue = BLRgba32(r: 0, g: 0, b: 255, a: 255)
    
    /// Blue violet color
    ///
    /// Red: 138
    /// Green: 43
    /// Blue: 226
    /// Alpha: 255
    static let blueViolet = BLRgba32(r: 138, g: 43, b: 226, a: 255)
    
    /// Brown color
    ///
    /// Red: 165
    /// Green: 42
    /// Blue: 42
    /// Alpha: 255
    static let brown = BLRgba32(r: 165, g: 42, b: 42, a: 255)
    
    /// Burly wood color
    ///
    /// Red: 222
    /// Green: 184
    /// Blue: 135
    /// Alpha: 255
    static let burlyWood = BLRgba32(r: 222, g: 184, b: 135, a: 255)
    
    /// Cadet blue color
    ///
    /// Red: 95
    /// Green: 158
    /// Blue: 160
    /// Alpha: 255
    static let cadetBlue = BLRgba32(r: 95, g: 158, b: 160, a: 255)
    
    /// Chartreuse color
    ///
    /// Red: 127
    /// Green: 255
    /// Blue: 0
    /// Alpha: 255
    static let chartreuse = BLRgba32(r: 127, g: 255, b: 0, a: 255)
    
    /// Chocolate color
    ///
    /// Red: 210
    /// Green: 105
    /// Blue: 30
    /// Alpha: 255
    static let chocolate = BLRgba32(r: 210, g: 105, b: 30, a: 255)
    
    /// Coral color
    ///
    /// Red: 255
    /// Green: 127
    /// Blue: 80
    /// Alpha: 255
    static let coral = BLRgba32(r: 255, g: 127, b: 80, a: 255)
    
    /// Cornflower blue color
    ///
    /// Red: 100
    /// Green: 149
    /// Blue: 237
    /// Alpha: 255
    static let cornflowerBlue = BLRgba32(r: 100, g: 149, b: 237, a: 255)
    
    /// Cornsilk color
    ///
    /// Red: 255
    /// Green: 248
    /// Blue: 220
    /// Alpha: 255
    static let cornsilk = BLRgba32(r: 255, g: 248, b: 220, a: 255)
    
    /// Crimson color
    ///
    /// Red: 220
    /// Green: 20
    /// Blue: 60
    /// Alpha: 255
    static let crimson = BLRgba32(r: 220, g: 20, b: 60, a: 255)
    
    /// Cyan color
    ///
    /// Red: 0
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let cyan = BLRgba32(r: 0, g: 255, b: 255, a: 255)
    
    /// Dark blue color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 139
    /// Alpha: 255
    static let darkBlue = BLRgba32(r: 0, g: 0, b: 139, a: 255)
    
    /// Dark cyan color
    ///
    /// Red: 0
    /// Green: 139
    /// Blue: 139
    /// Alpha: 255
    static let darkCyan = BLRgba32(r: 0, g: 139, b: 139, a: 255)
    
    /// Dark goldenrod color
    ///
    /// Red: 184
    /// Green: 134
    /// Blue: 11
    /// Alpha: 255
    static let darkGoldenrod = BLRgba32(r: 184, g: 134, b: 11, a: 255)
    
    /// Dark gray color
    ///
    /// Red: 169
    /// Green: 169
    /// Blue: 169
    /// Alpha: 255
    static let darkGray = BLRgba32(r: 169, g: 169, b: 169, a: 255)
    
    /// Dark green color
    ///
    /// Red: 0
    /// Green: 100
    /// Blue: 0
    /// Alpha: 255
    static let darkGreen = BLRgba32(r: 0, g: 100, b: 0, a: 255)
    
    /// Dark khaki color
    ///
    /// Red: 189
    /// Green: 183
    /// Blue: 107
    /// Alpha: 255
    static let darkKhaki = BLRgba32(r: 189, g: 183, b: 107, a: 255)
    
    /// Dark magenta color
    ///
    /// Red: 139
    /// Green: 0
    /// Blue: 139
    /// Alpha: 255
    static let darkMagenta = BLRgba32(r: 139, g: 0, b: 139, a: 255)
    
    /// Dark olive green color
    ///
    /// Red: 85
    /// Green: 107
    /// Blue: 47
    /// Alpha: 255
    static let darkOliveGreen = BLRgba32(r: 85, g: 107, b: 47, a: 255)
    
    /// Dark orange color
    ///
    /// Red: 255
    /// Green: 140
    /// Blue: 0
    /// Alpha: 255
    static let darkOrange = BLRgba32(r: 255, g: 140, b: 0, a: 255)
    
    /// Dark orchid color
    ///
    /// Red: 153
    /// Green: 50
    /// Blue: 204
    /// Alpha: 255
    static let darkOrchid = BLRgba32(r: 153, g: 50, b: 204, a: 255)
    
    /// Dark red color
    ///
    /// Red: 139
    /// Green: 0
    /// Blue: 0
    /// Alpha: 255
    static let darkRed = BLRgba32(r: 139, g: 0, b: 0, a: 255)
    
    /// Dark salmon color
    ///
    /// Red: 233
    /// Green: 150
    /// Blue: 122
    /// Alpha: 255
    static let darkSalmon = BLRgba32(r: 233, g: 150, b: 122, a: 255)
    
    /// Dark sea green color
    ///
    /// Red: 143
    /// Green: 188
    /// Blue: 139
    /// Alpha: 255
    static let darkSeaGreen = BLRgba32(r: 143, g: 188, b: 139, a: 255)
    
    /// Dark slate blue color
    ///
    /// Red: 72
    /// Green: 61
    /// Blue: 139
    /// Alpha: 255
    static let darkSlateBlue = BLRgba32(r: 72, g: 61, b: 139, a: 255)
    
    /// Dark slate gray color
    ///
    /// Red: 47
    /// Green: 79
    /// Blue: 79
    /// Alpha: 255
    static let darkSlateGray = BLRgba32(r: 47, g: 79, b: 79, a: 255)
    
    /// Dark turquoise color
    ///
    /// Red: 0
    /// Green: 206
    /// Blue: 209
    /// Alpha: 255
    static let darkTurquoise = BLRgba32(r: 0, g: 206, b: 209, a: 255)
    
    /// Dark violet color
    ///
    /// Red: 148
    /// Green: 0
    /// Blue: 211
    /// Alpha: 255
    static let darkViolet = BLRgba32(r: 148, g: 0, b: 211, a: 255)
    
    /// Deep pink color
    ///
    /// Red: 255
    /// Green: 20
    /// Blue: 147
    /// Alpha: 255
    static let deepPink = BLRgba32(r: 255, g: 20, b: 147, a: 255)
    
    /// Deep sky blue color
    ///
    /// Red: 0
    /// Green: 191
    /// Blue: 255
    /// Alpha: 255
    static let deepSkyBlue = BLRgba32(r: 0, g: 191, b: 255, a: 255)
    
    /// Dim gray color
    ///
    /// Red: 105
    /// Green: 105
    /// Blue: 105
    /// Alpha: 255
    static let dimGray = BLRgba32(r: 105, g: 105, b: 105, a: 255)
    
    /// Dodger blue color
    ///
    /// Red: 30
    /// Green: 144
    /// Blue: 255
    /// Alpha: 255
    static let dodgerBlue = BLRgba32(r: 30, g: 144, b: 255, a: 255)
    
    /// Firebrick color
    ///
    /// Red: 178
    /// Green: 34
    /// Blue: 34
    /// Alpha: 255
    static let firebrick = BLRgba32(r: 178, g: 34, b: 34, a: 255)
    
    /// Floral white color
    ///
    /// Red: 255
    /// Green: 250
    /// Blue: 240
    /// Alpha: 255
    static let floralWhite = BLRgba32(r: 255, g: 250, b: 240, a: 255)
    
    /// Forest green color
    ///
    /// Red: 34
    /// Green: 139
    /// Blue: 34
    /// Alpha: 255
    static let forestGreen = BLRgba32(r: 34, g: 139, b: 34, a: 255)
    
    /// Fuchsia color
    ///
    /// Red: 255
    /// Green: 0
    /// Blue: 255
    /// Alpha: 255
    static let fuchsia = BLRgba32(r: 255, g: 0, b: 255, a: 255)
    
    /// Gainsboro color
    ///
    /// Red: 220
    /// Green: 220
    /// Blue: 220
    /// Alpha: 255
    static let gainsboro = BLRgba32(r: 220, g: 220, b: 220, a: 255)
    
    /// Ghost white color
    ///
    /// Red: 248
    /// Green: 248
    /// Blue: 255
    /// Alpha: 255
    static let ghostWhite = BLRgba32(r: 248, g: 248, b: 255, a: 255)
    
    /// Gold color
    ///
    /// Red: 255
    /// Green: 215
    /// Blue: 0
    /// Alpha: 255
    static let gold = BLRgba32(r: 255, g: 215, b: 0, a: 255)
    
    /// Goldenrod color
    ///
    /// Red: 218
    /// Green: 165
    /// Blue: 32
    /// Alpha: 255
    static let goldenrod = BLRgba32(r: 218, g: 165, b: 32, a: 255)
    
    /// Gray color
    ///
    /// Red: 128
    /// Green: 128
    /// Blue: 128
    /// Alpha: 255
    static let gray = BLRgba32(r: 128, g: 128, b: 128, a: 255)
    
    /// Green color
    ///
    /// Red: 0
    /// Green: 128
    /// Blue: 0
    /// Alpha: 255
    static let green = BLRgba32(r: 0, g: 128, b: 0, a: 255)
    
    /// Green yellow color
    ///
    /// Red: 173
    /// Green: 255
    /// Blue: 47
    /// Alpha: 255
    static let greenYellow = BLRgba32(r: 173, g: 255, b: 47, a: 255)
    
    /// Honeydew color
    ///
    /// Red: 240
    /// Green: 255
    /// Blue: 240
    /// Alpha: 255
    static let honeydew = BLRgba32(r: 240, g: 255, b: 240, a: 255)
    
    /// Hot pink color
    ///
    /// Red: 255
    /// Green: 105
    /// Blue: 180
    /// Alpha: 255
    static let hotPink = BLRgba32(r: 255, g: 105, b: 180, a: 255)
    
    /// Indian red color
    ///
    /// Red: 205
    /// Green: 92
    /// Blue: 92
    /// Alpha: 255
    static let indianRed = BLRgba32(r: 205, g: 92, b: 92, a: 255)
    
    /// Indigo color
    ///
    /// Red: 75
    /// Green: 0
    /// Blue: 130
    /// Alpha: 255
    static let indigo = BLRgba32(r: 75, g: 0, b: 130, a: 255)
    
    /// Ivory color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 240
    /// Alpha: 255
    static let ivory = BLRgba32(r: 255, g: 255, b: 240, a: 255)
    
    /// Khaki color
    ///
    /// Red: 240
    /// Green: 230
    /// Blue: 140
    /// Alpha: 255
    static let khaki = BLRgba32(r: 240, g: 230, b: 140, a: 255)
    
    /// Lavender color
    ///
    /// Red: 230
    /// Green: 230
    /// Blue: 250
    /// Alpha: 255
    static let lavender = BLRgba32(r: 230, g: 230, b: 250, a: 255)
    
    /// Lavender blush color
    ///
    /// Red: 255
    /// Green: 240
    /// Blue: 245
    /// Alpha: 255
    static let lavenderBlush = BLRgba32(r: 255, g: 240, b: 245, a: 255)
    
    /// Lawn green color
    ///
    /// Red: 124
    /// Green: 252
    /// Blue: 0
    /// Alpha: 255
    static let lawnGreen = BLRgba32(r: 124, g: 252, b: 0, a: 255)
    
    /// Lemon chiffon color
    ///
    /// Red: 255
    /// Green: 250
    /// Blue: 205
    /// Alpha: 255
    static let lemonChiffon = BLRgba32(r: 255, g: 250, b: 205, a: 255)
    
    /// Light blue color
    ///
    /// Red: 173
    /// Green: 216
    /// Blue: 230
    /// Alpha: 255
    static let lightBlue = BLRgba32(r: 173, g: 216, b: 230, a: 255)
    
    /// Light coral color
    ///
    /// Red: 240
    /// Green: 128
    /// Blue: 128
    /// Alpha: 255
    static let lightCoral = BLRgba32(r: 240, g: 128, b: 128, a: 255)
    
    /// Light cyan color
    ///
    /// Red: 224
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let lightCyan = BLRgba32(r: 224, g: 255, b: 255, a: 255)
    
    /// Light goldenrod yellow color
    ///
    /// Red: 250
    /// Green: 250
    /// Blue: 210
    /// Alpha: 255
    static let lightGoldenrodYellow = BLRgba32(r: 250, g: 250, b: 210, a: 255)
    
    /// Light green color
    ///
    /// Red: 144
    /// Green: 238
    /// Blue: 144
    /// Alpha: 255
    static let lightGreen = BLRgba32(r: 144, g: 238, b: 144, a: 255)
    
    /// Light gray color
    ///
    /// Red: 211
    /// Green: 211
    /// Blue: 211
    /// Alpha: 255
    static let lightGray = BLRgba32(r: 211, g: 211, b: 211, a: 255)
    
    /// Light pink color
    ///
    /// Red: 255
    /// Green: 182
    /// Blue: 193
    /// Alpha: 255
    static let lightPink = BLRgba32(r: 255, g: 182, b: 193, a: 255)
    
    /// Light salmon color
    ///
    /// Red: 255
    /// Green: 160
    /// Blue: 122
    /// Alpha: 255
    static let lightSalmon = BLRgba32(r: 255, g: 160, b: 122, a: 255)
    
    /// Light sea green color
    ///
    /// Red: 32
    /// Green: 178
    /// Blue: 170
    /// Alpha: 255
    static let lightSeaGreen = BLRgba32(r: 32, g: 178, b: 170, a: 255)
    
    /// Light sky blue color
    ///
    /// Red: 135
    /// Green: 206
    /// Blue: 250
    /// Alpha: 255
    static let lightSkyBlue = BLRgba32(r: 135, g: 206, b: 250, a: 255)
    
    /// Light slate gray color
    ///
    /// Red: 119
    /// Green: 136
    /// Blue: 153
    /// Alpha: 255
    static let lightSlateGray = BLRgba32(r: 119, g: 136, b: 153, a: 255)
    
    /// Light steel blue color
    ///
    /// Red: 176
    /// Green: 196
    /// Blue: 222
    /// Alpha: 255
    static let lightSteelBlue = BLRgba32(r: 176, g: 196, b: 222, a: 255)
    
    /// Light yellow color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 224
    /// Alpha: 255
    static let lightYellow = BLRgba32(r: 255, g: 255, b: 224, a: 255)
    
    /// Lime color
    ///
    /// Red: 0
    /// Green: 255
    /// Blue: 0
    /// Alpha: 255
    static let lime = BLRgba32(r: 0, g: 255, b: 0, a: 255)
    
    /// Lime green color
    ///
    /// Red: 50
    /// Green: 205
    /// Blue: 50
    /// Alpha: 255
    static let limeGreen = BLRgba32(r: 50, g: 205, b: 50, a: 255)
    
    /// Linen color
    ///
    /// Red: 250
    /// Green: 240
    /// Blue: 230
    /// Alpha: 255
    static let linen = BLRgba32(r: 250, g: 240, b: 230, a: 255)
    
    /// Magenta color
    ///
    /// Red: 255
    /// Green: 0
    /// Blue: 255
    /// Alpha: 255
    static let magenta = BLRgba32(r: 255, g: 0, b: 255, a: 255)
    
    /// Maroon color
    ///
    /// Red: 128
    /// Green: 0
    /// Blue: 0
    /// Alpha: 255
    static let maroon = BLRgba32(r: 128, g: 0, b: 0, a: 255)
    
    /// Medium aquamarine color
    ///
    /// Red: 102
    /// Green: 205
    /// Blue: 170
    /// Alpha: 255
    static let mediumAquamarine = BLRgba32(r: 102, g: 205, b: 170, a: 255)
    
    /// Medium blue color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 205
    /// Alpha: 255
    static let mediumBlue = BLRgba32(r: 0, g: 0, b: 205, a: 255)
    
    /// Medium orchid color
    ///
    /// Red: 186
    /// Green: 85
    /// Blue: 211
    /// Alpha: 255
    static let mediumOrchid = BLRgba32(r: 186, g: 85, b: 211, a: 255)
    
    /// Medium purple color
    ///
    /// Red: 147
    /// Green: 112
    /// Blue: 219
    /// Alpha: 255
    static let mediumPurple = BLRgba32(r: 147, g: 112, b: 219, a: 255)
    
    /// Medium sea green color
    ///
    /// Red: 60
    /// Green: 179
    /// Blue: 113
    /// Alpha: 255
    static let mediumSeaGreen = BLRgba32(r: 60, g: 179, b: 113, a: 255)
    
    /// Medium slate blue color
    ///
    /// Red: 123
    /// Green: 104
    /// Blue: 238
    /// Alpha: 255
    static let mediumSlateBlue = BLRgba32(r: 123, g: 104, b: 238, a: 255)
    
    /// Medium spring green color
    ///
    /// Red: 0
    /// Green: 250
    /// Blue: 154
    /// Alpha: 255
    static let mediumSpringGreen = BLRgba32(r: 0, g: 250, b: 154, a: 255)
    
    /// Medium turquoise color
    ///
    /// Red: 72
    /// Green: 209
    /// Blue: 204
    /// Alpha: 255
    static let mediumTurquoise = BLRgba32(r: 72, g: 209, b: 204, a: 255)
    
    /// Medium violet red color
    ///
    /// Red: 199
    /// Green: 21
    /// Blue: 133
    /// Alpha: 255
    static let mediumVioletRed = BLRgba32(r: 199, g: 21, b: 133, a: 255)
    
    /// Midnight blue color
    ///
    /// Red: 25
    /// Green: 25
    /// Blue: 112
    /// Alpha: 255
    static let midnightBlue = BLRgba32(r: 25, g: 25, b: 112, a: 255)
    
    /// Mint cream color
    ///
    /// Red: 245
    /// Green: 255
    /// Blue: 250
    /// Alpha: 255
    static let mintCream = BLRgba32(r: 245, g: 255, b: 250, a: 255)
    
    /// Misty rose color
    ///
    /// Red: 255
    /// Green: 228
    /// Blue: 225
    /// Alpha: 255
    static let mistyRose = BLRgba32(r: 255, g: 228, b: 225, a: 255)
    
    /// Moccasin color
    ///
    /// Red: 255
    /// Green: 228
    /// Blue: 181
    /// Alpha: 255
    static let moccasin = BLRgba32(r: 255, g: 228, b: 181, a: 255)
    
    /// Navajo white color
    ///
    /// Red: 255
    /// Green: 222
    /// Blue: 173
    /// Alpha: 255
    static let navajoWhite = BLRgba32(r: 255, g: 222, b: 173, a: 255)
    
    /// Navy color
    ///
    /// Red: 0
    /// Green: 0
    /// Blue: 128
    /// Alpha: 255
    static let navy = BLRgba32(r: 0, g: 0, b: 128, a: 255)
    
    /// Old lace color
    ///
    /// Red: 253
    /// Green: 245
    /// Blue: 230
    /// Alpha: 255
    static let oldLace = BLRgba32(r: 253, g: 245, b: 230, a: 255)
    
    /// Olive color
    ///
    /// Red: 128
    /// Green: 128
    /// Blue: 0
    /// Alpha: 255
    static let olive = BLRgba32(r: 128, g: 128, b: 0, a: 255)
    
    /// Olive drab color
    ///
    /// Red: 107
    /// Green: 142
    /// Blue: 35
    /// Alpha: 255
    static let oliveDrab = BLRgba32(r: 107, g: 142, b: 35, a: 255)
    
    /// Orange color
    ///
    /// Red: 255
    /// Green: 165
    /// Blue: 0
    /// Alpha: 255
    static let orange = BLRgba32(r: 255, g: 165, b: 0, a: 255)
    
    /// Orange red color
    ///
    /// Red: 255
    /// Green: 69
    /// Blue: 0
    /// Alpha: 255
    static let orangeRed = BLRgba32(r: 255, g: 69, b: 0, a: 255)
    
    /// Orchid color
    ///
    /// Red: 218
    /// Green: 112
    /// Blue: 214
    /// Alpha: 255
    static let orchid = BLRgba32(r: 218, g: 112, b: 214, a: 255)
    
    /// Pale goldenrod color
    ///
    /// Red: 238
    /// Green: 232
    /// Blue: 170
    /// Alpha: 255
    static let paleGoldenrod = BLRgba32(r: 238, g: 232, b: 170, a: 255)
    
    /// Pale green color
    ///
    /// Red: 152
    /// Green: 251
    /// Blue: 152
    /// Alpha: 255
    static let paleGreen = BLRgba32(r: 152, g: 251, b: 152, a: 255)
    
    /// Pale turquoise color
    ///
    /// Red: 175
    /// Green: 238
    /// Blue: 238
    /// Alpha: 255
    static let paleTurquoise = BLRgba32(r: 175, g: 238, b: 238, a: 255)
    
    /// Pale violet red color
    ///
    /// Red: 219
    /// Green: 112
    /// Blue: 147
    /// Alpha: 255
    static let paleVioletRed = BLRgba32(r: 219, g: 112, b: 147, a: 255)
    
    /// Papaya whip color
    ///
    /// Red: 255
    /// Green: 239
    /// Blue: 213
    /// Alpha: 255
    static let papayaWhip = BLRgba32(r: 255, g: 239, b: 213, a: 255)
    
    /// Peach puff color
    ///
    /// Red: 255
    /// Green: 218
    /// Blue: 185
    /// Alpha: 255
    static let peachPuff = BLRgba32(r: 255, g: 218, b: 185, a: 255)
    
    /// Peru color
    ///
    /// Red: 205
    /// Green: 133
    /// Blue: 63
    /// Alpha: 255
    static let peru = BLRgba32(r: 205, g: 133, b: 63, a: 255)
    
    /// Pink color
    ///
    /// Red: 255
    /// Green: 192
    /// Blue: 203
    /// Alpha: 255
    static let pink = BLRgba32(r: 255, g: 192, b: 203, a: 255)
    
    /// Plum color
    ///
    /// Red: 221
    /// Green: 160
    /// Blue: 221
    /// Alpha: 255
    static let plum = BLRgba32(r: 221, g: 160, b: 221, a: 255)
    
    /// Powder blue color
    ///
    /// Red: 176
    /// Green: 224
    /// Blue: 230
    /// Alpha: 255
    static let powderBlue = BLRgba32(r: 176, g: 224, b: 230, a: 255)
    
    /// Purple color
    ///
    /// Red: 128
    /// Green: 0
    /// Blue: 128
    /// Alpha: 255
    static let purple = BLRgba32(r: 128, g: 0, b: 128, a: 255)
    
    /// Red color
    ///
    /// Red: 255
    /// Green: 0
    /// Blue: 0
    /// Alpha: 255
    static let red = BLRgba32(r: 255, g: 0, b: 0, a: 255)
    
    /// Rosy brown color
    ///
    /// Red: 188
    /// Green: 143
    /// Blue: 143
    /// Alpha: 255
    static let rosyBrown = BLRgba32(r: 188, g: 143, b: 143, a: 255)
    
    /// Royal blue color
    ///
    /// Red: 65
    /// Green: 105
    /// Blue: 225
    /// Alpha: 255
    static let royalBlue = BLRgba32(r: 65, g: 105, b: 225, a: 255)
    
    /// Saddle brown color
    ///
    /// Red: 139
    /// Green: 69
    /// Blue: 19
    /// Alpha: 255
    static let saddleBrown = BLRgba32(r: 139, g: 69, b: 19, a: 255)
    
    /// Salmon color
    ///
    /// Red: 250
    /// Green: 128
    /// Blue: 114
    /// Alpha: 255
    static let salmon = BLRgba32(r: 250, g: 128, b: 114, a: 255)
    
    /// Sandy brown color
    ///
    /// Red: 244
    /// Green: 164
    /// Blue: 96
    /// Alpha: 255
    static let sandyBrown = BLRgba32(r: 244, g: 164, b: 96, a: 255)
    
    /// Sea green color
    ///
    /// Red: 46
    /// Green: 139
    /// Blue: 87
    /// Alpha: 255
    static let seaGreen = BLRgba32(r: 46, g: 139, b: 87, a: 255)
    
    /// Sea shell color
    ///
    /// Red: 255
    /// Green: 245
    /// Blue: 238
    /// Alpha: 255
    static let seaShell = BLRgba32(r: 255, g: 245, b: 238, a: 255)
    
    /// Sienna color
    ///
    /// Red: 160
    /// Green: 82
    /// Blue: 45
    /// Alpha: 255
    static let sienna = BLRgba32(r: 160, g: 82, b: 45, a: 255)
    
    /// Silver color
    ///
    /// Red: 192
    /// Green: 192
    /// Blue: 192
    /// Alpha: 255
    static let silver = BLRgba32(r: 192, g: 192, b: 192, a: 255)
    
    /// Sky blue color
    ///
    /// Red: 135
    /// Green: 206
    /// Blue: 235
    /// Alpha: 255
    static let skyBlue = BLRgba32(r: 135, g: 206, b: 235, a: 255)
    
    /// Slate blue color
    ///
    /// Red: 106
    /// Green: 90
    /// Blue: 205
    /// Alpha: 255
    static let slateBlue = BLRgba32(r: 106, g: 90, b: 205, a: 255)
    
    /// Slate gray color
    ///
    /// Red: 112
    /// Green: 128
    /// Blue: 144
    /// Alpha: 255
    static let slateGray = BLRgba32(r: 112, g: 128, b: 144, a: 255)
    
    /// Snow color
    ///
    /// Red: 255
    /// Green: 250
    /// Blue: 250
    /// Alpha: 255
    static let snow = BLRgba32(r: 255, g: 250, b: 250, a: 255)
    
    /// Spring green color
    ///
    /// Red: 0
    /// Green: 255
    /// Blue: 127
    /// Alpha: 255
    static let springGreen = BLRgba32(r: 0, g: 255, b: 127, a: 255)
    
    /// Steel blue color
    ///
    /// Red: 70
    /// Green: 130
    /// Blue: 180
    /// Alpha: 255
    static let steelBlue = BLRgba32(r: 70, g: 130, b: 180, a: 255)
    
    /// Tan color
    ///
    /// Red: 210
    /// Green: 180
    /// Blue: 140
    /// Alpha: 255
    static let tan = BLRgba32(r: 210, g: 180, b: 140, a: 255)
    
    /// Teal color
    ///
    /// Red: 0
    /// Green: 128
    /// Blue: 128
    /// Alpha: 255
    static let teal = BLRgba32(r: 0, g: 128, b: 128, a: 255)
    
    /// Thistle color
    ///
    /// Red: 216
    /// Green: 191
    /// Blue: 216
    /// Alpha: 255
    static let thistle = BLRgba32(r: 216, g: 191, b: 216, a: 255)
    
    /// Tomato color
    ///
    /// Red: 255
    /// Green: 99
    /// Blue: 71
    /// Alpha: 255
    static let tomato = BLRgba32(r: 255, g: 99, b: 71, a: 255)
    
    /// Turquoise color
    ///
    /// Red: 64
    /// Green: 224
    /// Blue: 208
    /// Alpha: 255
    static let turquoise = BLRgba32(r: 64, g: 224, b: 208, a: 255)
    
    /// Violet color
    ///
    /// Red: 238
    /// Green: 130
    /// Blue: 238
    /// Alpha: 255
    static let violet = BLRgba32(r: 238, g: 130, b: 238, a: 255)
    
    /// Wheat color
    ///
    /// Red: 245
    /// Green: 222
    /// Blue: 179
    /// Alpha: 255
    static let wheat = BLRgba32(r: 245, g: 222, b: 179, a: 255)
    
    /// White color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 255
    /// Alpha: 255
    static let white = BLRgba32(r: 255, g: 255, b: 255, a: 255)
    
    /// White smoke color
    ///
    /// Red: 245
    /// Green: 245
    /// Blue: 245
    /// Alpha: 255
    static let whiteSmoke = BLRgba32(r: 245, g: 245, b: 245, a: 255)
    
    /// Yellow color
    ///
    /// Red: 255
    /// Green: 255
    /// Blue: 0
    /// Alpha: 255
    static let yellow = BLRgba32(r: 255, g: 255, b: 0, a: 255)
    
    /// Yellow green color
    ///
    /// Red: 154
    /// Green: 205
    /// Blue: 50
    /// Alpha: 255
    static let yellowGreen = BLRgba32(r: 154, g: 205, b: 50, a: 255)
}
