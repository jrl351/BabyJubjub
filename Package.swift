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
            url: "",
            checksum: "2337f6262e573f691d0707b98057438acddbbe324711cdce9e21d68b2ded4ed5"),
    ]
)
