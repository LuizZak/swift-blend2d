import blend2d

public extension BLRgba64 {
    /// Transparent black color (red: 0, green: 0, blue: 0, alpha: 0)
    static let transparentBlack = BLRgba64(r: 0, g: 0, b: 0, a: 0)
    
    /// Transparent white color (red: 65535, green: 65535, blue: 65535, alpha: 0)
    static let transparentWhite = BLRgba64(r: 65535, g: 65535, b: 65535, a: 0)
    
    /// Alice blue color (red: 61680, green: 63736, blue: 65535, alpha: 65535)
    static let aliceBlue = BLRgba64(r: 61680, g: 63736, b: 65535, a: 65535)
    
    /// Antique white color (red: 64250, green: 60395, blue: 55255, alpha: 65535)
    static let antiqueWhite = BLRgba64(r: 64250, g: 60395, b: 55255, a: 65535)
    
    /// Aqua color (red: 0, green: 65535, blue: 65535, alpha: 65535)
    static let aqua = BLRgba64(r: 0, g: 65535, b: 65535, a: 65535)
    
    /// Aquamarine color (red: 32639, green: 65535, blue: 54484, alpha: 65535)
    static let aquamarine = BLRgba64(r: 32639, g: 65535, b: 54484, a: 65535)
    
    /// Azure color (red: 61680, green: 65535, blue: 65535, alpha: 65535)
    static let azure = BLRgba64(r: 61680, g: 65535, b: 65535, a: 65535)
    
    /// Beige color (red: 62965, green: 62965, blue: 56540, alpha: 65535)
    static let beige = BLRgba64(r: 62965, g: 62965, b: 56540, a: 65535)
    
    /// Bisque color (red: 65535, green: 58596, blue: 50372, alpha: 65535)
    static let bisque = BLRgba64(r: 65535, g: 58596, b: 50372, a: 65535)
    
    /// Black color (red: 0, green: 0, blue: 0, alpha: 65535)
    static let black = BLRgba64(r: 0, g: 0, b: 0, a: 65535)
    
    /// Blanched almond color (red: 65535, green: 60395, blue: 52685, alpha: 65535)
    static let blanchedAlmond = BLRgba64(r: 65535, g: 60395, b: 52685, a: 65535)
    
    /// Blue color (red: 0, green: 0, blue: 65535, alpha: 65535)
    static let blue = BLRgba64(r: 0, g: 0, b: 65535, a: 65535)
    
    /// Blue violet color (red: 35466, green: 11051, blue: 58082, alpha: 65535)
    static let blueViolet = BLRgba64(r: 35466, g: 11051, b: 58082, a: 65535)
    
    /// Brown color (red: 42405, green: 10794, blue: 10794, alpha: 65535)
    static let brown = BLRgba64(r: 42405, g: 10794, b: 10794, a: 65535)
    
    /// Burly wood color (red: 57054, green: 47288, blue: 34695, alpha: 65535)
    static let burlyWood = BLRgba64(r: 57054, g: 47288, b: 34695, a: 65535)
    
    /// Cadet blue color (red: 24415, green: 40606, blue: 41120, alpha: 65535)
    static let cadetBlue = BLRgba64(r: 24415, g: 40606, b: 41120, a: 65535)
    
    /// Chartreuse color (red: 32639, green: 65535, blue: 0, alpha: 65535)
    static let chartreuse = BLRgba64(r: 32639, g: 65535, b: 0, a: 65535)
    
    /// Chocolate color (red: 53970, green: 26985, blue: 7710, alpha: 65535)
    static let chocolate = BLRgba64(r: 53970, g: 26985, b: 7710, a: 65535)
    
    /// Coral color (red: 65535, green: 32639, blue: 20560, alpha: 65535)
    static let coral = BLRgba64(r: 65535, g: 32639, b: 20560, a: 65535)
    
    /// Cornflower blue color (red: 25700, green: 38293, blue: 60909, alpha: 65535)
    static let cornflowerBlue = BLRgba64(r: 25700, g: 38293, b: 60909, a: 65535)
    
