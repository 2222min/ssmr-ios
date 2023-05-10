import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.proxyFramework(
    name: "ThirdPartyLibManager",
    dependencies: [
        .external(name: "ReactorKit"),
        .external(name: "SnapKit"),
        .external(name: "Then"),
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "Moya"),
        .external(name: "RxMoya"),
        .external(name: "BonMot"),
        .external(name: "ReusableKit"),
        .external(name: "RxDataSources"),
        .external(name: "Swinject")
    ]
)

