import blend2d

public extension BLRgba128 {
    /// Transparent black color (red: 0, green: 0, blue: 0, alpha: 0)
    static let transparentBlack = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 0 / 255.0)
    
    /// Transparent white color (red: 255, green: 255, blue: 255, alpha: 0)
    static let transparentWhite = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 0 / 255.0)
    
    /// Alice blue color (red: 240, green: 248, blue: 255, alpha: 255)
    static let aliceBlue = BLRgba128(r: 240 / 255.0, g: 248 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Antique white color (red: 250, green: 235, blue: 215, alpha: 255)
    static let antiqueWhite = BLRgba128(r: 250 / 255.0, g: 235 / 255.0, b: 215 / 255.0, a: 255 / 255.0)
    
    /// Aqua color (red: 0, green: 255, blue: 255, alpha: 255)
    static let aqua = BLRgba128(r: 0 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Aquamarine color (red: 127, green: 255, blue: 212, alpha: 255)
    static let aquamarine = BLRgba128(r: 127 / 255.0, g: 255 / 255.0, b: 212 / 255.0, a: 255 / 255.0)
    
    /// Azure color (red: 240, green: 255, blue: 255, alpha: 255)
    static let azure = BLRgba128(r: 240 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Beige color (red: 245, green: 245, blue: 220, alpha: 255)
    static let beige = BLRgba128(r: 245 / 255.0, g: 245 / 255.0, b: 220 / 255.0, a: 255 / 255.0)
    
    /// Bisque color (red: 255, green: 228, blue: 196, alpha: 255)
    static let bisque = BLRgba128(r: 255 / 255.0, g: 228 / 255.0, b: 196 / 255.0, a: 255 / 255.0)
    
    /// Black color (red: 0, green: 0, blue: 0, alpha: 255)
    static let black = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Blanched almond color (red: 255, green: 235, blue: 205, alpha: 255)
    static let blanchedAlmond = BLRgba128(r: 255 / 255.0, g: 235 / 255.0, b: 205 / 255.0, a: 255 / 255.0)
    
    /// Blue color (red: 0, green: 0, blue: 255, alpha: 255)
    static let blue = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Blue violet color (red: 138, green: 43, blue: 226, alpha: 255)
    static let blueViolet = BLRgba128(r: 138 / 255.0, g: 43 / 255.0, b: 226 / 255.0, a: 255 / 255.0)
    
    /// Brown color (red: 165, green: 42, blue: 42, alpha: 255)
    static let brown = BLRgba128(r: 165 / 255.0, g: 42 / 255.0, b: 42 / 255.0, a: 255 / 255.0)
    
    /// Burly wood color (red: 222, green: 184, blue: 135, alpha: 255)
    static let burlyWood = BLRgba128(r: 222 / 255.0, g: 184 / 255.0, b: 135 / 255.0, a: 255 / 255.0)
    
    /// Cadet blue color (red: 95, green: 158, blue: 160, alpha: 255)
    static let cadetBlue = BLRgba128(r: 95 / 255.0, g: 158 / 255.0, b: 160 / 255.0, a: 255 / 255.0)
    
    /// Chartreuse color (red: 127, green: 255, blue: 0, alpha: 255)
    static let chartreuse = BLRgba128(r: 127 / 255.0, g: 255 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Chocolate color (red: 210, green: 105, blue: 30, alpha: 255)
    static let chocolate = BLRgba128(r: 210 / 255.0, g: 105 / 255.0, b: 30 / 255.0, a: 255 / 255.0)
    
    /// Coral color (red: 255, green: 127, blue: 80, alpha: 255)
    static let coral = BLRgba128(r: 255 / 255.0, g: 127 / 255.0, b: 80 / 255.0, a: 255 / 255.0)
    
    /// Cornflower blue color (red: 100, green: 149, blue: 237, alpha: 255)
    static let cornflowerBlue = BLRgba128(r: 100 / 255.0, g: 149 / 255.0, b: 237 / 255.0, a: 255 / 255.0)
    
    /// Cornsilk color (red: 255, green: 248, blue: 220, alpha: 255)
    static let cornsilk = BLRgba128(r: 255 / 255.0, g: 248 / 255.0, b: 220 / 255.0, a: 255 / 255.0)
    
    /// Crimson color (red: 220, green: 20, blue: 60, alpha: 255)
    static let crimson = BLRgba128(r: 220 / 255.0, g: 20 / 255.0, b: 60 / 255.0, a: 255 / 255.0)
    
    /// Cyan color (red: 0, green: 255, blue: 255, alpha: 255)
    static let cyan = BLRgba128(r: 0 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Dark blue color (red: 0, green: 0, blue: 139, alpha: 255)
    static let darkBlue = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark cyan color (red: 0, green: 139, blue: 139, alpha: 255)
    static let darkCyan = BLRgba128(r: 0 / 255.0, g: 139 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark goldenrod color (red: 184, green: 134, blue: 11, alpha: 255)
    static let darkGoldenrod = BLRgba128(r: 184 / 255.0, g: 134 / 255.0, b: 11 / 255.0, a: 255 / 255.0)
    
    /// Dark gray color (red: 169, green: 169, blue: 169, alpha: 255)
    static let darkGray = BLRgba128(r: 169 / 255.0, g: 169 / 255.0, b: 169 / 255.0, a: 255 / 255.0)
    
    /// Dark green color (red: 0, green: 100, blue: 0, alpha: 255)
    static let darkGreen = BLRgba128(r: 0 / 255.0, g: 100 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Dark khaki color (red: 189, green: 183, blue: 107, alpha: 255)
    static let darkKhaki = BLRgba128(r: 189 / 255.0, g: 183 / 255.0, b: 107 / 255.0, a: 255 / 255.0)
    
    /// Dark magenta color (red: 139, green: 0, blue: 139, alpha: 255)
    static let darkMagenta = BLRgba128(r: 139 / 255.0, g: 0 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark olive green color (red: 85, green: 107, blue: 47, alpha: 255)
    static let darkOliveGreen = BLRgba128(r: 85 / 255.0, g: 107 / 255.0, b: 47 / 255.0, a: 255 / 255.0)
    
    /// Dark orange color (red: 255, green: 140, blue: 0, alpha: 255)
    static let darkOrange = BLRgba128(r: 255 / 255.0, g: 140 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Dark orchid color (red: 153, green: 50, blue: 204, alpha: 255)
    static let darkOrchid = BLRgba128(r: 153 / 255.0, g: 50 / 255.0, b: 204 / 255.0, a: 255 / 255.0)
    
    /// Dark red color (red: 139, green: 0, blue: 0, alpha: 255)
    static let darkRed = BLRgba128(r: 139 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Dark salmon color (red: 233, green: 150, blue: 122, alpha: 255)
    static let darkSalmon = BLRgba128(r: 233 / 255.0, g: 150 / 255.0, b: 122 / 255.0, a: 255 / 255.0)
    
    /// Dark sea green color (red: 143, green: 188, blue: 139, alpha: 255)
    static let darkSeaGreen = BLRgba128(r: 143 / 255.0, g: 188 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark slate blue color (red: 72, green: 61, blue: 139, alpha: 255)
    static let darkSlateBlue = BLRgba128(r: 72 / 255.0, g: 61 / 255.0, b: 139 / 255.0, a: 255 / 255.0)
    
    /// Dark slate gray color (red: 47, green: 79, blue: 79, alpha: 255)
    static let darkSlateGray = BLRgba128(r: 47 / 255.0, g: 79 / 255.0, b: 79 / 255.0, a: 255 / 255.0)
    
    /// Dark turquoise color (red: 0, green: 206, blue: 209, alpha: 255)
    static let darkTurquoise = BLRgba128(r: 0 / 255.0, g: 206 / 255.0, b: 209 / 255.0, a: 255 / 255.0)
    
    /// Dark violet color (red: 148, green: 0, blue: 211, alpha: 255)
    static let darkViolet = BLRgba128(r: 148 / 255.0, g: 0 / 255.0, b: 211 / 255.0, a: 255 / 255.0)
    
    /// Deep pink color (red: 255, green: 20, blue: 147, alpha: 255)
    static let deepPink = BLRgba128(r: 255 / 255.0, g: 20 / 255.0, b: 147 / 255.0, a: 255 / 255.0)
    
    /// Deep sky blue color (red: 0, green: 191, blue: 255, alpha: 255)
    static let deepSkyBlue = BLRgba128(r: 0 / 255.0, g: 191 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Dim gray color (red: 105, green: 105, blue: 105, alpha: 255)
    static let dimGray = BLRgba128(r: 105 / 255.0, g: 105 / 255.0, b: 105 / 255.0, a: 255 / 255.0)
    
    /// Dodger blue color (red: 30, green: 144, blue: 255, alpha: 255)
    static let dodgerBlue = BLRgba128(r: 30 / 255.0, g: 144 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Firebrick color (red: 178, green: 34, blue: 34, alpha: 255)
    static let firebrick = BLRgba128(r: 178 / 255.0, g: 34 / 255.0, b: 34 / 255.0, a: 255 / 255.0)
    
    /// Floral white color (red: 255, green: 250, blue: 240, alpha: 255)
    static let floralWhite = BLRgba128(r: 255 / 255.0, g: 250 / 255.0, b: 240 / 255.0, a: 255 / 255.0)
    
    /// Forest green color (red: 34, green: 139, blue: 34, alpha: 255)
    static let forestGreen = BLRgba128(r: 34 / 255.0, g: 139 / 255.0, b: 34 / 255.0, a: 255 / 255.0)
    
    /// Fuchsia color (red: 255, green: 0, blue: 255, alpha: 255)
    static let fuchsia = BLRgba128(r: 255 / 255.0, g: 0 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Gainsboro color (red: 220, green: 220, blue: 220, alpha: 255)
    static let gainsboro = BLRgba128(r: 220 / 255.0, g: 220 / 255.0, b: 220 / 255.0, a: 255 / 255.0)
    
    /// Ghost white color (red: 248, green: 248, blue: 255, alpha: 255)
    static let ghostWhite = BLRgba128(r: 248 / 255.0, g: 248 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Gold color (red: 255, green: 215, blue: 0, alpha: 255)
    static let gold = BLRgba128(r: 255 / 255.0, g: 215 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Goldenrod color (red: 218, green: 165, blue: 32, alpha: 255)
    static let goldenrod = BLRgba128(r: 218 / 255.0, g: 165 / 255.0, b: 32 / 255.0, a: 255 / 255.0)
    
    /// Gray color (red: 128, green: 128, blue: 128, alpha: 255)
    static let gray = BLRgba128(r: 128 / 255.0, g: 128 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Green color (red: 0, green: 128, blue: 0, alpha: 255)
    static let green = BLRgba128(r: 0 / 255.0, g: 128 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Green yellow color (red: 173, green: 255, blue: 47, alpha: 255)
    static let greenYellow = BLRgba128(r: 173 / 255.0, g: 255 / 255.0, b: 47 / 255.0, a: 255 / 255.0)
    
    /// Honeydew color (red: 240, green: 255, blue: 240, alpha: 255)
    static let honeydew = BLRgba128(r: 240 / 255.0, g: 255 / 255.0, b: 240 / 255.0, a: 255 / 255.0)
    
    /// Hot pink color (red: 255, green: 105, blue: 180, alpha: 255)
    static let hotPink = BLRgba128(r: 255 / 255.0, g: 105 / 255.0, b: 180 / 255.0, a: 255 / 255.0)
    
    /// Indian red color (red: 205, green: 92, blue: 92, alpha: 255)
    static let indianRed = BLRgba128(r: 205 / 255.0, g: 92 / 255.0, b: 92 / 255.0, a: 255 / 255.0)
    
    /// Indigo color (red: 75, green: 0, blue: 130, alpha: 255)
    static let indigo = BLRgba128(r: 75 / 255.0, g: 0 / 255.0, b: 130 / 255.0, a: 255 / 255.0)
    
    /// Ivory color (red: 255, green: 255, blue: 240, alpha: 255)
    static let ivory = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 240 / 255.0, a: 255 / 255.0)
    
    /// Khaki color (red: 240, green: 230, blue: 140, alpha: 255)
    static let khaki = BLRgba128(r: 240 / 255.0, g: 230 / 255.0, b: 140 / 255.0, a: 255 / 255.0)
    
    /// Lavender color (red: 230, green: 230, blue: 250, alpha: 255)
    static let lavender = BLRgba128(r: 230 / 255.0, g: 230 / 255.0, b: 250 / 255.0, a: 255 / 255.0)
    
    /// Lavender blush color (red: 255, green: 240, blue: 245, alpha: 255)
    static let lavenderBlush = BLRgba128(r: 255 / 255.0, g: 240 / 255.0, b: 245 / 255.0, a: 255 / 255.0)
    
    /// Lawn green color (red: 124, green: 252, blue: 0, alpha: 255)
    static let lawnGreen = BLRgba128(r: 124 / 255.0, g: 252 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Lemon chiffon color (red: 255, green: 250, blue: 205, alpha: 255)
    static let lemonChiffon = BLRgba128(r: 255 / 255.0, g: 250 / 255.0, b: 205 / 255.0, a: 255 / 255.0)
    
    /// Light blue color (red: 173, green: 216, blue: 230, alpha: 255)
    static let lightBlue = BLRgba128(r: 173 / 255.0, g: 216 / 255.0, b: 230 / 255.0, a: 255 / 255.0)
    
    /// Light coral color (red: 240, green: 128, blue: 128, alpha: 255)
    static let lightCoral = BLRgba128(r: 240 / 255.0, g: 128 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Light cyan color (red: 224, green: 255, blue: 255, alpha: 255)
    static let lightCyan = BLRgba128(r: 224 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Light goldenrod yellow color (red: 250, green: 250, blue: 210, alpha: 255)
    static let lightGoldenrodYellow = BLRgba128(r: 250 / 255.0, g: 250 / 255.0, b: 210 / 255.0, a: 255 / 255.0)
    
    /// Light green color (red: 144, green: 238, blue: 144, alpha: 255)
    static let lightGreen = BLRgba128(r: 144 / 255.0, g: 238 / 255.0, b: 144 / 255.0, a: 255 / 255.0)
    
    /// Light gray color (red: 211, green: 211, blue: 211, alpha: 255)
    static let lightGray = BLRgba128(r: 211 / 255.0, g: 211 / 255.0, b: 211 / 255.0, a: 255 / 255.0)
    
    /// Light pink color (red: 255, green: 182, blue: 193, alpha: 255)
    static let lightPink = BLRgba128(r: 255 / 255.0, g: 182 / 255.0, b: 193 / 255.0, a: 255 / 255.0)
    
    /// Light salmon color (red: 255, green: 160, blue: 122, alpha: 255)
    static let lightSalmon = BLRgba128(r: 255 / 255.0, g: 160 / 255.0, b: 122 / 255.0, a: 255 / 255.0)
    
    /// Light sea green color (red: 32, green: 178, blue: 170, alpha: 255)
    static let lightSeaGreen = BLRgba128(r: 32 / 255.0, g: 178 / 255.0, b: 170 / 255.0, a: 255 / 255.0)
    
    /// Light sky blue color (red: 135, green: 206, blue: 250, alpha: 255)
    static let lightSkyBlue = BLRgba128(r: 135 / 255.0, g: 206 / 255.0, b: 250 / 255.0, a: 255 / 255.0)
    
    /// Light slate gray color (red: 119, green: 136, blue: 153, alpha: 255)
    static let lightSlateGray = BLRgba128(r: 119 / 255.0, g: 136 / 255.0, b: 153 / 255.0, a: 255 / 255.0)
    
    /// Light steel blue color (red: 176, green: 196, blue: 222, alpha: 255)
    static let lightSteelBlue = BLRgba128(r: 176 / 255.0, g: 196 / 255.0, b: 222 / 255.0, a: 255 / 255.0)
    
    /// Light yellow color (red: 255, green: 255, blue: 224, alpha: 255)
    static let lightYellow = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 224 / 255.0, a: 255 / 255.0)
    
    /// Lime color (red: 0, green: 255, blue: 0, alpha: 255)
    static let lime = BLRgba128(r: 0 / 255.0, g: 255 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Lime green color (red: 50, green: 205, blue: 50, alpha: 255)
    static let limeGreen = BLRgba128(r: 50 / 255.0, g: 205 / 255.0, b: 50 / 255.0, a: 255 / 255.0)
    
    /// Linen color (red: 250, green: 240, blue: 230, alpha: 255)
    static let linen = BLRgba128(r: 250 / 255.0, g: 240 / 255.0, b: 230 / 255.0, a: 255 / 255.0)
    
    /// Magenta color (red: 255, green: 0, blue: 255, alpha: 255)
    static let magenta = BLRgba128(r: 255 / 255.0, g: 0 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// Maroon color (red: 128, green: 0, blue: 0, alpha: 255)
    static let maroon = BLRgba128(r: 128 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Medium aquamarine color (red: 102, green: 205, blue: 170, alpha: 255)
    static let mediumAquamarine = BLRgba128(r: 102 / 255.0, g: 205 / 255.0, b: 170 / 255.0, a: 255 / 255.0)
    
    /// Medium blue color (red: 0, green: 0, blue: 205, alpha: 255)
    static let mediumBlue = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 205 / 255.0, a: 255 / 255.0)
    
    /// Medium orchid color (red: 186, green: 85, blue: 211, alpha: 255)
    static let mediumOrchid = BLRgba128(r: 186 / 255.0, g: 85 / 255.0, b: 211 / 255.0, a: 255 / 255.0)
    
    /// Medium purple color (red: 147, green: 112, blue: 219, alpha: 255)
    static let mediumPurple = BLRgba128(r: 147 / 255.0, g: 112 / 255.0, b: 219 / 255.0, a: 255 / 255.0)
    
    /// Medium sea green color (red: 60, green: 179, blue: 113, alpha: 255)
    static let mediumSeaGreen = BLRgba128(r: 60 / 255.0, g: 179 / 255.0, b: 113 / 255.0, a: 255 / 255.0)
    
    /// Medium slate blue color (red: 123, green: 104, blue: 238, alpha: 255)
    static let mediumSlateBlue = BLRgba128(r: 123 / 255.0, g: 104 / 255.0, b: 238 / 255.0, a: 255 / 255.0)
    
    /// Medium spring green color (red: 0, green: 250, blue: 154, alpha: 255)
    static let mediumSpringGreen = BLRgba128(r: 0 / 255.0, g: 250 / 255.0, b: 154 / 255.0, a: 255 / 255.0)
    
    /// Medium turquoise color (red: 72, green: 209, blue: 204, alpha: 255)
    static let mediumTurquoise = BLRgba128(r: 72 / 255.0, g: 209 / 255.0, b: 204 / 255.0, a: 255 / 255.0)
    
    /// Medium violet red color (red: 199, green: 21, blue: 133, alpha: 255)
    static let mediumVioletRed = BLRgba128(r: 199 / 255.0, g: 21 / 255.0, b: 133 / 255.0, a: 255 / 255.0)
    
    /// Midnight blue color (red: 25, green: 25, blue: 112, alpha: 255)
    static let midnightBlue = BLRgba128(r: 25 / 255.0, g: 25 / 255.0, b: 112 / 255.0, a: 255 / 255.0)
    
    /// Mint cream color (red: 245, green: 255, blue: 250, alpha: 255)
    static let mintCream = BLRgba128(r: 245 / 255.0, g: 255 / 255.0, b: 250 / 255.0, a: 255 / 255.0)
    
    /// Misty rose color (red: 255, green: 228, blue: 225, alpha: 255)
    static let mistyRose = BLRgba128(r: 255 / 255.0, g: 228 / 255.0, b: 225 / 255.0, a: 255 / 255.0)
    
    /// Moccasin color (red: 255, green: 228, blue: 181, alpha: 255)
    static let moccasin = BLRgba128(r: 255 / 255.0, g: 228 / 255.0, b: 181 / 255.0, a: 255 / 255.0)
    
    /// Navajo white color (red: 255, green: 222, blue: 173, alpha: 255)
    static let navajoWhite = BLRgba128(r: 255 / 255.0, g: 222 / 255.0, b: 173 / 255.0, a: 255 / 255.0)
    
    /// Navy color (red: 0, green: 0, blue: 128, alpha: 255)
    static let navy = BLRgba128(r: 0 / 255.0, g: 0 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Old lace color (red: 253, green: 245, blue: 230, alpha: 255)
    static let oldLace = BLRgba128(r: 253 / 255.0, g: 245 / 255.0, b: 230 / 255.0, a: 255 / 255.0)
    
    /// Olive color (red: 128, green: 128, blue: 0, alpha: 255)
    static let olive = BLRgba128(r: 128 / 255.0, g: 128 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Olive drab color (red: 107, green: 142, blue: 35, alpha: 255)
    static let oliveDrab = BLRgba128(r: 107 / 255.0, g: 142 / 255.0, b: 35 / 255.0, a: 255 / 255.0)
    
    /// Orange color (red: 255, green: 165, blue: 0, alpha: 255)
    static let orange = BLRgba128(r: 255 / 255.0, g: 165 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Orange red color (red: 255, green: 69, blue: 0, alpha: 255)
    static let orangeRed = BLRgba128(r: 255 / 255.0, g: 69 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Orchid color (red: 218, green: 112, blue: 214, alpha: 255)
    static let orchid = BLRgba128(r: 218 / 255.0, g: 112 / 255.0, b: 214 / 255.0, a: 255 / 255.0)
    
    /// Pale goldenrod color (red: 238, green: 232, blue: 170, alpha: 255)
    static let paleGoldenrod = BLRgba128(r: 238 / 255.0, g: 232 / 255.0, b: 170 / 255.0, a: 255 / 255.0)
    
    /// Pale green color (red: 152, green: 251, blue: 152, alpha: 255)
    static let paleGreen = BLRgba128(r: 152 / 255.0, g: 251 / 255.0, b: 152 / 255.0, a: 255 / 255.0)
    
    /// Pale turquoise color (red: 175, green: 238, blue: 238, alpha: 255)
    static let paleTurquoise = BLRgba128(r: 175 / 255.0, g: 238 / 255.0, b: 238 / 255.0, a: 255 / 255.0)
    
    /// Pale violet red color (red: 219, green: 112, blue: 147, alpha: 255)
    static let paleVioletRed = BLRgba128(r: 219 / 255.0, g: 112 / 255.0, b: 147 / 255.0, a: 255 / 255.0)
    
    /// Papaya whip color (red: 255, green: 239, blue: 213, alpha: 255)
    static let papayaWhip = BLRgba128(r: 255 / 255.0, g: 239 / 255.0, b: 213 / 255.0, a: 255 / 255.0)
    
    /// Peach puff color (red: 255, green: 218, blue: 185, alpha: 255)
    static let peachPuff = BLRgba128(r: 255 / 255.0, g: 218 / 255.0, b: 185 / 255.0, a: 255 / 255.0)
    
    /// Peru color (red: 205, green: 133, blue: 63, alpha: 255)
    static let peru = BLRgba128(r: 205 / 255.0, g: 133 / 255.0, b: 63 / 255.0, a: 255 / 255.0)
    
    /// Pink color (red: 255, green: 192, blue: 203, alpha: 255)
    static let pink = BLRgba128(r: 255 / 255.0, g: 192 / 255.0, b: 203 / 255.0, a: 255 / 255.0)
    
    /// Plum color (red: 221, green: 160, blue: 221, alpha: 255)
    static let plum = BLRgba128(r: 221 / 255.0, g: 160 / 255.0, b: 221 / 255.0, a: 255 / 255.0)
    
    /// Powder blue color (red: 176, green: 224, blue: 230, alpha: 255)
    static let powderBlue = BLRgba128(r: 176 / 255.0, g: 224 / 255.0, b: 230 / 255.0, a: 255 / 255.0)
    
    /// Purple color (red: 128, green: 0, blue: 128, alpha: 255)
    static let purple = BLRgba128(r: 128 / 255.0, g: 0 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Red color (red: 255, green: 0, blue: 0, alpha: 255)
    static let red = BLRgba128(r: 255 / 255.0, g: 0 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Rosy brown color (red: 188, green: 143, blue: 143, alpha: 255)
    static let rosyBrown = BLRgba128(r: 188 / 255.0, g: 143 / 255.0, b: 143 / 255.0, a: 255 / 255.0)
    
    /// Royal blue color (red: 65, green: 105, blue: 225, alpha: 255)
    static let royalBlue = BLRgba128(r: 65 / 255.0, g: 105 / 255.0, b: 225 / 255.0, a: 255 / 255.0)
    
    /// Saddle brown color (red: 139, green: 69, blue: 19, alpha: 255)
    static let saddleBrown = BLRgba128(r: 139 / 255.0, g: 69 / 255.0, b: 19 / 255.0, a: 255 / 255.0)
    
    /// Salmon color (red: 250, green: 128, blue: 114, alpha: 255)
    static let salmon = BLRgba128(r: 250 / 255.0, g: 128 / 255.0, b: 114 / 255.0, a: 255 / 255.0)
    
    /// Sandy brown color (red: 244, green: 164, blue: 96, alpha: 255)
    static let sandyBrown = BLRgba128(r: 244 / 255.0, g: 164 / 255.0, b: 96 / 255.0, a: 255 / 255.0)
    
    /// Sea green color (red: 46, green: 139, blue: 87, alpha: 255)
    static let seaGreen = BLRgba128(r: 46 / 255.0, g: 139 / 255.0, b: 87 / 255.0, a: 255 / 255.0)
    
    /// Sea shell color (red: 255, green: 245, blue: 238, alpha: 255)
    static let seaShell = BLRgba128(r: 255 / 255.0, g: 245 / 255.0, b: 238 / 255.0, a: 255 / 255.0)
    
    /// Sienna color (red: 160, green: 82, blue: 45, alpha: 255)
    static let sienna = BLRgba128(r: 160 / 255.0, g: 82 / 255.0, b: 45 / 255.0, a: 255 / 255.0)
    
    /// Silver color (red: 192, green: 192, blue: 192, alpha: 255)
    static let silver = BLRgba128(r: 192 / 255.0, g: 192 / 255.0, b: 192 / 255.0, a: 255 / 255.0)
    
    /// Sky blue color (red: 135, green: 206, blue: 235, alpha: 255)
    static let skyBlue = BLRgba128(r: 135 / 255.0, g: 206 / 255.0, b: 235 / 255.0, a: 255 / 255.0)
    
    /// Slate blue color (red: 106, green: 90, blue: 205, alpha: 255)
    static let slateBlue = BLRgba128(r: 106 / 255.0, g: 90 / 255.0, b: 205 / 255.0, a: 255 / 255.0)
    
    /// Slate gray color (red: 112, green: 128, blue: 144, alpha: 255)
    static let slateGray = BLRgba128(r: 112 / 255.0, g: 128 / 255.0, b: 144 / 255.0, a: 255 / 255.0)
    
    /// Snow color (red: 255, green: 250, blue: 250, alpha: 255)
    static let snow = BLRgba128(r: 255 / 255.0, g: 250 / 255.0, b: 250 / 255.0, a: 255 / 255.0)
    
    /// Spring green color (red: 0, green: 255, blue: 127, alpha: 255)
    static let springGreen = BLRgba128(r: 0 / 255.0, g: 255 / 255.0, b: 127 / 255.0, a: 255 / 255.0)
    
    /// Steel blue color (red: 70, green: 130, blue: 180, alpha: 255)
    static let steelBlue = BLRgba128(r: 70 / 255.0, g: 130 / 255.0, b: 180 / 255.0, a: 255 / 255.0)
    
    /// Tan color (red: 210, green: 180, blue: 140, alpha: 255)
    static let tan = BLRgba128(r: 210 / 255.0, g: 180 / 255.0, b: 140 / 255.0, a: 255 / 255.0)
    
    /// Teal color (red: 0, green: 128, blue: 128, alpha: 255)
    static let teal = BLRgba128(r: 0 / 255.0, g: 128 / 255.0, b: 128 / 255.0, a: 255 / 255.0)
    
    /// Thistle color (red: 216, green: 191, blue: 216, alpha: 255)
    static let thistle = BLRgba128(r: 216 / 255.0, g: 191 / 255.0, b: 216 / 255.0, a: 255 / 255.0)
    
    /// Tomato color (red: 255, green: 99, blue: 71, alpha: 255)
    static let tomato = BLRgba128(r: 255 / 255.0, g: 99 / 255.0, b: 71 / 255.0, a: 255 / 255.0)
    
    /// Turquoise color (red: 64, green: 224, blue: 208, alpha: 255)
    static let turquoise = BLRgba128(r: 64 / 255.0, g: 224 / 255.0, b: 208 / 255.0, a: 255 / 255.0)
    
    /// Violet color (red: 238, green: 130, blue: 238, alpha: 255)
    static let violet = BLRgba128(r: 238 / 255.0, g: 130 / 255.0, b: 238 / 255.0, a: 255 / 255.0)
    
    /// Wheat color (red: 245, green: 222, blue: 179, alpha: 255)
    static let wheat = BLRgba128(r: 245 / 255.0, g: 222 / 255.0, b: 179 / 255.0, a: 255 / 255.0)
    
    /// White color (red: 255, green: 255, blue: 255, alpha: 255)
    static let white = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 255 / 255.0, a: 255 / 255.0)
    
    /// White smoke color (red: 245, green: 245, blue: 245, alpha: 255)
    static let whiteSmoke = BLRgba128(r: 245 / 255.0, g: 245 / 255.0, b: 245 / 255.0, a: 255 / 255.0)
    
    /// Yellow color (red: 255, green: 255, blue: 0, alpha: 255)
    static let yellow = BLRgba128(r: 255 / 255.0, g: 255 / 255.0, b: 0 / 255.0, a: 255 / 255.0)
    
    /// Yellow green color (red: 154, green: 205, blue: 50, alpha: 255)
    static let yellowGreen = BLRgba128(r: 154 / 255.0, g: 205 / 255.0, b: 50 / 255.0, a: 255 / 255.0)
}