    /// Cornsilk color (red: 65535, green: 63736, blue: 56540, alpha: 65535)
    static let cornsilk = BLRgba64(r: 65535, g: 63736, b: 56540, a: 65535)
    
    /// Crimson color (red: 56540, green: 5140, blue: 15420, alpha: 65535)
    static let crimson = BLRgba64(r: 56540, g: 5140, b: 15420, a: 65535)
    
    /// Cyan color (red: 0, green: 65535, blue: 65535, alpha: 65535)
    static let cyan = BLRgba64(r: 0, g: 65535, b: 65535, a: 65535)
    
    /// Dark blue color (red: 0, green: 0, blue: 35723, alpha: 65535)
    static let darkBlue = BLRgba64(r: 0, g: 0, b: 35723, a: 65535)
    
    /// Dark cyan color (red: 0, green: 35723, blue: 35723, alpha: 65535)
    static let darkCyan = BLRgba64(r: 0, g: 35723, b: 35723, a: 65535)
    
    /// Dark goldenrod color (red: 47288, green: 34438, blue: 2827, alpha: 65535)
    static let darkGoldenrod = BLRgba64(r: 47288, g: 34438, b: 2827, a: 65535)
    
    /// Dark gray color (red: 43433, green: 43433, blue: 43433, alpha: 65535)
    static let darkGray = BLRgba64(r: 43433, g: 43433, b: 43433, a: 65535)
    
    /// Dark green color (red: 0, green: 25700, blue: 0, alpha: 65535)
    static let darkGreen = BLRgba64(r: 0, g: 25700, b: 0, a: 65535)
    
    /// Dark khaki color (red: 48573, green: 47031, blue: 27499, alpha: 65535)
    static let darkKhaki = BLRgba64(r: 48573, g: 47031, b: 27499, a: 65535)
    
    /// Dark magenta color (red: 35723, green: 0, blue: 35723, alpha: 65535)
    static let darkMagenta = BLRgba64(r: 35723, g: 0, b: 35723, a: 65535)
    
    /// Dark olive green color (red: 21845, green: 27499, blue: 12079, alpha: 65535)
    static let darkOliveGreen = BLRgba64(r: 21845, g: 27499, b: 12079, a: 65535)
    
    /// Dark orange color (red: 65535, green: 35980, blue: 0, alpha: 65535)
    static let darkOrange = BLRgba64(r: 65535, g: 35980, b: 0, a: 65535)
    
    /// Dark orchid color (red: 39321, green: 12850, blue: 52428, alpha: 65535)
    static let darkOrchid = BLRgba64(r: 39321, g: 12850, b: 52428, a: 65535)
    
    /// Dark red color (red: 35723, green: 0, blue: 0, alpha: 65535)
    static let darkRed = BLRgba64(r: 35723, g: 0, b: 0, a: 65535)
    
    /// Dark salmon color (red: 59881, green: 38550, blue: 31354, alpha: 65535)
    static let darkSalmon = BLRgba64(r: 59881, g: 38550, b: 31354, a: 65535)
    
    /// Dark sea green color (red: 36751, green: 48316, blue: 35723, alpha: 65535)
    static let darkSeaGreen = BLRgba64(r: 36751, g: 48316, b: 35723, a: 65535)
    
    /// Dark slate blue color (red: 18504, green: 15677, blue: 35723, alpha: 65535)
    static let darkSlateBlue = BLRgba64(r: 18504, g: 15677, b: 35723, a: 65535)
    
    /// Dark slate gray color (red: 12079, green: 20303, blue: 20303, alpha: 65535)
    static let darkSlateGray = BLRgba64(r: 12079, g: 20303, b: 20303, a: 65535)
    
    /// Dark turquoise color (red: 0, green: 52942, blue: 53713, alpha: 65535)
    static let darkTurquoise = BLRgba64(r: 0, g: 52942, b: 53713, a: 65535)
    
    /// Dark violet color (red: 38036, green: 0, blue: 54227, alpha: 65535)
    static let darkViolet = BLRgba64(r: 38036, g: 0, b: 54227, a: 65535)
    
