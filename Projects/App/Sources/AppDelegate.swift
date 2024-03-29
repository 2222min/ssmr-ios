//
//  AppDelegate.swift
//  App
//
//  Created by mincheol on 2022/09/10.
//  Copyright © 2022 cocaine.io. All rights reserved.
//

import CommonUI
import OnboardingPresentation

import UIKit

import DI
import LoginDomain
import LoginPresentation
import FindUserInfoDomain
import FindUserInfoPresentation
import SignUpDomain
import SignUpPresentation
import RegisterBusinessDomain
import RegisterBusinessPresentation
import RootDomain
import RootPresentation

import Core


@main class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        sleep(2) // delay 2 seconds
        window = UIWindow(frame: UIScreen.main.bounds)
        Injection().makeInjection()
       
        let onboardingVC = OnboardingViewController.create(dependency: .init(loginVC: dependencyInjectionContainer.resolve(LoginViewControllerFactoryType.self)!))!
        
        let rootViewController =  UINavigationController(rootViewController: onboardingVC)
        rootViewController.navigationBar.isHidden = true
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
}

struct Injection {
    func makeInjection() {
        // MARK: Networking
        dependencyInjectionContainer.register(Networking.self) { _ in
            return Networking()
        }.inObjectScope(.container)
        
        // MARK: LoginUseCaseProtocol
        dependencyInjectionContainer.register(LoginUseCaseProtocol.self) { r in
            return LoginUseCase(networking: r.resolve(Networking.self)!)
        }.inObjectScope(.container)
        
        // MARK: LoginViewControllerFactoryType
        dependencyInjectionContainer.register(LoginViewControllerFactoryType.self) { _ in
            // 추상 뷰컨트롤러 팩토리 생성 시 `factoryClosure` 주입
            LoginViewControllerFactoryType { payload in
                return LoginViewController(
                    reactor: LoginReactor(effector: dependencyInjectionContainer.resolve(LoginUseCaseProtocol.self)!),
                    dependency: .init(
                        rootVC: dependencyInjectionContainer.resolve(RootViewControllerFactoryType.self)!,
                        findUserInfoVC: dependencyInjectionContainer.resolve(FindUserInfoViewControllerFactoryType.self)!,
                        signUpVC: dependencyInjectionContainer.resolve(SignUpViewControllerFactoryType.self)!
                    )
                )
            }
        }
        // MARK: RootViewControllerFactoryType
        dependencyInjectionContainer.register(RootViewControllerFactoryType.self) { _ in
            RootViewControllerFactoryType { payload in
                return RootViewController(reactor: RootReactor())
            }
        }
        
        // MARK: FindUserInfoControllerFactoryType
        dependencyInjectionContainer.register(FindUserInfoViewControllerFactoryType.self) { _ in
            FindUserInfoViewControllerFactoryType { payload in
                return FindUserInfoViewController(reactor: FindUserInfoReactor(), dependency: .init(loginVC: dependencyInjectionContainer.resolve(LoginViewControllerFactoryType.self)!))
            }
        }
        
        // MARK: SignUpViewControllerFactoryType
        dependencyInjectionContainer.register(SignUpViewControllerFactoryType.self) { _ in
            SignUpViewControllerFactoryType { payload in
                return SignUpViewController(reactor: SignUpReactor(), dependency: .init(loginVC: dependencyInjectionContainer.resolve(LoginViewControllerFactoryType.self)!))
            }
        }
        
        // MARK: RegisterBusinessViewControllerFactoryType
        dependencyInjectionContainer.register(RegiBusinessViewControllerFactoryType.self) { _ in
            RegiBusinessViewControllerFactoryType { payload in
                return RegiBusinessNumberViewController(dependency: .init(signUpVC: dependencyInjectionContainer.resolve(SignUpViewControllerFactoryType.self)!))
            }
        }
    }
}

