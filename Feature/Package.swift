// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Common", targets: ["Common"]),
        .library(name: "Series", targets: ["Series"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.49.0"),
        .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: []),
        .target(
            name: "Series",
            dependencies: [
                "Common",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]),
    ]
)
