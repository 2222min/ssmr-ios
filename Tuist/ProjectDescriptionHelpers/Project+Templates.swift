import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/


extension Project {
    private static let organizationName = "team.io"
    
    public static func app(name: String,
                           infoPlist: String,
                           dependencies: [TargetDependency] = []) -> Project {
        let targets = makeAppTargets(name: name,
                                     infoPlist: infoPlist,
                                     dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }

    public static func frameworkWithDemoApp(name: String,
                                            infoPlist: [String: InfoPlist.Value] = [:],
                                            dependencies: [TargetDependency] = []) -> Project {
        var targets = makeFrameworkTargets(name: name,
                                           dependencies: dependencies)
        targets.append(contentsOf: makeAppTargets(name: "\(name)DemoApp",
                                                  infoPlist: infoPlist,
                                                  dependencies: [.target(name: name)]))

        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }

    public static func frameworkWithDemoApp(name: String,
                                            targets: [Target] = [],
                                            infoPlist: [String: InfoPlist.Value] = [:],
                                            demoDependencies: [TargetDependency] = []) -> Project {
        var targets = targets
        targets.append(contentsOf: makeAppTargets(name: "\(name)DemoApp",
                                                  infoPlist: infoPlist,
                                                  dependencies: demoDependencies))

        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
    
    public static func framework(name: String,
                                 dependencies: [TargetDependency] = []) -> Project {
        let targets = makeFrameworkTargets(name: name,
                                           dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
    
    public static func proxyFramework(name: String,
                                      dependencies: [TargetDependency] = []) -> Project {
        let targets = makeProxyFrameWork(name: name,
                                           dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
}

private extension Project {

    static func makeProxyFrameWork(name: String,
                                   dependencies: [TargetDependency] = []) -> [Target]{
        let sources = Target(name: name,
                             platform: .platform_ios,
                             product: .framework,
                             bundleId: "team.io.\(name)",
                             deploymentTarget: .targetVersion,
                             infoPlist: .default,
                             dependencies: dependencies)
        
        return [sources]
    }
    
    static func makeFrameworkTargets(name: String, dependencies: [TargetDependency] = []) -> [Target] {
        let sources = Target(name: name,
                             platform: .platform_ios,
                             product: .framework,
                             bundleId: "team.io.\(name)",
                             deploymentTarget: .targetVersion,
                             infoPlist: .default,
                             sources: ["Sources/**"],
                             resources: ["Resources/**"],
                             dependencies: dependencies)
        let tests = Target(name: "\(name)Tests",
                           platform: .platform_ios,
                           product: .unitTests,
                           bundleId: "team.io.\(name)Tests",
                           infoPlist: .default,
                           sources: ["Tests/**"],
                           resources: [],
                           dependencies: [
                            .target(name: name),
                            .external(name: "RxTest"),
                            .external(name: "RxNimble")
                           ])
        return [sources, tests]
    }

    static func makeAppTargets(name: String, infoPlist: [String: InfoPlist.Value] = [:], dependencies: [TargetDependency] = []) -> [Target] {

        let mainTarget = Target(
            name: name,
            platform: .platform_ios,
            product: .app,
            bundleId: "team.io.\(name)",
            deploymentTarget: .targetVersion,
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: .platform_ios,
            product: .unitTests,
            bundleId: "team.io.Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "\(name)"),
                .external(name: "RxTest"),
                .external(name: "RxNimble")
            ])
        return [mainTarget, testTarget]
    }

    static func makeAppTargets(name: String, infoPlist: String, dependencies: [TargetDependency] = []) -> [Target] {

        let mainTarget = Target(
            name: name,
            platform: .platform_ios,
            product: .app,
            bundleId: "team.io.\(name)",
            deploymentTarget: .targetVersion,
            infoPlist: InfoPlist(stringLiteral: infoPlist),
            sources: ["Sources/**"],
            resources: [
                .glob(pattern: .relativeToManifest("Resources/**"), excluding: ["Resources/*.plist"])
                
            ],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: .platform_ios,
            product: .unitTests,
            bundleId: "team.io.Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "\(name)"),
                .external(name: "RxTest"),
                .external(name: "RxNimble")
            ])
        return [mainTarget, testTarget]
    }
}

