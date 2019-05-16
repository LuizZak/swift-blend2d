import blend2d

extension BLRgba64 {
    /// Transparent black color
    /// 
    /// Red: 0
    /// Green: 0
    /// Blue: 0
    /// Alpha: 0
    static let transparentBlack = BLRgba64(r: 0, g: 0, b: 0, a: 0)
    
    /// Transparent white color
    /// 
    /// Red: 65535
    /// Green: 65535
    /// Blue: 65535
    /// Alpha: 0
    static let transparentWhite = BLRgba64(r: 65535, g: 65535, b: 65535, a: 0)
    
    /// Alice blue color
    /// 
    /// Red: 61680
    /// Green: 63736
    /// Blue: 65535
    /// Alpha: 65535
    static let aliceBlue = BLRgba64(r: 61680, g: 63736, b: 65535, a: 65535)
    
    /// Antique white color
    /// 
    /// Red: 64250
    /// Green: 60395
    /// Blue: 55255
    /// Alpha: 65535
    static let antiqueWhite = BLRgba64(r: 64250, g: 60395, b: 55255, a: 65535)
    
    /// Aqua color
    /// 
    /// Red: 0
    /// Green: 65535
    /// Blue: 65535
    /// Alpha: 65535
    static let aqua = BLRgba64(r: 0, g: 65535, b: 65535, a: 65535)
    
    /// Aquamarine color
    /// 
    /// Red: 32639
    /// Green: 65535
    /// Blue: 54484
    /// Alpha: 65535
    static let aquamarine = BLRgba64(r: 32639, g: 65535, b: 54484, a: 65535)
    
    /// Azure color
    /// 
    /// Red: 61680
    /// Green: 65535
    /// Blue: 65535
    /// Alpha: 65535
    static let azure = BLRgba64(r: 61680, g: 65535, b: 65535, a: 65535)
    
    /// Beige color
    /// 
    /// Red: 62965
    /// Green: 62965
    /// Blue: 56540
    /// Alpha: 65535
    static let beige = BLRgba64(r: 62965, g: 62965, b: 56540, a: 65535)
    
    /// Bisque color
    /// 
    /// Red: 65535
    /// Green: 58596
    /// Blue: 50372
    /// Alpha: 65535
    static let bisque = BLRgba64(r: 65535, g: 58596, b: 50372, a: 65535)
    
    /// Black color
    /// 
    /// Red: 0
    /// Green: 0
    /// Blue: 0
    /// Alpha: 65535
    static let black = BLRgba64(r: 0, g: 0, b: 0, a: 65535)
    
    /// Blanched almond color
    /// 
    /// Red: 65535
    /// Green: 60395
    /// Blue: 52685
    /// Alpha: 65535
    static let blanchedAlmond = BLRgba64(r: 65535, g: 60395, b: 52685, a: 65535)
    
    /// Blue color
    /// 
    /// Red: 0
    /// Green: 0
    /// Blue: 65535
    /// Alpha: 65535
    static let blue = BLRgba64(r: 0, g: 0, b: 65535, a: 65535)
    
    /// Blue violet color
    /// 
    /// Red: 35466
    /// Green: 11051
    /// Blue: 58082
    /// Alpha: 65535
    static let blueViolet = BLRgba64(r: 35466, g: 11051, b: 58082, a: 65535)
    
    /// Brown color
    /// 
    /// Red: 42405
    /// Green: 10794
    /// Blue: 10794
    /// Alpha: 65535
    static let brown = BLRgba64(r: 42405, g: 10794, b: 10794, a: 65535)
    
    /// Burly wood color
    /// 
    /// Red: 57054
    /// Green: 47288
    /// Blue: 34695
    /// Alpha: 65535
    static let burlyWood = BLRgba64(r: 57054, g: 47288, b: 34695, a: 65535)
    
    /// Cadet blue color
    /// 
    /// Red: 24415
    /// Green: 40606
    /// Blue: 41120
    /// Alpha: 65535
    static let cadetBlue = BLRgba64(r: 24415, g: 40606, b: 41120, a: 65535)
    
    /// Chartreuse color
    /// 
    /// Red: 32639
    /// Green: 65535
    /// Blue: 0
    /// Alpha: 65535
    static let chartreuse = BLRgba64(r: 32639, g: 65535, b: 0, a: 65535)
    
    /// Chocolate color
    /// 
    /// Red: 53970
    /// Green: 26985
    /// Blue: 7710
    /// Alpha: 65535
    static let chocolate = BLRgba64(r: 53970, g: 26985, b: 7710, a: 65535)
    
