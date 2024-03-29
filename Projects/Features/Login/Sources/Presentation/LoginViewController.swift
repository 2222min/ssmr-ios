//
//  LoginViewController.swift
//  LoginDemoAppTests
//
//  Created by 정건호 on 2022/09/18.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import ReactorKit
import Core
import LoginDomain
import RootDomain
import FindUserInfoDomain
import SignUpDomain

public class LoginViewController: BaseViewController, ReactorKit.View, LoginViewControllerType {
    
    public typealias Reactor = LoginReactor
    
    public struct Dependency {
        let rootVC: RootViewControllerFactoryType
        let findUserInfoVC: FindUserInfoViewControllerFactoryType
        let signUpVC: SignUpViewControllerFactoryType
        public init(
            rootVC: RootViewControllerFactoryType,
            findUserInfoVC: FindUserInfoViewControllerFactoryType,
            signUpVC: SignUpViewControllerFactoryType
        ) {
            self.rootVC = rootVC
            self.findUserInfoVC = findUserInfoVC
            self.signUpVC = signUpVC
        }
    }
    
    // MARK: Constants
    private enum Constants {
        static let loginButtonText = "로그인".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        
        static let findInfoButtonText = "아이디/비밀번호찾기".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        
        static let dividerText = "|".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        
        static let signUpButtonText = "회원가입하기".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
    }
    // MARK: Properties
    
    // MARK: UI Properties
    private let loginLabel = UnderlineLabel().then {
        $0.labelText = "로그인"
    }
    
    private let idTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = "아이디".styled(
            typo: .Subhead,
            byAdding: [.color(CommonUIAsset.blackGrey.color)])
        $0.textField.attributedPlaceholder = NSAttributedString(
            string: "이메일 주소를 입력해 주세요.",
            attributes: [NSAttributedString.Key.foregroundColor : CommonUIAsset.whiteGrey.color]
        )
    }
    
    private let pwTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = "비밀번호".styled(
            typo: .Subhead,
            byAdding: [.color(CommonUIAsset.blackGrey.color)])
        $0.textField.attributedPlaceholder =  NSAttributedString(
            string: "비밀번호를 입력해 주세요.",
            attributes: [NSAttributedString.Key.foregroundColor : CommonUIAsset.whiteGrey.color]
        )
        $0.textField.isSecureTextEntry = true
    }
    
    private let loginButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.loginButtonText,
            for: .normal
        )
    }
    
    private let findInfoButton = UIButton().then {
        $0.setAttributedTitle(
            Constants.findInfoButtonText,
            for: .normal
        )
    }
    
    private let divider = UILabel().then {
        $0.attributedText = Constants.dividerText
    }
    
    private let signUpButton = UIButton().then {
        $0.setTitle("회원가입하기", for: .normal)
        $0.setAttributedTitle(
            Constants.signUpButtonText,
            for: .normal
        )
    }
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    
    public var dependency: Dependency
    
    // MARK: Initializing
    public init(
        reactor: Reactor,
        dependency: Dependency
    ) {
        defer {
            self.reactor = reactor
        }
        self.dependency = dependency
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }
    
    public override func configureUI() {
        super.configureUI()
        
        [
            self.findInfoButton,
            self.divider,
            self.signUpButton
        ]
            .forEach(self.bottomStackView.addArrangedSubview)
        
        [
            self.loginLabel,
            self.idTextField,
            self.pwTextField,
            self.loginButton,
            self.bottomStackView
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
    public override func setupConstraints() {
        super.setupConstraints()
        
        self.loginLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        self.idTextField.snp.makeConstraints {
            $0.top.equalTo(self.loginLabel.snp.bottom).offset(64)
            $0.height.equalTo(73)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        self.pwTextField.snp.makeConstraints {
            $0.top.equalTo(self.idTextField.snp.bottom).offset(32)
            $0.height.equalTo(73)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        self.loginButton.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(64)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        self.bottomStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.loginButton.snp.bottom).offset(40)
        }
    }
}

// MARK: ReactorBind
extension LoginViewController {
    public func bind(reactor: Reactor) {
        // 로그인 버튼
        self.bindAction(didTapCTAButton: reactor)
        self.bindState(showLoginFailView: reactor)
        // 아이디/비밀번호찾기 버튼
        self.bindAction(didTapFindInfoButton: reactor)
        self.bindState(didTapFindInfoButton: reactor)
        // 회원가입하기 버튼
        self.bindAction(didTapSignUpButton: reactor)
        self.bindState(didTapSignUpButton: reactor)
    }
}

// MARK: Action
extension LoginViewController {
    private func bindAction(didTapCTAButton reactor: Reactor) {
        self.loginButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapCTAButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    private func bindAction(didTapFindInfoButton reactor: Reactor) {
        self.findInfoButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapFindInfoButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    private func bindAction(didTapSignUpButton reactor: Reactor) {
        self.signUpButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapSignUpButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: State
extension LoginViewController {
    private func bindState(showLoginFailView reactor: Reactor) {
        reactor.state.map { $0.isShowLoginFailView }
            .filter { $0 }
            .asDriver(onErrorDriveWith: .empty())
            .drive { [weak self] _ in
                self?.showLoginFailView()
            }
            .disposed(by: self.disposeBag)
    }
    private func bindState(didTapFindInfoButton reactor: Reactor) {
        reactor.state.map { $0.isShowFindInfoView }
            .filter { $0 }
            .asDriver(onErrorDriveWith: .empty())
            .drive { [weak self] _ in
                self?.showFindUserInfoView()
            }
            .disposed(by: self.disposeBag)
    }
    private func bindState(didTapSignUpButton reactor: Reactor) {
        reactor.state.map { $0.isShowSignUpView }
            .filter { $0 }
            .asDriver(onErrorDriveWith: .empty())
            .drive { [weak self] _ in
                self?.showSignUpView()
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: Func
extension LoginViewController {
    func showLoginFailView() {
        let loginFailView = LoginFailViewController()
        loginFailView.modalTransitionStyle = .crossDissolve
        loginFailView.modalPresentationStyle = .overCurrentContext
        self.present(loginFailView, animated: true)
    }
    func showFindUserInfoView() {
        let findUserInfoView = dependency.findUserInfoVC.create(
            payload: .init(paramA: "")
        )
        self.navigationController?.pushViewController(findUserInfoView, animated: true)
    }
    func showSignUpView() {
        let signUpView = dependency.signUpVC.create(
            payload: .init(paramA: "")
        )
        self.navigationController?.pushViewController(signUpView, animated: true)
    }
}
