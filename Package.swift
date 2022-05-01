// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Nanoleaf",
    platforms: [
        .iOS("15.0"),
        .macOS("12.0")
    ],
    products: [
        .library(
            name: "Nanoleaf",
            targets: ["Nanoleaf"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/reddavis/Asynchrone", from: "0.16.1")
    ],
    targets: [
        .target(
            name: "Nanoleaf",
            dependencies: ["Asynchrone"],
            path: "Nanoleaf",
            exclude: []
        ),
        .testTarget(
            name: "NanoleafTests",
            dependencies: ["Nanoleaf"],
            path: "NanoleafTests"
        )
    ]
)
