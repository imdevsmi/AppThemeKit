import UIKit

/// A selectable accent (theme) color.
public struct ThemeAccent: Equatable {
    public let id: String
    public let name: String
    public let color: UIColor

    public init(id: String, name: String, color: UIColor) {
        self.id = id
        self.name = name
        self.color = color
    }

    public static let blue   = ThemeAccent(id: "blue",   name: NSLocalizedString("blue", bundle: .main, value: "Blue", comment: "Accent color name"),   color: .systemBlue)
    public static let purple = ThemeAccent(id: "purple", name: NSLocalizedString("purple", bundle: .main, value: "Purple", comment: "Accent color name"), color: .systemPurple)
    public static let pink   = ThemeAccent(id: "pink",   name: NSLocalizedString("pink", bundle: .main, value: "Pink", comment: "Accent color name"),   color: .systemPink)
    public static let red    = ThemeAccent(id: "red",    name: NSLocalizedString("red", bundle: .main, value: "Red", comment: "Accent color name"),    color: .systemRed)
    public static let orange = ThemeAccent(id: "orange", name: NSLocalizedString("orange", bundle: .main, value: "Orange", comment: "Accent color name"), color: .systemOrange)
    public static let green  = ThemeAccent(id: "green",  name: NSLocalizedString("green", bundle: .main, value: "Green", comment: "Accent color name"),  color: .systemGreen)
    public static let teal   = ThemeAccent(id: "teal",   name: NSLocalizedString("teal", bundle: .main, value: "Teal", comment: "Accent color name"),   color: .systemTeal)

    public static let presets: [ThemeAccent] = [.blue, .purple, .pink, .red, .orange, .green, .teal]
}
