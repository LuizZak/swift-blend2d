import blend2d

/// Font feature settings.
public class BLFontFeatureSettings: BLBaseClass<BLFontFeatureSettingsCore> {
    /// Returns the number of key/value pairs stored in the container.
    public var size: Int {
        object.impl.size
    }

    /// Tests whether the container is empty, which means that no key/value pairs are stored in it.
    public var isEmpty: Bool {
        size == 0
    }

    /// Gets the font feature items in this array.
    public var items: [BLFontFeatureItem] {
        var view = BLFontFeatureSettingsView()
        getView(&view)

        return Array(view.makeIterator())
    }

    /// Returns a normalized view of key/value pairs as an iterable
    /// `BLFontFeatureItem` array in the output view.
    ///
    /// - note: If the container is in SSO mode then all `BLFontFeatureItem`
    /// values will be created from the underlying SSO representation and
    /// `BLFontFeatureSettingsView::data` will point to `BLFontFeatureSettingsView::ssoData`.
    /// If the container is dynamic, `BLFontFeatureSettingsView::ssoData` won't
    /// be initialized and `BLFontFeatureSettingsView::data` will point to the
    /// container's data. This means that the view cannot outlive the container,
    /// and also during iteration the view the container cannot be modified as
    /// that could invalidate the entire view.
    public func getView(_ view: inout BLFontFeatureSettingsView) {
        blFontFeatureSettingsGetView(&object, &view)
    }

    /// Tests whether the settings contains the given `featureTag`.
    public func hasValue(_ featureTag: BLTag) -> Bool {
        blFontFeatureSettingsHasValue(&object, featureTag)
    }

    /// Returns the value associated with the given `featureTag`.
    ///
    /// If the `featureTag` doesn't exist or is invalid `BL_FONT_FEATURE_INVALID_VALUE`
    /// is returned.
    public func getValue(_ featureTag: BLTag) -> UInt32 {
        blFontFeatureSettingsGetValue(&object, featureTag)
    }

    /// Sets or inserts the given `featureTag` to the settings, associating the
    /// `featureTag` with `value`.
    @discardableResult
    public func setValue(_ featureTag: BLTag, value: UInt32) -> BLResult {
        blFontFeatureSettingsSetValue(&object, featureTag, value)
    }

    /// Removes the given `featureTag` from the settings.
    ///
    /// Nothing happens if the `featureTag` is not in the settings (`BL_SUCCESS`
    /// is returned).
    @discardableResult
    public func removeValue(_ featureTag: BLTag) -> BLResult {
        blFontFeatureSettingsRemoveValue(&object, featureTag)
    }
}

extension BLFontFeatureSettings {
    public static func == (lhs: BLFontFeatureSettings, rhs: BLFontFeatureSettings) -> Bool {
        blFontFeatureSettingsEquals(&lhs.object, &rhs.object)
    }
}

extension BLFontFeatureSettingsCore: CoreStructure {
    public static let initializer = blFontFeatureSettingsInit
    public static let deinitializer = blFontFeatureSettingsReset
    public static let assignWeak = blFontFeatureSettingsAssignWeak

    @usableFromInline
    var impl: BLFontFeatureSettingsImpl {
        get { UnsafeMutablePointer(_d.impl)!.pointee }
        set { UnsafeMutablePointer(_d.impl)!.pointee = newValue }
    }
}
