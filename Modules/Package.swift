// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
        .library(
            name: "VoxelAuthentication",
            targets: ["VoxelAuthentication"]
        ),
        .library(
            name: "VoxelLogin",
            targets: ["VoxelLogin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.29.0")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "VoxelAuthentication",
            dependencies: [
                .product(
                    name: "FirebaseAuth",
                    package: "firebase-ios-sdk"
                )
            ]
        ),
        .target(
            name: "VoxelLogin",
            dependencies: [
                "DesignSystem",
                "VoxelAuthentication",
                "PhoneNumberKit",
                "SnapKit"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