    /// Coral color
    /// 
    /// Red: 65535
    /// Green: 32639
    /// Blue: 20560
    /// Alpha: 65535
    static let coral = BLRgba64(r: 65535, g: 32639, b: 20560, a: 65535)
    
    /// Cornflower blue color
    /// 
    /// Red: 25700
    /// Green: 38293
    /// Blue: 60909
    /// Alpha: 65535
    static let cornflowerBlue = BLRgba64(r: 25700, g: 38293, b: 60909, a: 65535)
    
    /// Cornsilk color
    /// 
    /// Red: 65535
    /// Green: 63736
    /// Blue: 56540
    /// Alpha: 65535
    static let cornsilk = BLRgba64(r: 65535, g: 63736, b: 56540, a: 65535)
    
    /// Crimson color
    /// 
    /// Red: 56540
    /// Green: 5140
    /// Blue: 15420
    /// Alpha: 65535
    static let crimson = BLRgba64(r: 56540, g: 5140, b: 15420, a: 65535)
    
    /// Cyan color
    /// 
    /// Red: 0
    /// Green: 65535
    /// Blue: 65535
    /// Alpha: 65535
    static let cyan = BLRgba64(r: 0, g: 65535, b: 65535, a: 65535)
    
    /// Dark blue color
    /// 
    /// Red: 0
    /// Green: 0
    /// Blue: 35723
    /// Alpha: 65535
    static let darkBlue = BLRgba64(r: 0, g: 0, b: 35723, a: 65535)
    
    /// Dark cyan color
    /// 
    /// Red: 0
    /// Green: 35723
    /// Blue: 35723
    /// Alpha: 65535
    static let darkCyan = BLRgba64(r: 0, g: 35723, b: 35723, a: 65535)
    
    /// Dark goldenrod color
    /// 
    /// Red: 47288
    /// Green: 34438
    /// Blue: 2827
    /// Alpha: 65535
    static let darkGoldenrod = BLRgba64(r: 47288, g: 34438, b: 2827, a: 65535)
    
    /// Dark gray color
    /// 
    /// Red: 43433
    /// Green: 43433
    /// Blue: 43433
    /// Alpha: 65535
    static let darkGray = BLRgba64(r: 43433, g: 43433, b: 43433, a: 65535)
    
    /// Dark green color
    /// 
    /// Red: 0
    /// Green: 25700
    /// Blue: 0
    /// Alpha: 65535
    static let darkGreen = BLRgba64(r: 0, g: 25700, b: 0, a: 65535)
    
    /// Dark khaki color
    /// 
    /// Red: 48573
    /// Green: 47031
    /// Blue: 27499
    /// Alpha: 65535
    static let darkKhaki = BLRgba64(r: 48573, g: 47031, b: 27499, a: 65535)
    
    /// Dark magenta color
    /// 
    /// Red: 35723
    /// Green: 0
    /// Blue: 35723
    /// Alpha: 65535
    static let darkMagenta = BLRgba64(r: 35723, g: 0, b: 35723, a: 65535)
    
    /// Dark olive green color
    /// 
    /// Red: 21845
    /// Green: 27499
    /// Blue: 12079
    /// Alpha: 65535
    static let darkOliveGreen = BLRgba64(r: 21845, g: 27499, b: 12079, a: 65535)
    
    /// Dark orange color
    /// 
    /// Red: 65535
    /// Green: 35980
    /// Blue: 0
    /// Alpha: 65535
    static let darkOrange = BLRgba64(r: 65535, g: 35980, b: 0, a: 65535)
    
    /// Dark orchid color
    /// 
    /// Red: 39321
    /// Green: 12850
    /// Blue: 52428
    /// Alpha: 65535
    static let darkOrchid = BLRgba64(r: 39321, g: 12850, b: 52428, a: 65535)
    
    /// Dark red color
    /// 
    /// Red: 35723
    /// Green: 0
    /// Blue: 0
    /// Alpha: 65535
    static let darkRed = BLRgba64(r: 35723, g: 0, b: 0, a: 65535)
    
    /// Dark salmon color
    /// 
    /// Red: 59881
    /// Green: 38550
    /// Blue: 31354
    /// Alpha: 65535
    static let darkSalmon = BLRgba64(r: 59881, g: 38550, b: 31354, a: 65535)
    
