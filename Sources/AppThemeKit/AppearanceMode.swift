import UIKit

/// The appearance mode the user can choose.
public enum AppearanceMode: String, CaseIterable {
    case system
    case light
    case dark

    /// `.unspecified` = follow the system setting.
    public var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system: return .unspecified
        case .light:  return .light
        case .dark:   return .dark
        }
    }

    /// Localizable through the host app's own Localizable.strings / String Catalog.
    public var title: String {
        switch self {
        case .system: return NSLocalizedString("system", bundle: .main, value: "System", comment: "Appearance mode")
        case .light:  return NSLocalizedString("light", bundle: .main, value: "Light", comment: "Appearance mode")
        case .dark:   return NSLocalizedString("dark", bundle: .main, value: "Dark", comment: "Appearance mode")
        }
    }
}
