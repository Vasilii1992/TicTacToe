// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TicTacToe",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "TicTacToe",
            targets: ["TicTacToe"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "TicTacToe",
            dependencies: [],
            path: "Sources"
        )
    ]
)
