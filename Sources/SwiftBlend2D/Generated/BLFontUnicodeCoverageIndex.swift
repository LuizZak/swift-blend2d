// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Bit positions in `BLFontUnicodeCoverage` structure.
/// 
/// Each bit represents a range (or multiple ranges) of unicode characters.
public extension BLFontUnicodeCoverageIndex {
    /// [000000-00007F] Basic Latin.
    static let ucIndexBasicLatin = BL_FONT_UC_INDEX_BASIC_LATIN
    
    /// [000080-0000FF] Latin-1 Supplement.
    static let ucIndexLatin1Supplement = BL_FONT_UC_INDEX_LATIN1_SUPPLEMENT
    
    /// [000100-00017F] Latin Extended-A.
    static let ucIndexLatinExtendedA = BL_FONT_UC_INDEX_LATIN_EXTENDED_A
    
    /// [000180-00024F] Latin Extended-B.
    static let ucIndexLatinExtendedB = BL_FONT_UC_INDEX_LATIN_EXTENDED_B
    
    /// [000250-0002AF] IPA Extensions.
    static let ucIndexIpaExtensions = BL_FONT_UC_INDEX_IPA_EXTENSIONS
    
    /// [0002B0-0002FF] Spacing Modifier Letters.
    static let ucIndexSpacingModifierLetters = BL_FONT_UC_INDEX_SPACING_MODIFIER_LETTERS
    
    /// [000300-00036F] Combining Diacritical Marks.
    static let ucIndexCombiningDiacriticalMarks = BL_FONT_UC_INDEX_COMBINING_DIACRITICAL_MARKS
    
    /// [000370-0003FF] Greek and Coptic.
    static let ucIndexGreekAndCoptic = BL_FONT_UC_INDEX_GREEK_AND_COPTIC
    
    /// [002C80-002CFF] Coptic.
    static let ucIndexCoptic = BL_FONT_UC_INDEX_COPTIC
    
    /// [000400-0004FF] Cyrillic.
    static let ucIndexCyrillic = BL_FONT_UC_INDEX_CYRILLIC
    
    /// [000530-00058F] Armenian.
    static let ucIndexArmenian = BL_FONT_UC_INDEX_ARMENIAN
    
    /// [000590-0005FF] Hebrew.
    static let ucIndexHebrew = BL_FONT_UC_INDEX_HEBREW
    
    /// [00A500-00A63F] Vai.
    static let ucIndexVai = BL_FONT_UC_INDEX_VAI
    
    /// [000600-0006FF] Arabic.
    static let ucIndexArabic = BL_FONT_UC_INDEX_ARABIC
    
    /// [0007C0-0007FF] NKo.
    static let ucIndexNko = BL_FONT_UC_INDEX_NKO
    
    /// [000900-00097F] Devanagari.
    static let ucIndexDevanagari = BL_FONT_UC_INDEX_DEVANAGARI
    
    /// [000980-0009FF] Bengali.
    static let ucIndexBengali = BL_FONT_UC_INDEX_BENGALI
    
    /// [000A00-000A7F] Gurmukhi.
    static let ucIndexGurmukhi = BL_FONT_UC_INDEX_GURMUKHI
    
    /// [000A80-000AFF] Gujarati.
    static let ucIndexGujarati = BL_FONT_UC_INDEX_GUJARATI
    
    /// [000B00-000B7F] Oriya.
    static let ucIndexOriya = BL_FONT_UC_INDEX_ORIYA
    
    /// [000B80-000BFF] Tamil.
    static let ucIndexTamil = BL_FONT_UC_INDEX_TAMIL
    
    /// [000C00-000C7F] Telugu.
    static let ucIndexTelugu = BL_FONT_UC_INDEX_TELUGU
    
    /// [000C80-000CFF] Kannada.
    static let ucIndexKannada = BL_FONT_UC_INDEX_KANNADA
    
    /// [000D00-000D7F] Malayalam.
    static let ucIndexMalayalam = BL_FONT_UC_INDEX_MALAYALAM
    
    /// [000E00-000E7F] Thai.
    static let ucIndexThai = BL_FONT_UC_INDEX_THAI
    
    /// [000E80-000EFF] Lao.
    static let ucIndexLao = BL_FONT_UC_INDEX_LAO
    
    /// [0010A0-0010FF] Georgian.
    static let ucIndexGeorgian = BL_FONT_UC_INDEX_GEORGIAN
    
