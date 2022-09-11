//
//  AppDelegate.swift
//  App
//
//  Created by mincheol on 2022/09/10.
//  Copyright © 2022 cocaine.io. All rights reserved.
//

import CommonUI
import Onboarding

import UIKit
import SignUp

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = MainTabBarController()
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.isTranslucent = false
        
        let onboardingVC = OnboardingViewController.create() ?? UIViewController()
        onboardingVC.tabBarItem = UITabBarItem(title: "onboarding", image: CommonUIAsset.homeIcon.image, tag: 0)
        
        let loginVC = LoginViewController.create() ?? UIViewController()
        loginVC.tabBarItem = UITabBarItem(title: "Login", image: CommonUIAsset.homeIcon.image, tag: 0)
        
        tabBarController.setViewControllers([onboardingVC,loginVC], animated: false)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

