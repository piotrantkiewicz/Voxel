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
            name: "VoxelCore",
            targets: ["VoxelCore"]
        ),
        .library(
            name: "VoxelLogin",
            targets: ["VoxelLogin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.29.0"),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.0"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
        
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(
                    name: "Lottie",
                    package: "lottie-spm"
                ),
                "SnapKit"
            ],
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
        .target(name: "VoxelCore"),
        .target(
            name: "VoxelLogin",
            dependencies: [
                "DesignSystem",
                "VoxelAuthentication",
                "VoxelCore",
                "PhoneNumberKit",
                "SnapKit"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
