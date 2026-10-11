import UIKit

/// Stores the appearance mode and accent color, persists them, and applies them to windows.
public final class ThemeManager {

    public static let shared = ThemeManager()

    /// Posted when the theme changes. Observe it to refresh custom UI.
    public static let didChangeNotification = Notification.Name("AppThemeKit.didChange")

    public var appearance: AppearanceMode {
        didSet {
            guard appearance != oldValue else { return }
            defaults.set(appearance.rawValue, forKey: Keys.appearance)
            applyAndNotify()
        }
    }

    public var accentID: String {
        didSet {
            guard accentID != oldValue else { return }
            defaults.set(accentID, forKey: Keys.accent)
            applyAndNotify()
        }
    }

    public let accents: [ThemeAccent]

    private let defaults: UserDefaults
    private let windows = NSHashTable<UIWindow>.weakObjects()

    private enum Keys {
        static let appearance = "AppThemeKit.appearance"
        static let accent = "AppThemeKit.accent"
    }

    public init(
        accents: [ThemeAccent] = ThemeAccent.presets,
        defaultAccent: ThemeAccent = .blue,
        defaults: UserDefaults = .standard
    ) {
        self.defaults = defaults
        self.accents = accents
        self.appearance = defaults.string(forKey: Keys.appearance)
            .flatMap(AppearanceMode.init(rawValue:)) ?? .system
        self.accentID = defaults.string(forKey: Keys.accent) ?? defaultAccent.id
    }

    /// The selected accent color. Falls back to the first accent if the saved id is not in the list.
    public var accentColor: UIColor {
        (accents.first { $0.id == accentID } ?? accents.first)?.color ?? .systemBlue
    }

    /// Registers the window and immediately applies the saved theme.
    /// Call once in your SceneDelegate after creating the window.
    public func register(window: UIWindow) {
        windows.add(window)
        apply(to: window)
    }

    // MARK: - Private

    private func apply(to window: UIWindow) {
        window.overrideUserInterfaceStyle = appearance.userInterfaceStyle
        window.tintColor = accentColor
    }

    private func allWindows() -> [UIWindow] {
        var result = windows.allObjects
        let sceneWindows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
        for w in sceneWindows where !result.contains(w) { result.append(w) }
        return result
    }

    private func applyAndNotify() {
        for window in allWindows() {
            UIView.transition(
                with: window,
                duration: 0.25,
                options: .transitionCrossDissolve,
                animations: { self.apply(to: window) }
            )
        }
        NotificationCenter.default.post(name: Self.didChangeNotification, object: self)
    }
}
