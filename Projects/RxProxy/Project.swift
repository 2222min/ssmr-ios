//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/11.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "RxProxy"
let project = Project.proxyFramework(name: projectName,
                                dependencies: [
                                    .external(name: "RxSwift"),
                                    .external(name: "RxCocoa"),
                                ])