    /// Dark sea green color
    /// 
    /// Red: 36751
    /// Green: 48316
    /// Blue: 35723
    /// Alpha: 65535
    static let darkSeaGreen = BLRgba64(r: 36751, g: 48316, b: 35723, a: 65535)
    
    /// Dark slate blue color
    /// 
    /// Red: 18504
    /// Green: 15677
    /// Blue: 35723
    /// Alpha: 65535
    static let darkSlateBlue = BLRgba64(r: 18504, g: 15677, b: 35723, a: 65535)
    
    /// Dark slate gray color
    /// 
    /// Red: 12079
    /// Green: 20303
    /// Blue: 20303
    /// Alpha: 65535
    static let darkSlateGray = BLRgba64(r: 12079, g: 20303, b: 20303, a: 65535)
    
    /// Dark turquoise color
    /// 
    /// Red: 0
    /// Green: 52942
    /// Blue: 53713
    /// Alpha: 65535
    static let darkTurquoise = BLRgba64(r: 0, g: 52942, b: 53713, a: 65535)
    
    /// Dark violet color
    /// 
    /// Red: 38036
    /// Green: 0
    /// Blue: 54227
    /// Alpha: 65535
    static let darkViolet = BLRgba64(r: 38036, g: 0, b: 54227, a: 65535)
    
    /// Deep pink color
    /// 
    /// Red: 65535
    /// Green: 5140
    /// Blue: 37779
    /// Alpha: 65535
    static let deepPink = BLRgba64(r: 65535, g: 5140, b: 37779, a: 65535)
    
    /// Deep sky blue color
    /// 
    /// Red: 0
    /// Green: 49087
    /// Blue: 65535
    /// Alpha: 65535
    static let deepSkyBlue = BLRgba64(r: 0, g: 49087, b: 65535, a: 65535)
    
    /// Dim gray color
    /// 
    /// Red: 26985
    /// Green: 26985
    /// Blue: 26985
    /// Alpha: 65535
    static let dimGray = BLRgba64(r: 26985, g: 26985, b: 26985, a: 65535)
    
    /// Dodger blue color
    /// 
    /// Red: 7710
    /// Green: 37008
    /// Blue: 65535
    /// Alpha: 65535
    static let dodgerBlue = BLRgba64(r: 7710, g: 37008, b: 65535, a: 65535)
    
    /// Firebrick color
    /// 
    /// Red: 45746
    /// Green: 8738
    /// Blue: 8738
    /// Alpha: 65535
    static let firebrick = BLRgba64(r: 45746, g: 8738, b: 8738, a: 65535)
    
    /// Floral white color
    /// 
    /// Red: 65535
    /// Green: 64250
    /// Blue: 61680
    /// Alpha: 65535
    static let floralWhite = BLRgba64(r: 65535, g: 64250, b: 61680, a: 65535)
    
    /// Forest green color
    /// 
    /// Red: 8738
    /// Green: 35723
    /// Blue: 8738
    /// Alpha: 65535
    static let forestGreen = BLRgba64(r: 8738, g: 35723, b: 8738, a: 65535)
    
    /// Fuchsia color
    /// 
    /// Red: 65535
    /// Green: 0
    /// Blue: 65535
    /// Alpha: 65535
    static let fuchsia = BLRgba64(r: 65535, g: 0, b: 65535, a: 65535)
    
    /// Gainsboro color
    /// 
    /// Red: 56540
    /// Green: 56540
    /// Blue: 56540
    /// Alpha: 65535
    static let gainsboro = BLRgba64(r: 56540, g: 56540, b: 56540, a: 65535)
    
    /// Ghost white color
    /// 
    /// Red: 63736
    /// Green: 63736
    /// Blue: 65535
    /// Alpha: 65535
    static let ghostWhite = BLRgba64(r: 63736, g: 63736, b: 65535, a: 65535)
    
    /// Gold color
    /// 
    /// Red: 65535
    /// Green: 55255
    /// Blue: 0
    /// Alpha: 65535
    static let gold = BLRgba64(r: 65535, g: 55255, b: 0, a: 65535)
    
    /// Goldenrod color
    /// 
    /// Red: 56026
    /// Green: 42405
    /// Blue: 8224
    /// Alpha: 65535
    static let goldenrod = BLRgba64(r: 56026, g: 42405, b: 8224, a: 65535)
    
    /// Gray color
    /// 
    /// Red: 32896
    /// Green: 32896
    /// Blue: 32896
    /// Alpha: 65535
    static let gray = BLRgba64(r: 32896, g: 32896, b: 32896, a: 65535)
    
