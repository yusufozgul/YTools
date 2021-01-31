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
            name: "YTools-Swift",
            targets: ["YTools-Swift"]),
        .library(
            name: "YNetworkKit",
            targets: ["YNetworkKit"]),
        .library(
            name: "YImageKit",
            targets: ["YImageKit"]),
    ],
    targets: [
        .target(
            name: "YTools-Swift",
            dependencies: []
        ),
        .target(
            name: "YNetworkKit",
            dependencies: []
        ),
        .target(
            name: "YImageKit",
            dependencies: []
        ),
    ]
)
