//
//  Templates.swift
//  UtilityPlugin
//
//  Created by mincheol on 2023/05/10.
//

import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Framework template",
    attributes: [nameAttribute, .optional("platform", default: "iOS")],
    items: [
        [
            .file(path: "\(nameAttribute)/Sources/Core/AppDelegate.swift",
                  templatePath: "contents_example_appdelegate.stencil"),
            .file(path: "\(nameAttribute)/Resources/Presentation/Assets.xcassets/contents.json",
                  templatePath: "contents_xcassets.stencil"),
            .string(path: "\(nameAttribute)/Resources/Domain/dummy.txt",
                    contents: "_"),
            .string(path: "\(nameAttribute)/Resources/Data/dummy.txt",
                    contents: "_"),
        ],
        [
            .file(path: "\(nameAttribute)/Sources/Domain/\(nameAttribute).swift",
                  templatePath: "contents_framework_source.stencil"),
            .file(path: "\(nameAttribute)/Sources/Data/\(nameAttribute).swift",
                  templatePath: "contents_framework_source.stencil"),
            .file(path: "\(nameAttribute)/Sources/Presentation/\(nameAttribute).swift",
                  templatePath: "contents_framework_source.stencil"),
        ],
        [
            .file(path: "\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
                  templatePath: "contents_tests_xctest.stencil"),
//            .file(path: "\(nameAttribute)/Tests/\(nameAttribute)TestSpec.swift",
//                  templatePath: "contents_tests_quick_nimble.stencil"),
//            .string(path: "\(nameAttribute)/Tests/Resources/dummy.txt",
//                    contents: "_"),
        ],
        [
//            .file(path: "\(nameAttribute)/Testing/Sources/\(nameAttribute).swift",
//                  templatePath: "contents_testing.stencil"),
//            .string(path: "\(nameAttribute)/Testing/Resources/dummy.txt",
//                    contents: "_"),
        ],
        [
            .file(path: "\(nameAttribute)/Project.swift",
                  templatePath: "contents_project.stencil"),
        ]
    ].flatMap { $0 }
)
