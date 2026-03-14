// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "HHARCoreKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "HHARCoreKit",
            targets: ["HHARCoreKit"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "HHARCoreKit",
            path: "HHARCoreKit.xcframework"
        )
    ]
)