    /// Green color
    /// 
    /// Red: 0
    /// Green: 32896
    /// Blue: 0
    /// Alpha: 65535
    static let green = BLRgba64(r: 0, g: 32896, b: 0, a: 65535)
    
    /// Green yellow color
    /// 
    /// Red: 44461
    /// Green: 65535
    /// Blue: 12079
    /// Alpha: 65535
    static let greenYellow = BLRgba64(r: 44461, g: 65535, b: 12079, a: 65535)
    
    /// Honeydew color
    /// 
    /// Red: 61680
    /// Green: 65535
    /// Blue: 61680
    /// Alpha: 65535
    static let honeydew = BLRgba64(r: 61680, g: 65535, b: 61680, a: 65535)
    
    /// Hot pink color
    /// 
    /// Red: 65535
    /// Green: 26985
    /// Blue: 46260
    /// Alpha: 65535
    static let hotPink = BLRgba64(r: 65535, g: 26985, b: 46260, a: 65535)
    
    /// Indian red color
    /// 
    /// Red: 52685
    /// Green: 23644
    /// Blue: 23644
    /// Alpha: 65535
    static let indianRed = BLRgba64(r: 52685, g: 23644, b: 23644, a: 65535)
    
    /// Indigo color
    /// 
    /// Red: 19275
    /// Green: 0
    /// Blue: 33410
    /// Alpha: 65535
    static let indigo = BLRgba64(r: 19275, g: 0, b: 33410, a: 65535)
    
    /// Ivory color
    /// 
    /// Red: 65535
    /// Green: 65535
    /// Blue: 61680
    /// Alpha: 65535
    static let ivory = BLRgba64(r: 65535, g: 65535, b: 61680, a: 65535)
    
    /// Khaki color
    /// 
    /// Red: 61680
    /// Green: 59110
    /// Blue: 35980
    /// Alpha: 65535
    static let khaki = BLRgba64(r: 61680, g: 59110, b: 35980, a: 65535)
    
    /// Lavender color
    /// 
    /// Red: 59110
    /// Green: 59110
    /// Blue: 64250
    /// Alpha: 65535
    static let lavender = BLRgba64(r: 59110, g: 59110, b: 64250, a: 65535)
    
    /// Lavender blush color
    /// 
    /// Red: 65535
    /// Green: 61680
    /// Blue: 62965
    /// Alpha: 65535
    static let lavenderBlush = BLRgba64(r: 65535, g: 61680, b: 62965, a: 65535)
    
    /// Lawn green color
    /// 
    /// Red: 31868
    /// Green: 64764
    /// Blue: 0
    /// Alpha: 65535
    static let lawnGreen = BLRgba64(r: 31868, g: 64764, b: 0, a: 65535)
    
    /// Lemon chiffon color
    /// 
    /// Red: 65535
    /// Green: 64250
    /// Blue: 52685
    /// Alpha: 65535
    static let lemonChiffon = BLRgba64(r: 65535, g: 64250, b: 52685, a: 65535)
    
    /// Light blue color
    /// 
    /// Red: 44461
    /// Green: 55512
    /// Blue: 59110
    /// Alpha: 65535
    static let lightBlue = BLRgba64(r: 44461, g: 55512, b: 59110, a: 65535)
    
    /// Light coral color
    /// 
    /// Red: 61680
    /// Green: 32896
    /// Blue: 32896
    /// Alpha: 65535
    static let lightCoral = BLRgba64(r: 61680, g: 32896, b: 32896, a: 65535)
    
    /// Light cyan color
    /// 
    /// Red: 57568
    /// Green: 65535
    /// Blue: 65535
    /// Alpha: 65535
    static let lightCyan = BLRgba64(r: 57568, g: 65535, b: 65535, a: 65535)
    
    /// Light goldenrod yellow color
    /// 
    /// Red: 64250
    /// Green: 64250
    /// Blue: 53970
    /// Alpha: 65535
    static let lightGoldenrodYellow = BLRgba64(r: 64250, g: 64250, b: 53970, a: 65535)
    
    /// Light green color
    /// 
    /// Red: 37008
    /// Green: 61166
    /// Blue: 37008
    /// Alpha: 65535
    static let lightGreen = BLRgba64(r: 37008, g: 61166, b: 37008, a: 65535)
    
    /// Light gray color
    /// 
    /// Red: 54227
    /// Green: 54227
    /// Blue: 54227
    /// Alpha: 65535
    static let lightGray = BLRgba64(r: 54227, g: 54227, b: 54227, a: 65535)
    
