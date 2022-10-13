import blend2d

/// Font variation settings.
public class BLFontVariationSettings: BLBaseClass<BLFontVariationSettingsCore> {
    /// Returns the number of key/value pairs stored in the container.
    public var size: Int {
        object.impl.size
    }

    /// Tests whether the container is empty, which means that no key/value pairs are stored in it.
    public var isEmpty: Bool {
        size == 0
    }

    /// Gets the font variation items in this array.
    public var items: [BLFontVariationItem] {
        var view = BLFontVariationSettingsView()
        getView(&view)

        return Array(view.makeIterator())
    }

    /// Returns a normalized view of key/value pairs as an iterable
    /// `BLFontVariationItem` array in the output view.
    ///
    /// - note: If the container is in SSO mode then all `BLFontVariationItem`
    /// values will be created from the underlying SSO representation and
    /// `BLFontVariationSettingsView::data` will point to `BLFontVariationSettingsView::ssoData`.
    /// If the container is dynamic, `BLFontVariationSettingsView::ssoData` won't
    /// be initialized and `BLFontVariationSettingsView::data` will point to the
    /// container's data. This means that the view cannot outlive the container,
    /// and also during iteration the view the container cannot be modified as
    /// that could invalidate the entire view.
    public func getView(_ view: inout BLFontVariationSettingsView) {
        blFontVariationSettingsGetView(&object, &view)
    }

    /// Tests whether the settings contains the given `key`.
    public func hasKey(_ key: BLTag) -> Bool {
        blFontVariationSettingsHasKey(&object, key)
    }

    /// Returns the value associated with the given `key`.
    ///
    /// If the `key` doesn't exist or is invalid `NaN` is returned.
    public func getKey(_ key: BLTag) -> Float {
        blFontVariationSettingsGetKey(&object, key)
    }

    /// Sets or inserts the given `key` to the settings, associating the `key`
    /// with `value`.
    @discardableResult
    public func setKey(_ key: BLTag, value: Float) -> BLResult {
        blFontVariationSettingsSetKey(&object, key, value)
    }

    /// Removes the given `key` from the settings.
    ///
    /// Nothing happens if the `key` is not in the settings (`BL_SUCCESS` is
    /// returned).
    @discardableResult
    public func removeKey(_ key: BLTag) -> BLResult {
        blFontVariationSettingsRemoveKey(&object, key)
    }
}

extension BLFontVariationSettings {
    public static func == (lhs: BLFontVariationSettings, rhs: BLFontVariationSettings) -> Bool {
        blFontVariationSettingsEquals(&lhs.object, &rhs.object)
    }
}

extension BLFontVariationSettingsCore: CoreStructure {
    public static let initializer = blFontVariationSettingsInit
    public static let deinitializer = blFontVariationSettingsReset
    public static let assignWeak = blFontVariationSettingsAssignWeak

    @usableFromInline
    var impl: BLFontVariationSettingsImpl {
        get {
            _d.impl!.load(as: BLFontVariationSettingsImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLFontVariationSettingsImpl.self)
        }
    }
}
