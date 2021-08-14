import blend2d

public extension BLRgba32 {
    /// Transparent black color (red: 0, green: 0, blue: 0, alpha: 0)
    static let transparentBlack = BLRgba32(r: 0, g: 0, b: 0, a: 0)
    
    /// Transparent white color (red: 255, green: 255, blue: 255, alpha: 0)
    static let transparentWhite = BLRgba32(r: 255, g: 255, b: 255, a: 0)
    
    /// Alice blue color (red: 240, green: 248, blue: 255, alpha: 255)
    static let aliceBlue = BLRgba32(r: 240, g: 248, b: 255, a: 255)
    
    /// Antique white color (red: 250, green: 235, blue: 215, alpha: 255)
    static let antiqueWhite = BLRgba32(r: 250, g: 235, b: 215, a: 255)
    
    /// Aqua color (red: 0, green: 255, blue: 255, alpha: 255)
    static let aqua = BLRgba32(r: 0, g: 255, b: 255, a: 255)
    
    /// Aquamarine color (red: 127, green: 255, blue: 212, alpha: 255)
    static let aquamarine = BLRgba32(r: 127, g: 255, b: 212, a: 255)
    
    /// Azure color (red: 240, green: 255, blue: 255, alpha: 255)
    static let azure = BLRgba32(r: 240, g: 255, b: 255, a: 255)
    
    /// Beige color (red: 245, green: 245, blue: 220, alpha: 255)
    static let beige = BLRgba32(r: 245, g: 245, b: 220, a: 255)
    
    /// Bisque color (red: 255, green: 228, blue: 196, alpha: 255)
    static let bisque = BLRgba32(r: 255, g: 228, b: 196, a: 255)
    
    /// Black color (red: 0, green: 0, blue: 0, alpha: 255)
    static let black = BLRgba32(r: 0, g: 0, b: 0, a: 255)
    
    /// Blanched almond color (red: 255, green: 235, blue: 205, alpha: 255)
    static let blanchedAlmond = BLRgba32(r: 255, g: 235, b: 205, a: 255)
    
    /// Blue color (red: 0, green: 0, blue: 255, alpha: 255)
    static let blue = BLRgba32(r: 0, g: 0, b: 255, a: 255)
    
    /// Blue violet color (red: 138, green: 43, blue: 226, alpha: 255)
    static let blueViolet = BLRgba32(r: 138, g: 43, b: 226, a: 255)
    
    /// Brown color (red: 165, green: 42, blue: 42, alpha: 255)
    static let brown = BLRgba32(r: 165, g: 42, b: 42, a: 255)
    
    /// Burly wood color (red: 222, green: 184, blue: 135, alpha: 255)
    static let burlyWood = BLRgba32(r: 222, g: 184, b: 135, a: 255)
    
    /// Cadet blue color (red: 95, green: 158, blue: 160, alpha: 255)
    static let cadetBlue = BLRgba32(r: 95, g: 158, b: 160, a: 255)
    
    /// Chartreuse color (red: 127, green: 255, blue: 0, alpha: 255)
    static let chartreuse = BLRgba32(r: 127, g: 255, b: 0, a: 255)
    
    /// Chocolate color (red: 210, green: 105, blue: 30, alpha: 255)
    static let chocolate = BLRgba32(r: 210, g: 105, b: 30, a: 255)
    
    /// Coral color (red: 255, green: 127, blue: 80, alpha: 255)
    static let coral = BLRgba32(r: 255, g: 127, b: 80, a: 255)
    
    /// Cornflower blue color (red: 100, green: 149, blue: 237, alpha: 255)
    static let cornflowerBlue = BLRgba32(r: 100, g: 149, b: 237, a: 255)
    
    /// Cornsilk color (red: 255, green: 248, blue: 220, alpha: 255)
    static let cornsilk = BLRgba32(r: 255, g: 248, b: 220, a: 255)
    
    /// Crimson color (red: 220, green: 20, blue: 60, alpha: 255)
    static let crimson = BLRgba32(r: 220, g: 20, b: 60, a: 255)
    
    /// Cyan color (red: 0, green: 255, blue: 255, alpha: 255)
    static let cyan = BLRgba32(r: 0, g: 255, b: 255, a: 255)
    
    /// Dark blue color (red: 0, green: 0, blue: 139, alpha: 255)
    static let darkBlue = BLRgba32(r: 0, g: 0, b: 139, a: 255)
    
