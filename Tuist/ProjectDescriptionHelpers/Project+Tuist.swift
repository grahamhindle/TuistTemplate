import ProjectDescription

public enum Dependency {
    case module(Module)
    case package(String)

    var targetDependency: TargetDependency {
        switch self {
        case let .module(module): TargetDependency.project(target: module.name, path: "../\(module.name)")
        case let .package(package): TargetDependency.external(name: package)
        }
    }
}

public enum Module: String {
    case app
    case kit

    var product: Product {
        switch self {
        case .app:
            return .app
        case .kit:
            return .framework
        }
    }

    var name: String {
        switch self {
        case .app: Constants.appName
        case .kit: Constants.appName + "Kit"
        default: Constants.appName + rawValue
        }
    }

    var dependencies: [Dependency] {
        switch self {
        case .app: [
                .package("Inject"),
                .package("InjectionNext"),
                .package("ComposableArchitecture")
            ]
        case .kit: []
        }
    }

    var settings: Settings {
        switch self {
        case .app:
            return .settings(
                debug: [
                    "SWIFT_COMPILATION_MODE": "singlefile",
                    "EMIT_FRONTEND_COMMAND_LINES": "true",
                    "OTHER_SWIFT_FLAGS": ["-Xfrontend", "-serialize-debugging-options"],
                    "OTHER_LDFLAGS": [
                        "$(inherited)",

                        "-Xlinker",
                        "-interposable"
                    ],
                    "INJECTION_STANDALONE": "true",
                    "ENABLE_USER_SCRIPT_SANDBOXING": "true",
                    "ENABLE_MODULE_VERIFIER": "true"
                ]
            )
        case .kit:
            return .settings(
                base: [
                    "ENABLE_USER_SCRIPT_SANDBOXING": "true",
                    "ENABLE_MODULE_VERIFIER": "true"
                ]
            )
        }
    }

    var hasTests: Bool {
        switch self {
        case .app: return true
        case .kit: return true
        }
    }

    var resources: ResourceFileElements {
        switch self {
        case .app: return ["./Resources/**/**"]
        case .kit: return []
        }
    }
}

public extension Project {
    static func tuist(module: Module) -> Project {
        let dependencies = module.dependencies.map(\.targetDependency)
        var targets: [Target] = [
            .target(name: module.name,
                    destinations: .iOS,
                    product: module.product,
                    bundleId: "com.grahamhindle.\(module.name)",
                    infoPlist: .extendingDefault(
                        with: [
                            "UILaunchScreen": [
                                "UIColorName": "",
                                "UIImageName": ""
                            ]
                        ]
                    ),
                    sources: [
                        "./Sources/**"
                    ],
                    resources: module.resources,
                    dependencies: dependencies,
                    settings: module.settings)
        ]

        if module.hasTests {
            targets.append(
                .target(
                    name: "\(module.name)Tests",
                    // environment: module.environment,
                    destinations: .iOS,

                    product: .unitTests,
                    bundleId: "com.grahamhindle.\(module.name)Tests",
                    // deploymentTarget: .iOS("18.0"),
                    infoPlist: .extendingDefault(
                        with: [
                            "UILaunchScreen": "LaunchScreen.storyboard"
                        ]
                    ),
                    sources: [
                        "./Tests/**"
                    ],
                    resources: module.resources,
                    dependencies: dependencies + [.target(name: module.name)],
                    settings: module.settings
                )
            )
        }
        return Project(name: module.name, targets: targets)
    }
}
