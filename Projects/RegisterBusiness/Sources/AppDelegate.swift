//
//  AppDelegate.swift
//
//  Created by 정건호 on 2022/11/06.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = RegiBusinessOneViewController()
        
        // TODO: 나중에 바꾸기
        let rootViewController =  UINavigationController(rootViewController: viewController)
        window?.rootViewController = rootViewController
        
//        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
}