    /// Dark cyan color (red: 0, green: 139, blue: 139, alpha: 255)
    static let darkCyan = BLRgba32(r: 0, g: 139, b: 139, a: 255)
    
    /// Dark goldenrod color (red: 184, green: 134, blue: 11, alpha: 255)
    static let darkGoldenrod = BLRgba32(r: 184, g: 134, b: 11, a: 255)
    
    /// Dark gray color (red: 169, green: 169, blue: 169, alpha: 255)
    static let darkGray = BLRgba32(r: 169, g: 169, b: 169, a: 255)
    
    /// Dark green color (red: 0, green: 100, blue: 0, alpha: 255)
    static let darkGreen = BLRgba32(r: 0, g: 100, b: 0, a: 255)
    
    /// Dark khaki color (red: 189, green: 183, blue: 107, alpha: 255)
    static let darkKhaki = BLRgba32(r: 189, g: 183, b: 107, a: 255)
    
    /// Dark magenta color (red: 139, green: 0, blue: 139, alpha: 255)
    static let darkMagenta = BLRgba32(r: 139, g: 0, b: 139, a: 255)
    
    /// Dark olive green color (red: 85, green: 107, blue: 47, alpha: 255)
    static let darkOliveGreen = BLRgba32(r: 85, g: 107, b: 47, a: 255)
    
    /// Dark orange color (red: 255, green: 140, blue: 0, alpha: 255)
    static let darkOrange = BLRgba32(r: 255, g: 140, b: 0, a: 255)
    
    /// Dark orchid color (red: 153, green: 50, blue: 204, alpha: 255)
    static let darkOrchid = BLRgba32(r: 153, g: 50, b: 204, a: 255)
    
    /// Dark red color (red: 139, green: 0, blue: 0, alpha: 255)
    static let darkRed = BLRgba32(r: 139, g: 0, b: 0, a: 255)
    
    /// Dark salmon color (red: 233, green: 150, blue: 122, alpha: 255)
    static let darkSalmon = BLRgba32(r: 233, g: 150, b: 122, a: 255)
    
    /// Dark sea green color (red: 143, green: 188, blue: 139, alpha: 255)
    static let darkSeaGreen = BLRgba32(r: 143, g: 188, b: 139, a: 255)
    
    /// Dark slate blue color (red: 72, green: 61, blue: 139, alpha: 255)
    static let darkSlateBlue = BLRgba32(r: 72, g: 61, b: 139, a: 255)
    
    /// Dark slate gray color (red: 47, green: 79, blue: 79, alpha: 255)
    static let darkSlateGray = BLRgba32(r: 47, g: 79, b: 79, a: 255)
    
    /// Dark turquoise color (red: 0, green: 206, blue: 209, alpha: 255)
    static let darkTurquoise = BLRgba32(r: 0, g: 206, b: 209, a: 255)
    
    /// Dark violet color (red: 148, green: 0, blue: 211, alpha: 255)
    static let darkViolet = BLRgba32(r: 148, g: 0, b: 211, a: 255)
    
    /// Deep pink color (red: 255, green: 20, blue: 147, alpha: 255)
    static let deepPink = BLRgba32(r: 255, g: 20, b: 147, a: 255)
    
    /// Deep sky blue color (red: 0, green: 191, blue: 255, alpha: 255)
    static let deepSkyBlue = BLRgba32(r: 0, g: 191, b: 255, a: 255)
    
    /// Dim gray color (red: 105, green: 105, blue: 105, alpha: 255)
    static let dimGray = BLRgba32(r: 105, g: 105, b: 105, a: 255)
    
    /// Dodger blue color (red: 30, green: 144, blue: 255, alpha: 255)
    static let dodgerBlue = BLRgba32(r: 30, g: 144, b: 255, a: 255)
    
    /// Firebrick color (red: 178, green: 34, blue: 34, alpha: 255)
    static let firebrick = BLRgba32(r: 178, g: 34, b: 34, a: 255)
    
    /// Floral white color (red: 255, green: 250, blue: 240, alpha: 255)
    static let floralWhite = BLRgba32(r: 255, g: 250, b: 240, a: 255)
    
    /// Forest green color (red: 34, green: 139, blue: 34, alpha: 255)
    static let forestGreen = BLRgba32(r: 34, g: 139, b: 34, a: 255)
    
