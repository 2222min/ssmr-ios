//
//  AppDelegate.swift
//  FindUserInfo
//
//  Created by 이민철 on 2022/09/4.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import FindUserInfoDomain
import DI

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // TODO: 나중에 바꾸기
        let factory = dependencyInjectionContainer.resolve(FindUserInfoViewControllerFactoryType.self)!
        let viewController = factory.create(payload: .init(paramA: ""))
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
}
