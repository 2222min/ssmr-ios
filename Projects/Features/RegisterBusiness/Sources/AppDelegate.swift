//
//  AppDelegate.swift
//
//  Created by 정건호 on 2022/11/06.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import RegisterBusinessDomain
import DI

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let factory = dependencyInjectionContainer.resolve(RegiBusinessViewControllerFactoryType.self)!
        let viewController = factory.create(payload: .init(paramA: ""))
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
}
