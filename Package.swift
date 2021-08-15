// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LaunchCounter",
    platforms: [
        .macOS(.v10_11),
        .iOS(.v9),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "LaunchCounter",
            targets: ["LaunchCounter"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LaunchCounter",
            dependencies: []),
        .testTarget(
            name: "LaunchCounterTests",
            dependencies: ["LaunchCounter"]),
    ],
    swiftLanguageVersions: [.v5]
)
