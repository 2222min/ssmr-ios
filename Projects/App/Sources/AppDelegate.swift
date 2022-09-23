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
        sleep(2) // delay 2 seconds
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let onboardingVC = OnboardingViewController.create() ?? UIViewController()
        
        window?.rootViewController = onboardingVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