    /// Light pink color
    /// 
    /// Red: 65535
    /// Green: 46774
    /// Blue: 49601
    /// Alpha: 65535
    static let lightPink = BLRgba64(r: 65535, g: 46774, b: 49601, a: 65535)
    
    /// Light salmon color
    /// 
    /// Red: 65535
    /// Green: 41120
    /// Blue: 31354
    /// Alpha: 65535
    static let lightSalmon = BLRgba64(r: 65535, g: 41120, b: 31354, a: 65535)
    
    /// Light sea green color
    /// 
    /// Red: 8224
    /// Green: 45746
    /// Blue: 43690
    /// Alpha: 65535
    static let lightSeaGreen = BLRgba64(r: 8224, g: 45746, b: 43690, a: 65535)
    
    /// Light sky blue color
    /// 
    /// Red: 34695
    /// Green: 52942
    /// Blue: 64250
    /// Alpha: 65535
    static let lightSkyBlue = BLRgba64(r: 34695, g: 52942, b: 64250, a: 65535)
    
    /// Light slate gray color
    /// 
    /// Red: 30583
    /// Green: 34952
    /// Blue: 39321
    /// Alpha: 65535
    static let lightSlateGray = BLRgba64(r: 30583, g: 34952, b: 39321, a: 65535)
    
    /// Light steel blue color
    /// 
    /// Red: 45232
    /// Green: 50372
    /// Blue: 57054
    /// Alpha: 65535
    static let lightSteelBlue = BLRgba64(r: 45232, g: 50372, b: 57054, a: 65535)
    
    /// Light yellow color
    /// 
    /// Red: 65535
    /// Green: 65535
    /// Blue: 57568
    /// Alpha: 65535
    static let lightYellow = BLRgba64(r: 65535, g: 65535, b: 57568, a: 65535)
    
    /// Lime color
    /// 
    /// Red: 0
    /// Green: 65535
    /// Blue: 0
    /// Alpha: 65535
    static let lime = BLRgba64(r: 0, g: 65535, b: 0, a: 65535)
    
    /// Lime green color
    /// 
    /// Red: 12850
    /// Green: 52685
    /// Blue: 12850
    /// Alpha: 65535
    static let limeGreen = BLRgba64(r: 12850, g: 52685, b: 12850, a: 65535)
    
    /// Linen color
    /// 
    /// Red: 64250
    /// Green: 61680
    /// Blue: 59110
    /// Alpha: 65535
    static let linen = BLRgba64(r: 64250, g: 61680, b: 59110, a: 65535)
    
    /// Magenta color
    /// 
    /// Red: 65535
    /// Green: 0
    /// Blue: 65535
    /// Alpha: 65535
    static let magenta = BLRgba64(r: 65535, g: 0, b: 65535, a: 65535)
    
    /// Maroon color
    /// 
    /// Red: 32896
    /// Green: 0
    /// Blue: 0
    /// Alpha: 65535
    static let maroon = BLRgba64(r: 32896, g: 0, b: 0, a: 65535)
    
    /// Medium aquamarine color
    /// 
    /// Red: 26214
    /// Green: 52685
    /// Blue: 43690
    /// Alpha: 65535
    static let mediumAquamarine = BLRgba64(r: 26214, g: 52685, b: 43690, a: 65535)
    
    /// Medium blue color
    /// 
    /// Red: 0
    /// Green: 0
    /// Blue: 52685
    /// Alpha: 65535
    static let mediumBlue = BLRgba64(r: 0, g: 0, b: 52685, a: 65535)
    
    /// Medium orchid color
    /// 
    /// Red: 47802
    /// Green: 21845
    /// Blue: 54227
    /// Alpha: 65535
    static let mediumOrchid = BLRgba64(r: 47802, g: 21845, b: 54227, a: 65535)
    
    /// Medium purple color
    /// 
    /// Red: 37779
    /// Green: 28784
    /// Blue: 56283
    /// Alpha: 65535
    static let mediumPurple = BLRgba64(r: 37779, g: 28784, b: 56283, a: 65535)
    
    /// Medium sea green color
    /// 
    /// Red: 15420
    /// Green: 46003
    /// Blue: 29041
    /// Alpha: 65535
    static let mediumSeaGreen = BLRgba64(r: 15420, g: 46003, b: 29041, a: 65535)
    
