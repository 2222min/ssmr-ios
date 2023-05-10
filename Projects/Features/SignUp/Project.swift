import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "SignUp"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           targets: [
                                            .SignUpTargets.presentation.target,
                                            .SignUpTargets.domain.target
                                           ],
                                           infoPlist: infoPlist,
                                           demoDependencies: Target.SignUpTargets.allCases.map { .target(name: $0.rawValue)}
)
