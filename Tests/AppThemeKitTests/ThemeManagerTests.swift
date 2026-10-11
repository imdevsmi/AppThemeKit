import XCTest
@testable import AppThemeKit

final class ThemeManagerTests: XCTestCase {

    private func makeDefaults() -> UserDefaults {
        UserDefaults(suiteName: "AppThemeKitTests.\(UUID().uuidString)")!
    }

    func testDefaultsToSystemAndBlue() {
        let m = ThemeManager(defaults: makeDefaults())
        XCTAssertEqual(m.appearance, .system)
        XCTAssertEqual(m.accentID, "blue")
    }

    func testPersistsChoices() {
        let d = makeDefaults()
        let m = ThemeManager(defaults: d)
        m.appearance = .dark
        m.accentID = "pink"

        let reloaded = ThemeManager(defaults: d)
        XCTAssertEqual(reloaded.appearance, .dark)
        XCTAssertEqual(reloaded.accentID, "pink")
    }

    func testStyleMapping() {
        XCTAssertEqual(AppearanceMode.system.userInterfaceStyle, .unspecified)
        XCTAssertEqual(AppearanceMode.light.userInterfaceStyle, .light)
        XCTAssertEqual(AppearanceMode.dark.userInterfaceStyle, .dark)
    }

    func testRegisterAppliesSavedTheme() {
        let d = makeDefaults()
        let m = ThemeManager(defaults: d)
        m.appearance = .dark
        let window = UIWindow(frame: .zero)
        m.register(window: window)
        XCTAssertEqual(window.overrideUserInterfaceStyle, .dark)
    }

    func testUnknownAccentFallsBackToFirst() {
        let d = makeDefaults()
        d.set("nonexistent", forKey: "AppThemeKit.accent")
        let m = ThemeManager(defaults: d)
        XCTAssertEqual(m.accentColor, ThemeAccent.presets.first?.color)
    }
}
