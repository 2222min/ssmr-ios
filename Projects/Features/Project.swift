//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by mincheol on 2023/04/29.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

private let projectName = "Features"

let project = Project.framework(
    name: projectName,
    dependencies: [
        .project(target: "OnboardingPresentation", path: .relativeToFeature("Onboarding")),
        .project(target: "LoginPresentation", path: .relativeToFeature("Login")),
        .project(target: "LoginDomain", path: .relativeToFeature("Login")),
        .project(target: "SignUpPresentation", path: .relativeToFeature("SignUp")),
        .project(target: "SignUpDomain", path: .relativeToFeature("SignUp")),
        .project(target: "RegisterBusiness", path: .relativeToFeature("RegisterBusiness")),
        .project(target: "FindUserInfoPresentation", path: .relativeToFeature("FindUserInfo")),
        .project(target: "FindUserInfoDomain", path: .relativeToFeature("FindUserInfo")),
        .project(target: "RootPresentation", path: .relativeToFeature("Root")),
        .project(target: "RootDomain", path: .relativeToFeature("Root")),
        .project(target: "HomePresentation", path: .relativeToFeature("Home")),
        .project(target: "HomeDomain", path: "Home"),
        .project(target: "Notification", path: .relativeToFeature("Notification")),
        .project(target: "SearchPresentation", path: .relativeToFeature("Search")),
        .project(target: "SearchDomain", path: "Search")
        
    ]
)
