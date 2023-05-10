//
//  AppDelegate.swift
//  FindUserInfo
//
//  Created by 이민철 on 2022/09/4.
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
        
        // TODO: 나중에 바꾸기
        let viewController = FindUserInfoViewController.create()
        let rootViewController =  UINavigationController(rootViewController: viewController)
        rootViewController.navigationBar.isHidden = true
        window?.rootViewController = rootViewController
        
//        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
}