    /// [001B00-001B7F] Balinese.
    static let ucIndexBalinese = BL_FONT_UC_INDEX_BALINESE
    
    /// [001100-0011FF] Hangul Jamo.
    static let ucIndexHangulJamo = BL_FONT_UC_INDEX_HANGUL_JAMO
    
    /// [001E00-001EFF] Latin Extended Additional.
    static let ucIndexLatinExtendedAdditional = BL_FONT_UC_INDEX_LATIN_EXTENDED_ADDITIONAL
    
    /// [001F00-001FFF] Greek Extended.
    static let ucIndexGreekExtended = BL_FONT_UC_INDEX_GREEK_EXTENDED
    
    /// [002000-00206F] General Punctuation.
    static let ucIndexGeneralPunctuation = BL_FONT_UC_INDEX_GENERAL_PUNCTUATION
    
    /// [002070-00209F] Superscripts And Subscripts.
    static let ucIndexSuperscriptsAndSubscripts = BL_FONT_UC_INDEX_SUPERSCRIPTS_AND_SUBSCRIPTS
    
    /// [0020A0-0020CF] Currency Symbols.
    static let ucIndexCurrencySymbols = BL_FONT_UC_INDEX_CURRENCY_SYMBOLS
    
    /// [0020D0-0020FF] Combining Diacritical Marks For Symbols.
    static let ucIndexCombiningDiacriticalMarksForSymbols = BL_FONT_UC_INDEX_COMBINING_DIACRITICAL_MARKS_FOR_SYMBOLS
    
    /// [002100-00214F] Letterlike Symbols.
    static let ucIndexLetterlikeSymbols = BL_FONT_UC_INDEX_LETTERLIKE_SYMBOLS
    
    /// [002150-00218F] Number Forms.
    static let ucIndexNumberForms = BL_FONT_UC_INDEX_NUMBER_FORMS
    
    /// [002190-0021FF] Arrows.
    static let ucIndexArrows = BL_FONT_UC_INDEX_ARROWS
    
    /// [002200-0022FF] Mathematical Operators.
    static let ucIndexMathematicalOperators = BL_FONT_UC_INDEX_MATHEMATICAL_OPERATORS
    
    /// [002300-0023FF] Miscellaneous Technical.
    static let ucIndexMiscellaneousTechnical = BL_FONT_UC_INDEX_MISCELLANEOUS_TECHNICAL
    
    /// [002400-00243F] Control Pictures.
    static let ucIndexControlPictures = BL_FONT_UC_INDEX_CONTROL_PICTURES
    
    /// [002440-00245F] Optical Character Recognition.
    static let ucIndexOpticalCharacterRecognition = BL_FONT_UC_INDEX_OPTICAL_CHARACTER_RECOGNITION
    
    /// [002460-0024FF] Enclosed Alphanumerics.
    static let ucIndexEnclosedAlphanumerics = BL_FONT_UC_INDEX_ENCLOSED_ALPHANUMERICS
    
    /// [002500-00257F] Box Drawing.
    static let ucIndexBoxDrawing = BL_FONT_UC_INDEX_BOX_DRAWING
    
    /// [002580-00259F] Block Elements.
    static let ucIndexBlockElements = BL_FONT_UC_INDEX_BLOCK_ELEMENTS
    
    /// [0025A0-0025FF] Geometric Shapes.
    static let ucIndexGeometricShapes = BL_FONT_UC_INDEX_GEOMETRIC_SHAPES
    
    /// [002600-0026FF] Miscellaneous Symbols.
    static let ucIndexMiscellaneousSymbols = BL_FONT_UC_INDEX_MISCELLANEOUS_SYMBOLS
    
    /// [002700-0027BF] Dingbats.
    static let ucIndexDingbats = BL_FONT_UC_INDEX_DINGBATS
    
    /// [003000-00303F] CJK Symbols And Punctuation.
    static let ucIndexCjkSymbolsAndPunctuation = BL_FONT_UC_INDEX_CJK_SYMBOLS_AND_PUNCTUATION
    
    /// [003040-00309F] Hiragana.
    static let ucIndexHiragana = BL_FONT_UC_INDEX_HIRAGANA
    
    /// [0030A0-0030FF] Katakana.
    static let ucIndexKatakana = BL_FONT_UC_INDEX_KATAKANA
    
    /// [003100-00312F] Bopomofo.
    static let ucIndexBopomofo = BL_FONT_UC_INDEX_BOPOMOFO
    