    /// Deep pink color (red: 65535, green: 5140, blue: 37779, alpha: 65535)
    static let deepPink = BLRgba64(r: 65535, g: 5140, b: 37779, a: 65535)
    
    /// Deep sky blue color (red: 0, green: 49087, blue: 65535, alpha: 65535)
    static let deepSkyBlue = BLRgba64(r: 0, g: 49087, b: 65535, a: 65535)
    
    /// Dim gray color (red: 26985, green: 26985, blue: 26985, alpha: 65535)
    static let dimGray = BLRgba64(r: 26985, g: 26985, b: 26985, a: 65535)
    
    /// Dodger blue color (red: 7710, green: 37008, blue: 65535, alpha: 65535)
    static let dodgerBlue = BLRgba64(r: 7710, g: 37008, b: 65535, a: 65535)
    
    /// Firebrick color (red: 45746, green: 8738, blue: 8738, alpha: 65535)
    static let firebrick = BLRgba64(r: 45746, g: 8738, b: 8738, a: 65535)
    
    /// Floral white color (red: 65535, green: 64250, blue: 61680, alpha: 65535)
    static let floralWhite = BLRgba64(r: 65535, g: 64250, b: 61680, a: 65535)
    
    /// Forest green color (red: 8738, green: 35723, blue: 8738, alpha: 65535)
    static let forestGreen = BLRgba64(r: 8738, g: 35723, b: 8738, a: 65535)
    
    /// Fuchsia color (red: 65535, green: 0, blue: 65535, alpha: 65535)
    static let fuchsia = BLRgba64(r: 65535, g: 0, b: 65535, a: 65535)
    
    /// Gainsboro color (red: 56540, green: 56540, blue: 56540, alpha: 65535)
    static let gainsboro = BLRgba64(r: 56540, g: 56540, b: 56540, a: 65535)
    
    /// Ghost white color (red: 63736, green: 63736, blue: 65535, alpha: 65535)
    static let ghostWhite = BLRgba64(r: 63736, g: 63736, b: 65535, a: 65535)
    
    /// Gold color (red: 65535, green: 55255, blue: 0, alpha: 65535)
    static let gold = BLRgba64(r: 65535, g: 55255, b: 0, a: 65535)
    
    /// Goldenrod color (red: 56026, green: 42405, blue: 8224, alpha: 65535)
    static let goldenrod = BLRgba64(r: 56026, g: 42405, b: 8224, a: 65535)
    
    /// Gray color (red: 32896, green: 32896, blue: 32896, alpha: 65535)
    static let gray = BLRgba64(r: 32896, g: 32896, b: 32896, a: 65535)
    
    /// Green color (red: 0, green: 32896, blue: 0, alpha: 65535)
    static let green = BLRgba64(r: 0, g: 32896, b: 0, a: 65535)
    
    /// Green yellow color (red: 44461, green: 65535, blue: 12079, alpha: 65535)
    static let greenYellow = BLRgba64(r: 44461, g: 65535, b: 12079, a: 65535)
    
    /// Honeydew color (red: 61680, green: 65535, blue: 61680, alpha: 65535)
    static let honeydew = BLRgba64(r: 61680, g: 65535, b: 61680, a: 65535)
    
    /// Hot pink color (red: 65535, green: 26985, blue: 46260, alpha: 65535)
    static let hotPink = BLRgba64(r: 65535, g: 26985, b: 46260, a: 65535)
    
    /// Indian red color (red: 52685, green: 23644, blue: 23644, alpha: 65535)
    static let indianRed = BLRgba64(r: 52685, g: 23644, b: 23644, a: 65535)
    
    /// Indigo color (red: 19275, green: 0, blue: 33410, alpha: 65535)
    static let indigo = BLRgba64(r: 19275, g: 0, b: 33410, a: 65535)
    
    /// Ivory color (red: 65535, green: 65535, blue: 61680, alpha: 65535)
    static let ivory = BLRgba64(r: 65535, g: 65535, b: 61680, a: 65535)
    
    /// Khaki color (red: 61680, green: 59110, blue: 35980, alpha: 65535)
    static let khaki = BLRgba64(r: 61680, g: 59110, b: 35980, a: 65535)
    
