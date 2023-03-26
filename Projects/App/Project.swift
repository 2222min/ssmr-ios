//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2022/09/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "App"
private let iOSTargetVersion = "14.0"

let infoPlistPath: String = "Resources/App.plist"
let loginTargets: [TargetDependency]  = Target.LoginTargets.allCases.map { .project(target: $0.rawValue, path: .relativeToManifest("../Login"))}
let project = Project.app(name: projectName,
                          infoPlist: infoPlistPath,
                          dependencies: [
                            .external(name: "ReactorKit"),
                            .external(name: "RxSwift"),
                            .external(name: "RxCocoa"),
                            .external(name: "Moya"),
                            .external(name: "RxMoya"),
                            .external(name: "BonMot"),
                            .project(target: "Onboarding", path: .relativeToCurrentFile("../Onboarding")),
                            .project(target: "SignUp", path: .relativeToCurrentFile("../SignUp")),
                            .project(target: "CommonUI", path: .relativeToCurrentFile("../CommonUI")),
                            .project(target: "RegisterBusiness", path: .relativeToCurrentFile("../RegisterBusiness")),
                            .project(target: "Notification", path:
                                    .relativeToCurrentFile("../Notification"))
                            
                          ] + loginTargets
)