    /// [003130-00318F] Hangul Compatibility Jamo.
    static let ucIndexHangulCompatibilityJamo = BL_FONT_UC_INDEX_HANGUL_COMPATIBILITY_JAMO
    
    /// [00A840-00A87F] Phags-pa.
    static let ucIndexPhagsPa = BL_FONT_UC_INDEX_PHAGS_PA
    
    /// [003200-0032FF] Enclosed CJK Letters And Months.
    static let ucIndexEnclosedCjkLettersAndMonths = BL_FONT_UC_INDEX_ENCLOSED_CJK_LETTERS_AND_MONTHS
    
    /// [003300-0033FF] CJK Compatibility.
    static let ucIndexCjkCompatibility = BL_FONT_UC_INDEX_CJK_COMPATIBILITY
    
    /// [00AC00-00D7AF] Hangul Syllables.
    static let ucIndexHangulSyllables = BL_FONT_UC_INDEX_HANGUL_SYLLABLES
    
    /// [00D800-00DFFF] Non-Plane 0 *.
    static let ucIndexNonPlane = BL_FONT_UC_INDEX_NON_PLANE
    
    /// [010900-01091F] Phoenician.
    static let ucIndexPhoenician = BL_FONT_UC_INDEX_PHOENICIAN
    
    /// [004E00-009FFF] CJK Unified Ideographs.
    static let ucIndexCjkUnifiedIdeographs = BL_FONT_UC_INDEX_CJK_UNIFIED_IDEOGRAPHS
    
    /// [00E000-00F8FF] Private Use (Plane 0).
    static let ucIndexPrivateUsePlane0 = BL_FONT_UC_INDEX_PRIVATE_USE_PLANE0
    
    /// [0031C0-0031EF] CJK Strokes.
    static let ucIndexCjkStrokes = BL_FONT_UC_INDEX_CJK_STROKES
    
    /// [00FB00-00FB4F] Alphabetic Presentation Forms.
    static let ucIndexAlphabeticPresentationForms = BL_FONT_UC_INDEX_ALPHABETIC_PRESENTATION_FORMS
    
    /// [00FB50-00FDFF] Arabic Presentation Forms-A.
    static let ucIndexArabicPresentationFormsA = BL_FONT_UC_INDEX_ARABIC_PRESENTATION_FORMS_A
    
    /// [00FE20-00FE2F] Combining Half Marks.
    static let ucIndexCombiningHalfMarks = BL_FONT_UC_INDEX_COMBINING_HALF_MARKS
    
    /// [00FE10-00FE1F] Vertical Forms.
    static let ucIndexVerticalForms = BL_FONT_UC_INDEX_VERTICAL_FORMS
    
    /// [00FE50-00FE6F] Small Form Variants.
    static let ucIndexSmallFormVariants = BL_FONT_UC_INDEX_SMALL_FORM_VARIANTS
    
    /// [00FE70-00FEFF] Arabic Presentation Forms-B.
    static let ucIndexArabicPresentationFormsB = BL_FONT_UC_INDEX_ARABIC_PRESENTATION_FORMS_B
    
    /// [00FF00-00FFEF] Halfwidth And Fullwidth Forms.
    static let ucIndexHalfwidthAndFullwidthForms = BL_FONT_UC_INDEX_HALFWIDTH_AND_FULLWIDTH_FORMS
    
    /// [00FFF0-00FFFF] Specials.
    static let ucIndexSpecials = BL_FONT_UC_INDEX_SPECIALS
    
    /// [000F00-000FFF] Tibetan.
    static let ucIndexTibetan = BL_FONT_UC_INDEX_TIBETAN
    
    /// [000700-00074F] Syriac.
    static let ucIndexSyriac = BL_FONT_UC_INDEX_SYRIAC
    
    /// [000780-0007BF] Thaana.
    static let ucIndexThaana = BL_FONT_UC_INDEX_THAANA
    
    /// [000D80-000DFF] Sinhala.
    static let ucIndexSinhala = BL_FONT_UC_INDEX_SINHALA
    
    /// [001000-00109F] Myanmar.
    static let ucIndexMyanmar = BL_FONT_UC_INDEX_MYANMAR
    
    /// [001200-00137F] Ethiopic.
    static let ucIndexEthiopic = BL_FONT_UC_INDEX_ETHIOPIC
    
