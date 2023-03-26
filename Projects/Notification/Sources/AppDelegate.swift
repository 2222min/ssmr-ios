//
//  AppDelegate.swift
//  NotificationDemoApp
//
//  Created by 정건호 on 2023/03/26.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = NotificationViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
}
