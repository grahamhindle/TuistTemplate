// swift-tools-version: 6.0
@preconcurrency import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [
            "Inject": .framework,
            "InjectionNext": .framework,
            "ComposableArchitecture": .framework
        ]
    )
#endif

let package = Package(name: "TuistApp", dependencies: [
    .package(url: "https://github.com/httpswift/swifter", .upToNextMajor(from: "1.5.0")),
    .package(url: "https://github.com/krzysztofzablocki/Inject", .upToNextMajor(from: "1.5.2")),
    .package(url: "https://github.com/johnno1962/InjectionNext", .upToNextMajor(from: "1.3.0")),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.19.1"))

])