    /// [0013A0-0013FF] Cherokee.
    static let ucIndexCherokee = BL_FONT_UC_INDEX_CHEROKEE
    
    /// [001400-00167F] Unified Canadian Aboriginal Syllabics.
    static let ucIndexUnifiedCanadianAboriginalSyllabics = BL_FONT_UC_INDEX_UNIFIED_CANADIAN_ABORIGINAL_SYLLABICS
    
    /// [001680-00169F] Ogham.
    static let ucIndexOgham = BL_FONT_UC_INDEX_OGHAM
    
    /// [0016A0-0016FF] Runic.
    static let ucIndexRunic = BL_FONT_UC_INDEX_RUNIC
    
    /// [001780-0017FF] Khmer.
    static let ucIndexKhmer = BL_FONT_UC_INDEX_KHMER
    
    /// [001800-0018AF] Mongolian.
    static let ucIndexMongolian = BL_FONT_UC_INDEX_MONGOLIAN
    
    /// [002800-0028FF] Braille Patterns.
    static let ucIndexBraillePatterns = BL_FONT_UC_INDEX_BRAILLE_PATTERNS
    
    /// [00A000-00A48F] Yi Syllables.
    static let ucIndexYiSyllablesAndRadicals = BL_FONT_UC_INDEX_YI_SYLLABLES_AND_RADICALS
    
    /// [001700-00171F] Tagalog.
    static let ucIndexTagalogHanunooBuhidTagbanwa = BL_FONT_UC_INDEX_TAGALOG_HANUNOO_BUHID_TAGBANWA
    
    /// [010300-01032F] Old Italic.
    static let ucIndexOldItalic = BL_FONT_UC_INDEX_OLD_ITALIC
    
    /// [010330-01034F] Gothic.
    static let ucIndexGothic = BL_FONT_UC_INDEX_GOTHIC
    
    /// [010400-01044F] Deseret.
    static let ucIndexDeseret = BL_FONT_UC_INDEX_DESERET
    
    /// [01D000-01D0FF] Byzantine Musical Symbols.
    static let ucIndexMusicalSymbols = BL_FONT_UC_INDEX_MUSICAL_SYMBOLS
    
    /// [01D400-01D7FF] Mathematical Alphanumeric Symbols.
    static let ucIndexMathematicalAlphanumericSymbols = BL_FONT_UC_INDEX_MATHEMATICAL_ALPHANUMERIC_SYMBOLS
    
    /// [0F0000-0FFFFD] Private Use (Plane 15).
    static let ucIndexPrivateUsePlane15_16 = BL_FONT_UC_INDEX_PRIVATE_USE_PLANE_15_16
    
    /// [00FE00-00FE0F] Variation Selectors.
    static let ucIndexVariationSelectors = BL_FONT_UC_INDEX_VARIATION_SELECTORS
    
    /// [0E0000-0E007F] Tags.
    static let ucIndexTags = BL_FONT_UC_INDEX_TAGS
    
    /// [001900-00194F] Limbu.
    static let ucIndexLimbu = BL_FONT_UC_INDEX_LIMBU
    
    /// [001950-00197F] Tai Le.
    static let ucIndexTaiLe = BL_FONT_UC_INDEX_TAI_LE
    
    /// [001980-0019DF] New Tai Lue.
    static let ucIndexNewTaiLue = BL_FONT_UC_INDEX_NEW_TAI_LUE
    
    /// [001A00-001A1F] Buginese.
    static let ucIndexBuginese = BL_FONT_UC_INDEX_BUGINESE
    
    /// [002C00-002C5F] Glagolitic.
    static let ucIndexGlagolitic = BL_FONT_UC_INDEX_GLAGOLITIC
    
    /// [002D30-002D7F] Tifinagh.
    static let ucIndexTifinagh = BL_FONT_UC_INDEX_TIFINAGH
    
    /// [004DC0-004DFF] Yijing Hexagram Symbols.
    static let ucIndexYijingHexagramSymbols = BL_FONT_UC_INDEX_YIJING_HEXAGRAM_SYMBOLS
    
    /// [00A800-00A82F] Syloti Nagri.
    static let ucIndexSylotiNagri = BL_FONT_UC_INDEX_SYLOTI_NAGRI
    
    /// [010000-01007F] Linear B Syllabary.
    static let ucIndexLinearBSyllabaryAndIdeograms = BL_FONT_UC_INDEX_LINEAR_B_SYLLABARY_AND_IDEOGRAMS
    
