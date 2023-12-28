// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BabyJubjub",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BabyJubjub",
            targets: ["BabyJubjub"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(
            name: "BabyJubjub",
            url: "https://github.com/jrl351/libbabyjubjub/releases/download/v0.0.2/libbabyjubjub.zip",
            checksum: "cb0eb1646c54307700cce98aa610c720f83d08722dc4b53682580cf1e9328c0a"),
    ]
)
