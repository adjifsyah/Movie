// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Movie",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Movie",
            targets: ["Movie"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0")),
        .package(url: "https://github.com/adjifsyah/Core.git", .upToNextMajor(from: "1.0.22")),
//        .package(path: "../Core")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Movie",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Core", package: "Core")
//                "Core"
            ]
        ),
        .testTarget(
            name: "MovieTests",
            dependencies: ["Movie"]),
    ]
)