    /// Medium slate blue color
    /// 
    /// Red: 31611
    /// Green: 26728
    /// Blue: 61166
    /// Alpha: 65535
    static let mediumSlateBlue = BLRgba64(r: 31611, g: 26728, b: 61166, a: 65535)
    
    /// Medium spring green color
    /// 
    /// Red: 0
    /// Green: 64250
    /// Blue: 39578
    /// Alpha: 65535
    static let mediumSpringGreen = BLRgba64(r: 0, g: 64250, b: 39578, a: 65535)
    
    /// Medium turquoise color
    /// 
    /// Red: 18504
    /// Green: 53713
    /// Blue: 52428
    /// Alpha: 65535
    static let mediumTurquoise = BLRgba64(r: 18504, g: 53713, b: 52428, a: 65535)
    
    /// Medium violet red color
    /// 
    /// Red: 51143
    /// Green: 5397
    /// Blue: 34181
    /// Alpha: 65535
    static let mediumVioletRed = BLRgba64(r: 51143, g: 5397, b: 34181, a: 65535)
    
    /// Midnight blue color
    /// 
    /// Red: 6425
    /// Green: 6425
    /// Blue: 28784
    /// Alpha: 65535
    static let midnightBlue = BLRgba64(r: 6425, g: 6425, b: 28784, a: 65535)
    
    /// Mint cream color
    /// 
    /// Red: 62965
    /// Green: 65535
    /// Blue: 64250
    /// Alpha: 65535
    static let mintCream = BLRgba64(r: 62965, g: 65535, b: 64250, a: 65535)
    
    /// Misty rose color
    /// 
    /// Red: 65535
    /// Green: 58596
    /// Blue: 57825
    /// Alpha: 65535
    static let mistyRose = BLRgba64(r: 65535, g: 58596, b: 57825, a: 65535)
    
    /// Moccasin color
    /// 
    /// Red: 65535
    /// Green: 58596
    /// Blue: 46517
    /// Alpha: 65535
    static let moccasin = BLRgba64(r: 65535, g: 58596, b: 46517, a: 65535)
    
    /// Navajo white color
    /// 
    /// Red: 65535
    /// Green: 57054
    /// Blue: 44461
    /// Alpha: 65535
    static let navajoWhite = BLRgba64(r: 65535, g: 57054, b: 44461, a: 65535)
    
    /// Navy color
    /// 
    /// Red: 0
    /// Green: 0
    /// Blue: 32896
    /// Alpha: 65535
    static let navy = BLRgba64(r: 0, g: 0, b: 32896, a: 65535)
    
    /// Old lace color
    /// 
    /// Red: 65021
    /// Green: 62965
    /// Blue: 59110
    /// Alpha: 65535
    static let oldLace = BLRgba64(r: 65021, g: 62965, b: 59110, a: 65535)
    
    /// Olive color
    /// 
    /// Red: 32896
    /// Green: 32896
    /// Blue: 0
    /// Alpha: 65535
    static let olive = BLRgba64(r: 32896, g: 32896, b: 0, a: 65535)
    
    /// Olive drab color
    /// 
    /// Red: 27499
    /// Green: 36494
    /// Blue: 8995
    /// Alpha: 65535
    static let oliveDrab = BLRgba64(r: 27499, g: 36494, b: 8995, a: 65535)
    
    /// Orange color
    /// 
    /// Red: 65535
    /// Green: 42405
    /// Blue: 0
    /// Alpha: 65535
    static let orange = BLRgba64(r: 65535, g: 42405, b: 0, a: 65535)
    
    /// Orange red color
    /// 
    /// Red: 65535
    /// Green: 17733
    /// Blue: 0
    /// Alpha: 65535
    static let orangeRed = BLRgba64(r: 65535, g: 17733, b: 0, a: 65535)
    
    /// Orchid color
    /// 
    /// Red: 56026
    /// Green: 28784
    /// Blue: 54998
    /// Alpha: 65535
    static let orchid = BLRgba64(r: 56026, g: 28784, b: 54998, a: 65535)
    
    /// Pale goldenrod color
    /// 
    /// Red: 61166
    /// Green: 59624
    /// Blue: 43690
    /// Alpha: 65535
    static let paleGoldenrod = BLRgba64(r: 61166, g: 59624, b: 43690, a: 65535)
    
    /// Pale green color
    /// 
    /// Red: 39064
    /// Green: 64507
    /// Blue: 39064
    /// Alpha: 65535
    static let paleGreen = BLRgba64(r: 39064, g: 64507, b: 39064, a: 65535)
    
