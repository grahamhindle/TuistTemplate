import ProjectDescription

//let name = Module.name
//print(name)

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

public enum Module {
    case app(String?, [TargetDependency] = [])
    case kit(String?, [TargetDependency] = [])
    
    var product: Product {
        switch self {
        case .app: return .app
        case .kit: return .framework
        }
    }

    var name: String {
        switch self {
        case .app(let customName, _):
            return customName ?? "TuistApp"
        case .kit(let customName, _):
            return customName.map { "\($0)" } ?? "TuistAppFramework"
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

    var targetDependencies: [TargetDependency] {
        switch self {
        case .app(_, let deps), .kit(_, let deps):
            return deps
        }
    }

    var settings: Settings {
        switch self {
        case .app, .kit:
            return .settings(
                debug: [
                    "SWIFT_COMPILATION_MODE": "singlefile",
                    "EMIT_FRONTEND_COMMAND_LINES": "true",
                    "OTHER_SWIFT_FLAGS": ["-Xfrontend", "-serialize-debugging-options"],
                    "OTHER_LDFLAGS": [
                        "$(inherited)",
                        "-ObjC",
                        "-Xlinker",
                        "-interposable"
                    ],
                    "INJECTION_STANDALONE": "true",
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
        let dependencies = module.dependencies.map(\.targetDependency) + module.targetDependencies
        var targets: [Target] = [
            .target(name: module.name,
                    destinations: .iOS,
                    product: module.product,
                    bundleId: "com.grahamhindle.\(module.name)",
                    infoPlist: .extendingDefault(
                        with: [
                            "UILaunchScreen": ["UIImageName": "LaunchImage",
                           "UIColorName": "LaunchBackground"],
                        ]
                    ),
                    sources: [
                        "./Sources/**",
                        "./Sources/**/**"
                    ],
                    resources: module.resources,
                    dependencies: dependencies,
                    settings: module.settings)
        ]

        if module.hasTests {
            targets.append(
                .target(
                    name: "\(module.name)Tests",
                    destinations: .iOS,
                    product: .unitTests,
                    bundleId: "com.grahamhindle.\(module.name)Tests",
                    infoPlist: .extendingDefault(
                        with: [
                            "UILaunchScreen": ["Image Name": "LaunchImage",
                           "BackgroundColor": "LaunchBackground",
                           ]
                        ]
                        
                    ),
                    sources: [
                        "./Tests/**",
                        "./Tests/**/**"
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
