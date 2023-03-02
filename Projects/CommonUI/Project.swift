//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2022/09/10.
//

import ProjectDescriptionHelpers
import ProjectDescription

private let projectName = "CommonUI"
private let iOSTargetVersion = "14.0"

let project = Project.framework(name: projectName,
                                dependencies: [
                                    .external(name: "SnapKit"),
                                    .external(name: "Then"),
                                    .external(name: "BonMot"),
                                    .external(name: "RxSwift"),
                                    .external(name: "RxCocoa")
                                ])
