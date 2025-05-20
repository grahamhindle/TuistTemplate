import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/httpswift/swifter", requirement: .upToNextMajor(from: "1.5.0")),
        .remote(url: "https://github.com/krzysztofzablocki/Inject", requirement: .upToNextMajor(from: "1.2.5")), // Assuming a version, please adjust if needed
        .remote(url: "https://github.com/johnno1962/InjectionNext", requirement: .upToNextMajor(from: "1.0.0")), // Assuming a version, please adjust if needed
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.0.0")), // Assuming a version, please adjust
        .remote(url: "https://github.com/apple/swift-testing", requirement: .upToNextMajor(from: "0.6.0")) // Or your desired version
    ],
    platforms: [.iOS]
)
