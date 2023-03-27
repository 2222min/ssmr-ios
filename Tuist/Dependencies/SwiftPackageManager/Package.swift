// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMinor(from: "3.2.0")),
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMinor(from: "5.0.1")),
        .package(url: "https://github.com/devxoul/Then", from: "3.0.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxNimble.git", from: "5.0.0"),
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0"),
        .package(url: "https://github.com/Rightpoint/BonMot", .upToNextMinor(from: "6.1.1")),
        .package(url: "https://github.com/2222min/ReusableKit", branch: "master"),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", from: "5.0.0"),
    ]
)