    /// Fuchsia color (red: 255, green: 0, blue: 255, alpha: 255)
    static let fuchsia = BLRgba32(r: 255, g: 0, b: 255, a: 255)
    
    /// Gainsboro color (red: 220, green: 220, blue: 220, alpha: 255)
    static let gainsboro = BLRgba32(r: 220, g: 220, b: 220, a: 255)
    
    /// Ghost white color (red: 248, green: 248, blue: 255, alpha: 255)
    static let ghostWhite = BLRgba32(r: 248, g: 248, b: 255, a: 255)
    
    /// Gold color (red: 255, green: 215, blue: 0, alpha: 255)
    static let gold = BLRgba32(r: 255, g: 215, b: 0, a: 255)
    
    /// Goldenrod color (red: 218, green: 165, blue: 32, alpha: 255)
    static let goldenrod = BLRgba32(r: 218, g: 165, b: 32, a: 255)
    
    /// Gray color (red: 128, green: 128, blue: 128, alpha: 255)
    static let gray = BLRgba32(r: 128, g: 128, b: 128, a: 255)
    
    /// Green color (red: 0, green: 128, blue: 0, alpha: 255)
    static let green = BLRgba32(r: 0, g: 128, b: 0, a: 255)
    
    /// Green yellow color (red: 173, green: 255, blue: 47, alpha: 255)
    static let greenYellow = BLRgba32(r: 173, g: 255, b: 47, a: 255)
    
    /// Honeydew color (red: 240, green: 255, blue: 240, alpha: 255)
    static let honeydew = BLRgba32(r: 240, g: 255, b: 240, a: 255)
    
    /// Hot pink color (red: 255, green: 105, blue: 180, alpha: 255)
    static let hotPink = BLRgba32(r: 255, g: 105, b: 180, a: 255)
    
    /// Indian red color (red: 205, green: 92, blue: 92, alpha: 255)
    static let indianRed = BLRgba32(r: 205, g: 92, b: 92, a: 255)
    
    /// Indigo color (red: 75, green: 0, blue: 130, alpha: 255)
    static let indigo = BLRgba32(r: 75, g: 0, b: 130, a: 255)
    
    /// Ivory color (red: 255, green: 255, blue: 240, alpha: 255)
    static let ivory = BLRgba32(r: 255, g: 255, b: 240, a: 255)
    
    /// Khaki color (red: 240, green: 230, blue: 140, alpha: 255)
    static let khaki = BLRgba32(r: 240, g: 230, b: 140, a: 255)
    
    /// Lavender color (red: 230, green: 230, blue: 250, alpha: 255)
    static let lavender = BLRgba32(r: 230, g: 230, b: 250, a: 255)
    
    /// Lavender blush color (red: 255, green: 240, blue: 245, alpha: 255)
    static let lavenderBlush = BLRgba32(r: 255, g: 240, b: 245, a: 255)
    
    /// Lawn green color (red: 124, green: 252, blue: 0, alpha: 255)
    static let lawnGreen = BLRgba32(r: 124, g: 252, b: 0, a: 255)
    
    /// Lemon chiffon color (red: 255, green: 250, blue: 205, alpha: 255)
    static let lemonChiffon = BLRgba32(r: 255, g: 250, b: 205, a: 255)
    
    /// Light blue color (red: 173, green: 216, blue: 230, alpha: 255)
    static let lightBlue = BLRgba32(r: 173, g: 216, b: 230, a: 255)
    
    /// Light coral color (red: 240, green: 128, blue: 128, alpha: 255)
    static let lightCoral = BLRgba32(r: 240, g: 128, b: 128, a: 255)
    
    /// Light cyan color (red: 224, green: 255, blue: 255, alpha: 255)
    static let lightCyan = BLRgba32(r: 224, g: 255, b: 255, a: 255)
    
    /// Light goldenrod yellow color (red: 250, green: 250, blue: 210, alpha: 255)
    static let lightGoldenrodYellow = BLRgba32(r: 250, g: 250, b: 210, a: 255)
    
    /// Light green color (red: 144, green: 238, blue: 144, alpha: 255)
    static let lightGreen = BLRgba32(r: 144, g: 238, b: 144, a: 255)
    
    /// Light gray color (red: 211, green: 211, blue: 211, alpha: 255)
    static let lightGray = BLRgba32(r: 211, g: 211, b: 211, a: 255)
    
