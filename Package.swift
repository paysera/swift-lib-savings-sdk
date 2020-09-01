// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PayseraSavingsSDK",
    platforms: [.macOS(.v10_12), .iOS(.v10), .tvOS(.v9), .watchOS(.v2)],
    products: [
        .library(name: "PayseraSavingsSDK", targets: ["PayseraSavingsSDK"]),
    ],
    dependencies: [
        .package(name: "PayseraCommonSDK", url: "https://github.com/paysera/swift-lib-common-sdk", from: "3.0.1")
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
