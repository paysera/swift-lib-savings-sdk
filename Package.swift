// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PayseraSavingsSDK",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "PayseraSavingsSDK", targets: ["PayseraSavingsSDK"]),
    ],
    dependencies: [
        .package(
            name: "PayseraCommonSDK",
            url: "https://github.com/paysera/swift-lib-common-sdk",
            .exact("4.2.0")
        )
    ],
    targets: [
        .target(
            name: "PayseraSavingsSDK",
            dependencies: ["PayseraCommonSDK"]
        ),
        .testTarget(
            name: "PayseraSavingsSDKTests",
            dependencies: ["PayseraSavingsSDK"]
        ),
    ]
)