    /// Pale turquoise color
    /// 
    /// Red: 44975
    /// Green: 61166
    /// Blue: 61166
    /// Alpha: 65535
    static let paleTurquoise = BLRgba64(r: 44975, g: 61166, b: 61166, a: 65535)
    
    /// Pale violet red color
    /// 
    /// Red: 56283
    /// Green: 28784
    /// Blue: 37779
    /// Alpha: 65535
    static let paleVioletRed = BLRgba64(r: 56283, g: 28784, b: 37779, a: 65535)
    
    /// Papaya whip color
    /// 
    /// Red: 65535
    /// Green: 61423
    /// Blue: 54741
    /// Alpha: 65535
    static let papayaWhip = BLRgba64(r: 65535, g: 61423, b: 54741, a: 65535)
    
    /// Peach puff color
    /// 
    /// Red: 65535
    /// Green: 56026
    /// Blue: 47545
    /// Alpha: 65535
    static let peachPuff = BLRgba64(r: 65535, g: 56026, b: 47545, a: 65535)
    
    /// Peru color
    /// 
    /// Red: 52685
    /// Green: 34181
    /// Blue: 16191
    /// Alpha: 65535
    static let peru = BLRgba64(r: 52685, g: 34181, b: 16191, a: 65535)
    
    /// Pink color
    /// 
    /// Red: 65535
    /// Green: 49344
    /// Blue: 52171
    /// Alpha: 65535
    static let pink = BLRgba64(r: 65535, g: 49344, b: 52171, a: 65535)
    
    /// Plum color
    /// 
    /// Red: 56797
    /// Green: 41120
    /// Blue: 56797
    /// Alpha: 65535
    static let plum = BLRgba64(r: 56797, g: 41120, b: 56797, a: 65535)
    
    /// Powder blue color
    /// 
    /// Red: 45232
    /// Green: 57568
    /// Blue: 59110
    /// Alpha: 65535
    static let powderBlue = BLRgba64(r: 45232, g: 57568, b: 59110, a: 65535)
    
    /// Purple color
    /// 
    /// Red: 32896
    /// Green: 0
    /// Blue: 32896
    /// Alpha: 65535
    static let purple = BLRgba64(r: 32896, g: 0, b: 32896, a: 65535)
    
    /// Red color
    /// 
    /// Red: 65535
    /// Green: 0
    /// Blue: 0
    /// Alpha: 65535
    static let red = BLRgba64(r: 65535, g: 0, b: 0, a: 65535)
    
    /// Rosy brown color
    /// 
    /// Red: 48316
    /// Green: 36751
    /// Blue: 36751
    /// Alpha: 65535
    static let rosyBrown = BLRgba64(r: 48316, g: 36751, b: 36751, a: 65535)
    
    /// Royal blue color
    /// 
    /// Red: 16705
    /// Green: 26985
    /// Blue: 57825
    /// Alpha: 65535
    static let royalBlue = BLRgba64(r: 16705, g: 26985, b: 57825, a: 65535)
    
    /// Saddle brown color
    /// 
    /// Red: 35723
    /// Green: 17733
    /// Blue: 4883
    /// Alpha: 65535
    static let saddleBrown = BLRgba64(r: 35723, g: 17733, b: 4883, a: 65535)
    
    /// Salmon color
    /// 
    /// Red: 64250
    /// Green: 32896
    /// Blue: 29298
    /// Alpha: 65535
    static let salmon = BLRgba64(r: 64250, g: 32896, b: 29298, a: 65535)
    
    /// Sandy brown color
    /// 
    /// Red: 62708
    /// Green: 42148
    /// Blue: 24672
    /// Alpha: 65535
    static let sandyBrown = BLRgba64(r: 62708, g: 42148, b: 24672, a: 65535)
    
    /// Sea green color
    /// 
    /// Red: 11822
    /// Green: 35723
    /// Blue: 22359
    /// Alpha: 65535
    static let seaGreen = BLRgba64(r: 11822, g: 35723, b: 22359, a: 65535)
    
    /// Sea shell color
    /// 
    /// Red: 65535
    /// Green: 62965
    /// Blue: 61166
    /// Alpha: 65535
    static let seaShell = BLRgba64(r: 65535, g: 62965, b: 61166, a: 65535)
    
    /// Sienna color
    /// 
    /// Red: 41120
    /// Green: 21074
    /// Blue: 11565
    /// Alpha: 65535
    static let sienna = BLRgba64(r: 41120, g: 21074, b: 11565, a: 65535)
    