    /// Lavender color (red: 59110, green: 59110, blue: 64250, alpha: 65535)
    static let lavender = BLRgba64(r: 59110, g: 59110, b: 64250, a: 65535)
    
    /// Lavender blush color (red: 65535, green: 61680, blue: 62965, alpha: 65535)
    static let lavenderBlush = BLRgba64(r: 65535, g: 61680, b: 62965, a: 65535)
    
    /// Lawn green color (red: 31868, green: 64764, blue: 0, alpha: 65535)
    static let lawnGreen = BLRgba64(r: 31868, g: 64764, b: 0, a: 65535)
    
    /// Lemon chiffon color (red: 65535, green: 64250, blue: 52685, alpha: 65535)
    static let lemonChiffon = BLRgba64(r: 65535, g: 64250, b: 52685, a: 65535)
    
    /// Light blue color (red: 44461, green: 55512, blue: 59110, alpha: 65535)
    static let lightBlue = BLRgba64(r: 44461, g: 55512, b: 59110, a: 65535)
    
    /// Light coral color (red: 61680, green: 32896, blue: 32896, alpha: 65535)
    static let lightCoral = BLRgba64(r: 61680, g: 32896, b: 32896, a: 65535)
    
    /// Light cyan color (red: 57568, green: 65535, blue: 65535, alpha: 65535)
    static let lightCyan = BLRgba64(r: 57568, g: 65535, b: 65535, a: 65535)
    
    /// Light goldenrod yellow color (red: 64250, green: 64250, blue: 53970, alpha: 65535)
    static let lightGoldenrodYellow = BLRgba64(r: 64250, g: 64250, b: 53970, a: 65535)
    
    /// Light green color (red: 37008, green: 61166, blue: 37008, alpha: 65535)
    static let lightGreen = BLRgba64(r: 37008, g: 61166, b: 37008, a: 65535)
    
    /// Light gray color (red: 54227, green: 54227, blue: 54227, alpha: 65535)
    static let lightGray = BLRgba64(r: 54227, g: 54227, b: 54227, a: 65535)
    
    /// Light pink color (red: 65535, green: 46774, blue: 49601, alpha: 65535)
    static let lightPink = BLRgba64(r: 65535, g: 46774, b: 49601, a: 65535)
    
    /// Light salmon color (red: 65535, green: 41120, blue: 31354, alpha: 65535)
    static let lightSalmon = BLRgba64(r: 65535, g: 41120, b: 31354, a: 65535)
    
    /// Light sea green color (red: 8224, green: 45746, blue: 43690, alpha: 65535)
    static let lightSeaGreen = BLRgba64(r: 8224, g: 45746, b: 43690, a: 65535)
    
    /// Light sky blue color (red: 34695, green: 52942, blue: 64250, alpha: 65535)
    static let lightSkyBlue = BLRgba64(r: 34695, g: 52942, b: 64250, a: 65535)
    
    /// Light slate gray color (red: 30583, green: 34952, blue: 39321, alpha: 65535)
    static let lightSlateGray = BLRgba64(r: 30583, g: 34952, b: 39321, a: 65535)
    
    /// Light steel blue color (red: 45232, green: 50372, blue: 57054, alpha: 65535)
    static let lightSteelBlue = BLRgba64(r: 45232, g: 50372, b: 57054, a: 65535)
    
    /// Light yellow color (red: 65535, green: 65535, blue: 57568, alpha: 65535)
    static let lightYellow = BLRgba64(r: 65535, g: 65535, b: 57568, a: 65535)
    
    /// Lime color (red: 0, green: 65535, blue: 0, alpha: 65535)
    static let lime = BLRgba64(r: 0, g: 65535, b: 0, a: 65535)
    
    /// Lime green color (red: 12850, green: 52685, blue: 12850, alpha: 65535)
    static let limeGreen = BLRgba64(r: 12850, g: 52685, b: 12850, a: 65535)
    
    /// Linen color (red: 64250, green: 61680, blue: 59110, alpha: 65535)
    static let linen = BLRgba64(r: 64250, g: 61680, b: 59110, a: 65535)
    
