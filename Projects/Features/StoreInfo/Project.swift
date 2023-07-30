import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "StoreInfo"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .StoreInfoTargets.presentation.target,
                                            .StoreInfoTargets.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.StoreInfoTargets.allCases.map { .target(name: $0.rawValue)}
)