    /// Light pink color (red: 255, green: 182, blue: 193, alpha: 255)
    static let lightPink = BLRgba32(r: 255, g: 182, b: 193, a: 255)
    
    /// Light salmon color (red: 255, green: 160, blue: 122, alpha: 255)
    static let lightSalmon = BLRgba32(r: 255, g: 160, b: 122, a: 255)
    
    /// Light sea green color (red: 32, green: 178, blue: 170, alpha: 255)
    static let lightSeaGreen = BLRgba32(r: 32, g: 178, b: 170, a: 255)
    
    /// Light sky blue color (red: 135, green: 206, blue: 250, alpha: 255)
    static let lightSkyBlue = BLRgba32(r: 135, g: 206, b: 250, a: 255)
    
    /// Light slate gray color (red: 119, green: 136, blue: 153, alpha: 255)
    static let lightSlateGray = BLRgba32(r: 119, g: 136, b: 153, a: 255)
    
    /// Light steel blue color (red: 176, green: 196, blue: 222, alpha: 255)
    static let lightSteelBlue = BLRgba32(r: 176, g: 196, b: 222, a: 255)
    
    /// Light yellow color (red: 255, green: 255, blue: 224, alpha: 255)
    static let lightYellow = BLRgba32(r: 255, g: 255, b: 224, a: 255)
    
    /// Lime color (red: 0, green: 255, blue: 0, alpha: 255)
    static let lime = BLRgba32(r: 0, g: 255, b: 0, a: 255)
    
    /// Lime green color (red: 50, green: 205, blue: 50, alpha: 255)
    static let limeGreen = BLRgba32(r: 50, g: 205, b: 50, a: 255)
    
    /// Linen color (red: 250, green: 240, blue: 230, alpha: 255)
    static let linen = BLRgba32(r: 250, g: 240, b: 230, a: 255)
    
    /// Magenta color (red: 255, green: 0, blue: 255, alpha: 255)
    static let magenta = BLRgba32(r: 255, g: 0, b: 255, a: 255)
    
    /// Maroon color (red: 128, green: 0, blue: 0, alpha: 255)
    static let maroon = BLRgba32(r: 128, g: 0, b: 0, a: 255)
    
    /// Medium aquamarine color (red: 102, green: 205, blue: 170, alpha: 255)
    static let mediumAquamarine = BLRgba32(r: 102, g: 205, b: 170, a: 255)
    
    /// Medium blue color (red: 0, green: 0, blue: 205, alpha: 255)
    static let mediumBlue = BLRgba32(r: 0, g: 0, b: 205, a: 255)
    
    /// Medium orchid color (red: 186, green: 85, blue: 211, alpha: 255)
    static let mediumOrchid = BLRgba32(r: 186, g: 85, b: 211, a: 255)
    
    /// Medium purple color (red: 147, green: 112, blue: 219, alpha: 255)
    static let mediumPurple = BLRgba32(r: 147, g: 112, b: 219, a: 255)
    
    /// Medium sea green color (red: 60, green: 179, blue: 113, alpha: 255)
    static let mediumSeaGreen = BLRgba32(r: 60, g: 179, b: 113, a: 255)
    
    /// Medium slate blue color (red: 123, green: 104, blue: 238, alpha: 255)
    static let mediumSlateBlue = BLRgba32(r: 123, g: 104, b: 238, a: 255)
    
    /// Medium spring green color (red: 0, green: 250, blue: 154, alpha: 255)
    static let mediumSpringGreen = BLRgba32(r: 0, g: 250, b: 154, a: 255)
    
    /// Medium turquoise color (red: 72, green: 209, blue: 204, alpha: 255)
    static let mediumTurquoise = BLRgba32(r: 72, g: 209, b: 204, a: 255)
    
    /// Medium violet red color (red: 199, green: 21, blue: 133, alpha: 255)
    static let mediumVioletRed = BLRgba32(r: 199, g: 21, b: 133, a: 255)
    
    /// Midnight blue color (red: 25, green: 25, blue: 112, alpha: 255)
    static let midnightBlue = BLRgba32(r: 25, g: 25, b: 112, a: 255)
    
    /// Mint cream color (red: 245, green: 255, blue: 250, alpha: 255)
    static let mintCream = BLRgba32(r: 245, g: 255, b: 250, a: 255)
    