    /// Magenta color (red: 65535, green: 0, blue: 65535, alpha: 65535)
    static let magenta = BLRgba64(r: 65535, g: 0, b: 65535, a: 65535)
    
    /// Maroon color (red: 32896, green: 0, blue: 0, alpha: 65535)
    static let maroon = BLRgba64(r: 32896, g: 0, b: 0, a: 65535)
    
    /// Medium aquamarine color (red: 26214, green: 52685, blue: 43690, alpha: 65535)
    static let mediumAquamarine = BLRgba64(r: 26214, g: 52685, b: 43690, a: 65535)
    
    /// Medium blue color (red: 0, green: 0, blue: 52685, alpha: 65535)
    static let mediumBlue = BLRgba64(r: 0, g: 0, b: 52685, a: 65535)
    
    /// Medium orchid color (red: 47802, green: 21845, blue: 54227, alpha: 65535)
    static let mediumOrchid = BLRgba64(r: 47802, g: 21845, b: 54227, a: 65535)
    
    /// Medium purple color (red: 37779, green: 28784, blue: 56283, alpha: 65535)
    static let mediumPurple = BLRgba64(r: 37779, g: 28784, b: 56283, a: 65535)
    
    /// Medium sea green color (red: 15420, green: 46003, blue: 29041, alpha: 65535)
    static let mediumSeaGreen = BLRgba64(r: 15420, g: 46003, b: 29041, a: 65535)
    
    /// Medium slate blue color (red: 31611, green: 26728, blue: 61166, alpha: 65535)
    static let mediumSlateBlue = BLRgba64(r: 31611, g: 26728, b: 61166, a: 65535)
    
    /// Medium spring green color (red: 0, green: 64250, blue: 39578, alpha: 65535)
    static let mediumSpringGreen = BLRgba64(r: 0, g: 64250, b: 39578, a: 65535)
    
    /// Medium turquoise color (red: 18504, green: 53713, blue: 52428, alpha: 65535)
    static let mediumTurquoise = BLRgba64(r: 18504, g: 53713, b: 52428, a: 65535)
    
    /// Medium violet red color (red: 51143, green: 5397, blue: 34181, alpha: 65535)
    static let mediumVioletRed = BLRgba64(r: 51143, g: 5397, b: 34181, a: 65535)
    
    /// Midnight blue color (red: 6425, green: 6425, blue: 28784, alpha: 65535)
    static let midnightBlue = BLRgba64(r: 6425, g: 6425, b: 28784, a: 65535)
    
    /// Mint cream color (red: 62965, green: 65535, blue: 64250, alpha: 65535)
    static let mintCream = BLRgba64(r: 62965, g: 65535, b: 64250, a: 65535)
    
    /// Misty rose color (red: 65535, green: 58596, blue: 57825, alpha: 65535)
    static let mistyRose = BLRgba64(r: 65535, g: 58596, b: 57825, a: 65535)
    
    /// Moccasin color (red: 65535, green: 58596, blue: 46517, alpha: 65535)
    static let moccasin = BLRgba64(r: 65535, g: 58596, b: 46517, a: 65535)
    
    /// Navajo white color (red: 65535, green: 57054, blue: 44461, alpha: 65535)
    static let navajoWhite = BLRgba64(r: 65535, g: 57054, b: 44461, a: 65535)
    
    /// Navy color (red: 0, green: 0, blue: 32896, alpha: 65535)
    static let navy = BLRgba64(r: 0, g: 0, b: 32896, a: 65535)
    
    /// Old lace color (red: 65021, green: 62965, blue: 59110, alpha: 65535)
    static let oldLace = BLRgba64(r: 65021, g: 62965, b: 59110, a: 65535)
    
    /// Olive color (red: 32896, green: 32896, blue: 0, alpha: 65535)
    static let olive = BLRgba64(r: 32896, g: 32896, b: 0, a: 65535)
    
    /// Olive drab color (red: 27499, green: 36494, blue: 8995, alpha: 65535)
    static let oliveDrab = BLRgba64(r: 27499, g: 36494, b: 8995, a: 65535)
    
