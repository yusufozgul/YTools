// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YTools",
    platforms: [
            .iOS(.v13)
    ],
    products: [
        .library(
            name: "YTools",
            targets: ["YTools-Swift", "YNetworkBase", "YImageKit"]),
    ],
    targets: [
        .target(
            name: "YTools-Swift",
            dependencies: []
        ),
        .target(
            name: "YNetworkBase",
            dependencies: []
        ),
        .target(
            name: "YImageKit",
            dependencies: []
        ),
    ]
)