    /// Misty rose color (red: 255, green: 228, blue: 225, alpha: 255)
    static let mistyRose = BLRgba32(r: 255, g: 228, b: 225, a: 255)
    
    /// Moccasin color (red: 255, green: 228, blue: 181, alpha: 255)
    static let moccasin = BLRgba32(r: 255, g: 228, b: 181, a: 255)
    
    /// Navajo white color (red: 255, green: 222, blue: 173, alpha: 255)
    static let navajoWhite = BLRgba32(r: 255, g: 222, b: 173, a: 255)
    
    /// Navy color (red: 0, green: 0, blue: 128, alpha: 255)
    static let navy = BLRgba32(r: 0, g: 0, b: 128, a: 255)
    
    /// Old lace color (red: 253, green: 245, blue: 230, alpha: 255)
    static let oldLace = BLRgba32(r: 253, g: 245, b: 230, a: 255)
    
    /// Olive color (red: 128, green: 128, blue: 0, alpha: 255)
    static let olive = BLRgba32(r: 128, g: 128, b: 0, a: 255)
    
    /// Olive drab color (red: 107, green: 142, blue: 35, alpha: 255)
    static let oliveDrab = BLRgba32(r: 107, g: 142, b: 35, a: 255)
    
    /// Orange color (red: 255, green: 165, blue: 0, alpha: 255)
    static let orange = BLRgba32(r: 255, g: 165, b: 0, a: 255)
    
    /// Orange red color (red: 255, green: 69, blue: 0, alpha: 255)
    static let orangeRed = BLRgba32(r: 255, g: 69, b: 0, a: 255)
    
    /// Orchid color (red: 218, green: 112, blue: 214, alpha: 255)
    static let orchid = BLRgba32(r: 218, g: 112, b: 214, a: 255)
    
    /// Pale goldenrod color (red: 238, green: 232, blue: 170, alpha: 255)
    static let paleGoldenrod = BLRgba32(r: 238, g: 232, b: 170, a: 255)
    
    /// Pale green color (red: 152, green: 251, blue: 152, alpha: 255)
    static let paleGreen = BLRgba32(r: 152, g: 251, b: 152, a: 255)
    
    /// Pale turquoise color (red: 175, green: 238, blue: 238, alpha: 255)
    static let paleTurquoise = BLRgba32(r: 175, g: 238, b: 238, a: 255)
    
    /// Pale violet red color (red: 219, green: 112, blue: 147, alpha: 255)
    static let paleVioletRed = BLRgba32(r: 219, g: 112, b: 147, a: 255)
    
    /// Papaya whip color (red: 255, green: 239, blue: 213, alpha: 255)
    static let papayaWhip = BLRgba32(r: 255, g: 239, b: 213, a: 255)
    
    /// Peach puff color (red: 255, green: 218, blue: 185, alpha: 255)
    static let peachPuff = BLRgba32(r: 255, g: 218, b: 185, a: 255)
    
    /// Peru color (red: 205, green: 133, blue: 63, alpha: 255)
    static let peru = BLRgba32(r: 205, g: 133, b: 63, a: 255)
    
    /// Pink color (red: 255, green: 192, blue: 203, alpha: 255)
    static let pink = BLRgba32(r: 255, g: 192, b: 203, a: 255)
    
    /// Plum color (red: 221, green: 160, blue: 221, alpha: 255)
    static let plum = BLRgba32(r: 221, g: 160, b: 221, a: 255)
    
    /// Powder blue color (red: 176, green: 224, blue: 230, alpha: 255)
    static let powderBlue = BLRgba32(r: 176, g: 224, b: 230, a: 255)
    
    /// Purple color (red: 128, green: 0, blue: 128, alpha: 255)
    static let purple = BLRgba32(r: 128, g: 0, b: 128, a: 255)
    
    /// Red color (red: 255, green: 0, blue: 0, alpha: 255)
    static let red = BLRgba32(r: 255, g: 0, b: 0, a: 255)
    
    /// Rosy brown color (red: 188, green: 143, blue: 143, alpha: 255)
    static let rosyBrown = BLRgba32(r: 188, g: 143, b: 143, a: 255)
    
    /// Royal blue color (red: 65, green: 105, blue: 225, alpha: 255)
    static let royalBlue = BLRgba32(r: 65, g: 105, b: 225, a: 255)
    
