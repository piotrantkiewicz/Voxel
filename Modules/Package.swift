// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]),
        .library(
            name: "VoxelAuthentication",
            targets: ["VoxelAuthentication"]),
        .library(
            name: "VoxelContacts",
            targets: ["VoxelContacts"]),
        .library(
            name: "VoxelCore",
            targets: ["VoxelCore"]),
        .library(
            name: "VoxelLogin",
            targets: ["VoxelLogin"]),
        .library(
            name: "VoxelMocks",
            targets: ["VoxelMocks"]),
        .library(
            name: "VoxelSettings",
            targets: ["VoxelSettings"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "10.28.0"),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.4.3"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.9.1"))
    ],
    targets: [

        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "Lottie", package: "lottie-spm"),
                "SnapKit"
            ],
            resources: [
                .process("Resources")
            ]
        ),

        .target(
            name: "VoxelAuthentication",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
            ]
        ),

        .target(
            name: "VoxelContacts",
            dependencies: [
                "DesignSystem",
                "VoxelAuthentication",
                "VoxelCore",
                "VoxelSettings",
                "SDWebImage",
                "Swinject",
                "SnapKit",
                "PhoneNumberKit",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
            ]
        ),
        
        .testTarget(
            name: "VoxelContactsTests",
            dependencies: [
                "VoxelContacts",
                "Swinject",
            ]
        ),

        .target(name: "VoxelCore"),

        .target(
            name: "VoxelLogin",
            dependencies: [
                "DesignSystem",
                "VoxelAuthentication",
                "VoxelCore",
                "SnapKit",
                "PhoneNumberKit",
                "Swinject",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
            ],
            resources: [
                .process("Resources")
            ]
        ),

        .testTarget(
            name: "VoxelLoginTests",
            dependencies: [
                "VoxelLogin",
                "VoxelMocks"
            ]
        ),

        .target(
            name: "VoxelMocks",
            dependencies: ["VoxelAuthentication"]
        ),

        .target(
            name: "VoxelSettings",
            dependencies: [
                "DesignSystem",
                "VoxelAuthentication",
                "VoxelCore",
                "SnapKit",
                "SDWebImage",
                "Swinject",
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
            ],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
