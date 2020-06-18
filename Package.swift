// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "api.reidchatham.com-users",
    products: [
        .library(name: "api.reidchatham.com-users", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        // 🔵 Swift ORM (queries, models, relations, etc) built on Postgresql.
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc"),
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0-rc"),
//        .package(url: "https://github.com/vapor/crypto.git", from: "3.0.0"),

        .package(url: "https://github.com/vapor/jwt.git", from: "3.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/vapor-community/sendgrid-provider.git", from: "3.0.6"),
        .package(url: "https://github.com/vapor-community/lingo-vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/skelpo/JWTDataProvider.git", from: "1.0.0"),
        .package(url: "https://github.com/skelpo/JWTVapor.git", from: "0.13.0"),
        .package(url: "https://github.com/skelpo/SkelpoMiddleware.git", from: "1.4.0")
    ],
    targets: [
        .target(name: "App",
                dependencies: [
                    "Vapor",
                    "Leaf",
                    "Authentication",
                    "FluentPostgreSQL",
                    "JWT",
                    "CryptoSwift",
                    "SendGrid",
                    "LingoVapor",
                    "JWTDataProvider",
                    "JWTVapor",
                    "SkelpoMiddleware"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
