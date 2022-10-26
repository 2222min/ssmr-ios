//
//  AppDelegate.swift
//  SignUp
//
//  Created by mincheol on 2022/09/11.
//  Copyright © 2022 cocaine.io. All rights reserved.
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = SignUpViewController.create()
        
        // TODO: 나중에 바꾸기
        let rootViewController =  UINavigationController(rootViewController: viewController)
        window?.rootViewController = rootViewController
        
//        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
}