    /// Saddle brown color (red: 139, green: 69, blue: 19, alpha: 255)
    static let saddleBrown = BLRgba32(r: 139, g: 69, b: 19, a: 255)
    
    /// Salmon color (red: 250, green: 128, blue: 114, alpha: 255)
    static let salmon = BLRgba32(r: 250, g: 128, b: 114, a: 255)
    
    /// Sandy brown color (red: 244, green: 164, blue: 96, alpha: 255)
    static let sandyBrown = BLRgba32(r: 244, g: 164, b: 96, a: 255)
    
    /// Sea green color (red: 46, green: 139, blue: 87, alpha: 255)
    static let seaGreen = BLRgba32(r: 46, g: 139, b: 87, a: 255)
    
    /// Sea shell color (red: 255, green: 245, blue: 238, alpha: 255)
    static let seaShell = BLRgba32(r: 255, g: 245, b: 238, a: 255)
    
    /// Sienna color (red: 160, green: 82, blue: 45, alpha: 255)
    static let sienna = BLRgba32(r: 160, g: 82, b: 45, a: 255)
    
    /// Silver color (red: 192, green: 192, blue: 192, alpha: 255)
    static let silver = BLRgba32(r: 192, g: 192, b: 192, a: 255)
    
    /// Sky blue color (red: 135, green: 206, blue: 235, alpha: 255)
    static let skyBlue = BLRgba32(r: 135, g: 206, b: 235, a: 255)
    
    /// Slate blue color (red: 106, green: 90, blue: 205, alpha: 255)
    static let slateBlue = BLRgba32(r: 106, g: 90, b: 205, a: 255)
    
    /// Slate gray color (red: 112, green: 128, blue: 144, alpha: 255)
    static let slateGray = BLRgba32(r: 112, g: 128, b: 144, a: 255)
    
    /// Snow color (red: 255, green: 250, blue: 250, alpha: 255)
    static let snow = BLRgba32(r: 255, g: 250, b: 250, a: 255)
    
    /// Spring green color (red: 0, green: 255, blue: 127, alpha: 255)
    static let springGreen = BLRgba32(r: 0, g: 255, b: 127, a: 255)
    
    /// Steel blue color (red: 70, green: 130, blue: 180, alpha: 255)
    static let steelBlue = BLRgba32(r: 70, g: 130, b: 180, a: 255)
    
    /// Tan color (red: 210, green: 180, blue: 140, alpha: 255)
    static let tan = BLRgba32(r: 210, g: 180, b: 140, a: 255)
    
    /// Teal color (red: 0, green: 128, blue: 128, alpha: 255)
    static let teal = BLRgba32(r: 0, g: 128, b: 128, a: 255)
    
    /// Thistle color (red: 216, green: 191, blue: 216, alpha: 255)
    static let thistle = BLRgba32(r: 216, g: 191, b: 216, a: 255)
    
    /// Tomato color (red: 255, green: 99, blue: 71, alpha: 255)
    static let tomato = BLRgba32(r: 255, g: 99, b: 71, a: 255)
    
    /// Turquoise color (red: 64, green: 224, blue: 208, alpha: 255)
    static let turquoise = BLRgba32(r: 64, g: 224, b: 208, a: 255)
    
    /// Violet color (red: 238, green: 130, blue: 238, alpha: 255)
    static let violet = BLRgba32(r: 238, g: 130, b: 238, a: 255)
    
    /// Wheat color (red: 245, green: 222, blue: 179, alpha: 255)
    static let wheat = BLRgba32(r: 245, g: 222, b: 179, a: 255)
    
    /// White color (red: 255, green: 255, blue: 255, alpha: 255)
    static let white = BLRgba32(r: 255, g: 255, b: 255, a: 255)
    
    /// White smoke color (red: 245, green: 245, blue: 245, alpha: 255)
    static let whiteSmoke = BLRgba32(r: 245, g: 245, b: 245, a: 255)
    
    /// Yellow color (red: 255, green: 255, blue: 0, alpha: 255)
    static let yellow = BLRgba32(r: 255, g: 255, b: 0, a: 255)
    
    /// Yellow green color (red: 154, green: 205, blue: 50, alpha: 255)
    static let yellowGreen = BLRgba32(r: 154, g: 205, b: 50, a: 255)
}
