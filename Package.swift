// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "aws-s3-lambda-handler",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "S3Handler", targets: ["S3Handler"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime", branch: "main"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-events", branch: "main"),
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.8.1"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
    ],
    targets: [
        .executableTarget(
            name: "S3Handler",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-events"),
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
            ],
            exclude: [
                "resources.png",
            ]
        ),
    ]
)
