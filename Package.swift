// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "generate-struct-macro",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "GenerateStruct",
            targets: ["GenerateStruct"]
        ),
        .executable(
            name: "GenerateStructClient",
            targets: ["GenerateStructClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.1"),
    ],
    targets: [
        .macro(
            name: "GenerateStructMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(name: "GenerateStruct", dependencies: ["GenerateStructMacros"]),
        .executableTarget(name: "GenerateStructClient", dependencies: ["GenerateStruct"]),
    ]
)