    /// [010140-01018F] Ancient Greek Numbers.
    static let ucIndexAncientGreekNumbers = BL_FONT_UC_INDEX_ANCIENT_GREEK_NUMBERS
    
    /// [010380-01039F] Ugaritic.
    static let ucIndexUgaritic = BL_FONT_UC_INDEX_UGARITIC
    
    /// [0103A0-0103DF] Old Persian.
    static let ucIndexOldPersian = BL_FONT_UC_INDEX_OLD_PERSIAN
    
    /// [010450-01047F] Shavian.
    static let ucIndexShavian = BL_FONT_UC_INDEX_SHAVIAN
    
    /// [010480-0104AF] Osmanya.
    static let ucIndexOsmanya = BL_FONT_UC_INDEX_OSMANYA
    
    /// [010800-01083F] Cypriot Syllabary.
    static let ucIndexCypriotSyllabary = BL_FONT_UC_INDEX_CYPRIOT_SYLLABARY
    
    /// [010A00-010A5F] Kharoshthi.
    static let ucIndexKharoshthi = BL_FONT_UC_INDEX_KHAROSHTHI
    
    /// [01D300-01D35F] Tai Xuan Jing Symbols.
    static let ucIndexTaiXuanJingSymbols = BL_FONT_UC_INDEX_TAI_XUAN_JING_SYMBOLS
    
    /// [012000-0123FF] Cuneiform.
    static let ucIndexCuneiform = BL_FONT_UC_INDEX_CUNEIFORM
    
    /// [01D360-01D37F] Counting Rod Numerals.
    static let ucIndexCountingRodNumerals = BL_FONT_UC_INDEX_COUNTING_ROD_NUMERALS
    
    /// [001B80-001BBF] Sundanese.
    static let ucIndexSundanese = BL_FONT_UC_INDEX_SUNDANESE
    
    /// [001C00-001C4F] Lepcha.
    static let ucIndexLepcha = BL_FONT_UC_INDEX_LEPCHA
    
    /// [001C50-001C7F] Ol Chiki.
    static let ucIndexOlChiki = BL_FONT_UC_INDEX_OL_CHIKI
    
    /// [00A880-00A8DF] Saurashtra.
    static let ucIndexSaurashtra = BL_FONT_UC_INDEX_SAURASHTRA
    
    /// [00A900-00A92F] Kayah Li.
    static let ucIndexKayahLi = BL_FONT_UC_INDEX_KAYAH_LI
    
    /// [00A930-00A95F] Rejang.
    static let ucIndexRejang = BL_FONT_UC_INDEX_REJANG
    
    /// [00AA00-00AA5F] Cham.
    static let ucIndexCham = BL_FONT_UC_INDEX_CHAM
    
    /// [010190-0101CF] Ancient Symbols.
    static let ucIndexAncientSymbols = BL_FONT_UC_INDEX_ANCIENT_SYMBOLS
    
    /// [0101D0-0101FF] Phaistos Disc.
    static let ucIndexPhaistosDisc = BL_FONT_UC_INDEX_PHAISTOS_DISC
    
    /// [0102A0-0102DF] Carian.
    static let ucIndexCarianLycianLydian = BL_FONT_UC_INDEX_CARIAN_LYCIAN_LYDIAN
    
    /// [01F030-01F09F] Domino Tiles.
    static let ucIndexDominoAndMahjongTiles = BL_FONT_UC_INDEX_DOMINO_AND_MAHJONG_TILES
    
    /// Reserved for internal usage (123).
    static let ucIndexInternalUsage123 = BL_FONT_UC_INDEX_INTERNAL_USAGE_123
    
    /// Reserved for internal usage (124).
    static let ucIndexInternalUsage124 = BL_FONT_UC_INDEX_INTERNAL_USAGE_124
    
    /// Reserved for internal usage (125).
    static let ucIndexInternalUsage125 = BL_FONT_UC_INDEX_INTERNAL_USAGE_125
    
    /// Reserved for internal usage (126).
    static let ucIndexInternalUsage126 = BL_FONT_UC_INDEX_INTERNAL_USAGE_126
    
    /// Reserved for internal usage (127).
    static let ucIndexInternalUsage127 = BL_FONT_UC_INDEX_INTERNAL_USAGE_127
    
    /// Maximum value of `BLFontUnicodeCoverageIndex`.
    static let ucIndexMaxValue = BL_FONT_UC_INDEX_MAX_VALUE
}
