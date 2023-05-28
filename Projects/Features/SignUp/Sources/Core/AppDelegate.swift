//
//  AppDelegate.swift
//  SignUp
//
//  Created by mincheol on 2022/09/11.
//  Copyright © 2022 cocaine.io. All rights reserved.
//

import UIKit
import SignUpDomain
import DI

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let factory = dependencyInjectionContainer.resolve(SignUpViewControllerFactoryType.self)!
        let viewController = factory.create(payload: .init(paramA: ""))
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
}
