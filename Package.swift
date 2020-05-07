swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ALVersionControl",
    products: [
        .library(
            name: "ALVersionControl",
            targets: ["ALVersionControl"]),
    ],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ALVersionControl",
            dependencies: []),
        .testTarget(
            name: "ALVersionControlTests",
            dependencies: ["ALVersionControl"]),
    ]
)