    /// Orange color (red: 65535, green: 42405, blue: 0, alpha: 65535)
    static let orange = BLRgba64(r: 65535, g: 42405, b: 0, a: 65535)
    
    /// Orange red color (red: 65535, green: 17733, blue: 0, alpha: 65535)
    static let orangeRed = BLRgba64(r: 65535, g: 17733, b: 0, a: 65535)
    
    /// Orchid color (red: 56026, green: 28784, blue: 54998, alpha: 65535)
    static let orchid = BLRgba64(r: 56026, g: 28784, b: 54998, a: 65535)
    
    /// Pale goldenrod color (red: 61166, green: 59624, blue: 43690, alpha: 65535)
    static let paleGoldenrod = BLRgba64(r: 61166, g: 59624, b: 43690, a: 65535)
    
    /// Pale green color (red: 39064, green: 64507, blue: 39064, alpha: 65535)
    static let paleGreen = BLRgba64(r: 39064, g: 64507, b: 39064, a: 65535)
    
    /// Pale turquoise color (red: 44975, green: 61166, blue: 61166, alpha: 65535)
    static let paleTurquoise = BLRgba64(r: 44975, g: 61166, b: 61166, a: 65535)
    
    /// Pale violet red color (red: 56283, green: 28784, blue: 37779, alpha: 65535)
    static let paleVioletRed = BLRgba64(r: 56283, g: 28784, b: 37779, a: 65535)
    
    /// Papaya whip color (red: 65535, green: 61423, blue: 54741, alpha: 65535)
    static let papayaWhip = BLRgba64(r: 65535, g: 61423, b: 54741, a: 65535)
    
    /// Peach puff color (red: 65535, green: 56026, blue: 47545, alpha: 65535)
    static let peachPuff = BLRgba64(r: 65535, g: 56026, b: 47545, a: 65535)
    
    /// Peru color (red: 52685, green: 34181, blue: 16191, alpha: 65535)
    static let peru = BLRgba64(r: 52685, g: 34181, b: 16191, a: 65535)
    
    /// Pink color (red: 65535, green: 49344, blue: 52171, alpha: 65535)
    static let pink = BLRgba64(r: 65535, g: 49344, b: 52171, a: 65535)
    
    /// Plum color (red: 56797, green: 41120, blue: 56797, alpha: 65535)
    static let plum = BLRgba64(r: 56797, g: 41120, b: 56797, a: 65535)
    
    /// Powder blue color (red: 45232, green: 57568, blue: 59110, alpha: 65535)
    static let powderBlue = BLRgba64(r: 45232, g: 57568, b: 59110, a: 65535)
    
    /// Purple color (red: 32896, green: 0, blue: 32896, alpha: 65535)
    static let purple = BLRgba64(r: 32896, g: 0, b: 32896, a: 65535)
    
    /// Red color (red: 65535, green: 0, blue: 0, alpha: 65535)
    static let red = BLRgba64(r: 65535, g: 0, b: 0, a: 65535)
    
    /// Rosy brown color (red: 48316, green: 36751, blue: 36751, alpha: 65535)
    static let rosyBrown = BLRgba64(r: 48316, g: 36751, b: 36751, a: 65535)
    
    /// Royal blue color (red: 16705, green: 26985, blue: 57825, alpha: 65535)
    static let royalBlue = BLRgba64(r: 16705, g: 26985, b: 57825, a: 65535)
    
    /// Saddle brown color (red: 35723, green: 17733, blue: 4883, alpha: 65535)
    static let saddleBrown = BLRgba64(r: 35723, g: 17733, b: 4883, a: 65535)
    
    /// Salmon color (red: 64250, green: 32896, blue: 29298, alpha: 65535)
    static let salmon = BLRgba64(r: 64250, g: 32896, b: 29298, a: 65535)
    
    /// Sandy brown color (red: 62708, green: 42148, blue: 24672, alpha: 65535)
    static let sandyBrown = BLRgba64(r: 62708, g: 42148, b: 24672, a: 65535)
    