    /// Silver color
    /// 
    /// Red: 49344
    /// Green: 49344
    /// Blue: 49344
    /// Alpha: 65535
    static let silver = BLRgba64(r: 49344, g: 49344, b: 49344, a: 65535)
    
    /// Sky blue color
    /// 
    /// Red: 34695
    /// Green: 52942
    /// Blue: 60395
    /// Alpha: 65535
    static let skyBlue = BLRgba64(r: 34695, g: 52942, b: 60395, a: 65535)
    
    /// Slate blue color
    /// 
    /// Red: 27242
    /// Green: 23130
    /// Blue: 52685
    /// Alpha: 65535
    static let slateBlue = BLRgba64(r: 27242, g: 23130, b: 52685, a: 65535)
    
    /// Slate gray color
    /// 
    /// Red: 28784
    /// Green: 32896
    /// Blue: 37008
    /// Alpha: 65535
    static let slateGray = BLRgba64(r: 28784, g: 32896, b: 37008, a: 65535)
    
    /// Snow color
    /// 
    /// Red: 65535
    /// Green: 64250
    /// Blue: 64250
    /// Alpha: 65535
    static let snow = BLRgba64(r: 65535, g: 64250, b: 64250, a: 65535)
    
    /// Spring green color
    /// 
    /// Red: 0
    /// Green: 65535
    /// Blue: 32639
    /// Alpha: 65535
    static let springGreen = BLRgba64(r: 0, g: 65535, b: 32639, a: 65535)
    
    /// Steel blue color
    /// 
    /// Red: 17990
    /// Green: 33410
    /// Blue: 46260
    /// Alpha: 65535
    static let steelBlue = BLRgba64(r: 17990, g: 33410, b: 46260, a: 65535)
    
    /// Tan color
    /// 
    /// Red: 53970
    /// Green: 46260
    /// Blue: 35980
    /// Alpha: 65535
    static let tan = BLRgba64(r: 53970, g: 46260, b: 35980, a: 65535)
    
    /// Teal color
    /// 
    /// Red: 0
    /// Green: 32896
    /// Blue: 32896
    /// Alpha: 65535
    static let teal = BLRgba64(r: 0, g: 32896, b: 32896, a: 65535)
    
    /// Thistle color
    /// 
    /// Red: 55512
    /// Green: 49087
    /// Blue: 55512
    /// Alpha: 65535
    static let thistle = BLRgba64(r: 55512, g: 49087, b: 55512, a: 65535)
    
    /// Tomato color
    /// 
    /// Red: 65535
    /// Green: 25443
    /// Blue: 18247
    /// Alpha: 65535
    static let tomato = BLRgba64(r: 65535, g: 25443, b: 18247, a: 65535)
    
    /// Turquoise color
    /// 
    /// Red: 16448
    /// Green: 57568
    /// Blue: 53456
    /// Alpha: 65535
    static let turquoise = BLRgba64(r: 16448, g: 57568, b: 53456, a: 65535)
    
    /// Violet color
    /// 
    /// Red: 61166
    /// Green: 33410
    /// Blue: 61166
    /// Alpha: 65535
    static let violet = BLRgba64(r: 61166, g: 33410, b: 61166, a: 65535)
    
    /// Wheat color
    /// 
    /// Red: 62965
    /// Green: 57054
    /// Blue: 46003
    /// Alpha: 65535
    static let wheat = BLRgba64(r: 62965, g: 57054, b: 46003, a: 65535)
    
    /// White color
    /// 
    /// Red: 65535
    /// Green: 65535
    /// Blue: 65535
    /// Alpha: 65535
    static let white = BLRgba64(r: 65535, g: 65535, b: 65535, a: 65535)
    
    /// White smoke color
    /// 
    /// Red: 62965
    /// Green: 62965
    /// Blue: 62965
    /// Alpha: 65535
    static let whiteSmoke = BLRgba64(r: 62965, g: 62965, b: 62965, a: 65535)
    
    /// Yellow color
    /// 
    /// Red: 65535
    /// Green: 65535
    /// Blue: 0
    /// Alpha: 65535
    static let yellow = BLRgba64(r: 65535, g: 65535, b: 0, a: 65535)
    
    /// Yellow green color
    /// 
    /// Red: 39578
    /// Green: 52685
    /// Blue: 12850
    /// Alpha: 65535
    static let yellowGreen = BLRgba64(r: 39578, g: 52685, b: 12850, a: 65535)
}
