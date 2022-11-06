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

let project = Project.app(name: projectName,
                          platform: .iOS,
                          iOSTargetVersion: iOSTargetVersion,
                          infoPlist: infoPlistPath,
                          dependencies: [
                            .external(name: "SnapKit"),
                            .external(name: "Then"),
                            .external(name: "ReactorKit"),
                            .external(name: "RxSwift"),
                            .external(name: "RxCocoa"),
                            .external(name: "Moya"),
                            .external(name: "RxMoya"),
                            .external(name: "BonMot"),
                            .project(target: "Onboarding", path: .relativeToCurrentFile("../Onboarding")),
                            .project(target: "SignUp", path: .relativeToCurrentFile("../SignUp")),
                            .project(target: "CommonUI", path: .relativeToCurrentFile("../CommonUI")),
                            .project(target: "Login", path: .relativeToCurrentFile("../Login")),
                            .project(target: "RegisterBusiness", path: .relativeToCurrentFile("../RegisterBusiness"))
                          ])
