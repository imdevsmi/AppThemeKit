// swift-tools-version: 5.5
import PackageDescription

let package = Package(
    name: "AppThemeKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "AppThemeKit", targets: ["AppThemeKit"])
    ],
    targets: [
        .target(name: "AppThemeKit", resources: [.copy("PrivacyInfo.xcprivacy")]),
        .testTarget(name: "AppThemeKitTests", dependencies: ["AppThemeKit"])
    ]
)
