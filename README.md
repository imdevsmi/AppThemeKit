# AppThemeKit

Drop-in light / dark / system appearance and accent color selection for UIKit apps — with a ready-made settings screen.

- One line to wire up in your `SceneDelegate`
- Choices are persisted in `UserDefaults` and restored on launch
- Smooth cross-dissolve when the theme changes, applied to every window
- Built-in `ThemeSettingsViewController` (inset grouped table)
- Bring your own accent colors, or use the 7 built-in presets
- No dependencies

## Requirements

- iOS 13+
- Swift 5.5+

## Installation

### Swift Package Manager

In Xcode: **File ▸ Add Package Dependencies…** and enter:

```
https://github.com/imdevsmi/AppThemeKit.git
```

Or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/imdevsmi/AppThemeKit.git", from: "1.0.0")
]
```

## Usage

### 1. Register your window

```swift
// SceneDelegate.swift
import AppThemeKit

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = MainTabBarController()
    ThemeManager.shared.register(window: window)   // <- one line
    window.makeKeyAndVisible()
    self.window = window
}
```

### 2. Show the settings screen

```swift
navigationController?.pushViewController(ThemeSettingsViewController(), animated: true)
```

### Changing the theme in code

```swift
ThemeManager.shared.appearance = .dark
ThemeManager.shared.accentID = ThemeAccent.green.id
```

### Reacting to changes

The window's `tintColor` and `overrideUserInterfaceStyle` are updated automatically. If you have custom UI that needs to refresh, observe:

```swift
NotificationCenter.default.addObserver(
    forName: ThemeManager.didChangeNotification, object: nil, queue: .main
) { _ in
    // update your UI with ThemeManager.shared.accentColor
}
```

### Custom accent colors

```swift
let manager = ThemeManager(
    accents: [
        ThemeAccent(id: "brand", name: "Brand", color: UIColor(named: "Brand")!),
        .blue,
        .green
    ],
    defaultAccent: .blue
)
manager.register(window: window)

let settings = ThemeSettingsViewController(manager: manager)
```

## Localization

All user-facing strings are looked up in your app's **main bundle**, with English fallbacks. Add these keys to your `Localizable.strings` or String Catalog to translate them:

| Key | Default |
| --- | --- |
| `theme` | Theme |
| `appearance` | Appearance |
| `accent_color` | Accent Color |
| `system` / `light` / `dark` | System / Light / Dark |
| `blue` / `purple` / `pink` / `red` / `orange` / `green` / `teal` | Color names |

## License

AppThemeKit is available under the MIT license. See [LICENSE](LICENSE) for details.