    /// Sea green color (red: 11822, green: 35723, blue: 22359, alpha: 65535)
    static let seaGreen = BLRgba64(r: 11822, g: 35723, b: 22359, a: 65535)
    
    /// Sea shell color (red: 65535, green: 62965, blue: 61166, alpha: 65535)
    static let seaShell = BLRgba64(r: 65535, g: 62965, b: 61166, a: 65535)
    
    /// Sienna color (red: 41120, green: 21074, blue: 11565, alpha: 65535)
    static let sienna = BLRgba64(r: 41120, g: 21074, b: 11565, a: 65535)
    
    /// Silver color (red: 49344, green: 49344, blue: 49344, alpha: 65535)
    static let silver = BLRgba64(r: 49344, g: 49344, b: 49344, a: 65535)
    
    /// Sky blue color (red: 34695, green: 52942, blue: 60395, alpha: 65535)
    static let skyBlue = BLRgba64(r: 34695, g: 52942, b: 60395, a: 65535)
    
    /// Slate blue color (red: 27242, green: 23130, blue: 52685, alpha: 65535)
    static let slateBlue = BLRgba64(r: 27242, g: 23130, b: 52685, a: 65535)
    
    /// Slate gray color (red: 28784, green: 32896, blue: 37008, alpha: 65535)
    static let slateGray = BLRgba64(r: 28784, g: 32896, b: 37008, a: 65535)
    
    /// Snow color (red: 65535, green: 64250, blue: 64250, alpha: 65535)
    static let snow = BLRgba64(r: 65535, g: 64250, b: 64250, a: 65535)
    
    /// Spring green color (red: 0, green: 65535, blue: 32639, alpha: 65535)
    static let springGreen = BLRgba64(r: 0, g: 65535, b: 32639, a: 65535)
    
    /// Steel blue color (red: 17990, green: 33410, blue: 46260, alpha: 65535)
    static let steelBlue = BLRgba64(r: 17990, g: 33410, b: 46260, a: 65535)
    
    /// Tan color (red: 53970, green: 46260, blue: 35980, alpha: 65535)
    static let tan = BLRgba64(r: 53970, g: 46260, b: 35980, a: 65535)
    
    /// Teal color (red: 0, green: 32896, blue: 32896, alpha: 65535)
    static let teal = BLRgba64(r: 0, g: 32896, b: 32896, a: 65535)
    
    /// Thistle color (red: 55512, green: 49087, blue: 55512, alpha: 65535)
    static let thistle = BLRgba64(r: 55512, g: 49087, b: 55512, a: 65535)
    
    /// Tomato color (red: 65535, green: 25443, blue: 18247, alpha: 65535)
    static let tomato = BLRgba64(r: 65535, g: 25443, b: 18247, a: 65535)
    
    /// Turquoise color (red: 16448, green: 57568, blue: 53456, alpha: 65535)
    static let turquoise = BLRgba64(r: 16448, g: 57568, b: 53456, a: 65535)
    
    /// Violet color (red: 61166, green: 33410, blue: 61166, alpha: 65535)
    static let violet = BLRgba64(r: 61166, g: 33410, b: 61166, a: 65535)
    
    /// Wheat color (red: 62965, green: 57054, blue: 46003, alpha: 65535)
    static let wheat = BLRgba64(r: 62965, g: 57054, b: 46003, a: 65535)
    
    /// White color (red: 65535, green: 65535, blue: 65535, alpha: 65535)
    static let white = BLRgba64(r: 65535, g: 65535, b: 65535, a: 65535)
    
    /// White smoke color (red: 62965, green: 62965, blue: 62965, alpha: 65535)
    static let whiteSmoke = BLRgba64(r: 62965, g: 62965, b: 62965, a: 65535)
    
    /// Yellow color (red: 65535, green: 65535, blue: 0, alpha: 65535)
    static let yellow = BLRgba64(r: 65535, g: 65535, b: 0, a: 65535)
    
    /// Yellow green color (red: 39578, green: 52685, blue: 12850, alpha: 65535)
    static let yellowGreen = BLRgba64(r: 39578, g: 52685, b: 12850, a: 65535)
}
