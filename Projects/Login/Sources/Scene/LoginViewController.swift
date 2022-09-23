//
//  LoginViewController.swift
//  LoginDemoAppTests
//
//  Created by 정건호 on 2022/09/18.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI

class LoginViewController: BaseViewController {
    
    // MARK: Constants
    private enum Constants {
        static let loginButtonText = "로그인".styled(
            typo: .text17NeoBold,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        
        static let findInfoButtonText = "아이디/비밀번호찾기".styled(
            typo: .text12NeoNormal,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        
        static let dividerText = "|".styled(
            typo: .text12NeoNormal,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        
        static let signUpButtonText = "회원가입하기".styled(
            typo: .text12NeoNormal,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
    }
    
    // MARK: Properties
    
    // MARK: UI Properties
    private let loginLabel = UnderlineLabel().then {
        $0.labelText = "로그인"
    }
    
    private let idLabel = UILabel().then {
        $0.attributedText = "아이디".styled(
            typo: .text20NeoNormal,
            byAdding: [.color(CommonUIAsset.blackGrey.color)])
    }
    
    private let pwLabel = UILabel().then {
        $0.attributedText = "비밀번호".styled(
            typo: .text20NeoNormal,
            byAdding: [.color(CommonUIAsset.blackGrey.color)])
    }
    
    private let idTextField = UnderlineTextField().then {
        $0.textField.attributedPlaceholder = NSAttributedString(
            string: "이메일 주소를 입력해 주세요.",
            attributes: [NSAttributedString.Key.foregroundColor : CommonUIAsset.whiteGrey.color]
        )
    }
    
    private let pwTextField = UnderlineTextField().then {
        $0.textField.attributedPlaceholder =  NSAttributedString(
            string: "비밀번호를 입력해 주세요.",
            attributes: [NSAttributedString.Key.foregroundColor : CommonUIAsset.whiteGrey.color]
        )
        $0.textField.isSecureTextEntry = true
    }
    
    private let loginButton = TCAButton().then {
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
    
    override func configureUI() {
        super.configureUI()
        
        [
            self.findInfoButton,
            self.divider,
            self.signUpButton
        ]
            .forEach(self.bottomStackView.addArrangedSubview)
        
        [
            self.loginLabel,
            self.idLabel,
            self.idTextField,
            self.pwLabel,
            self.pwTextField,
            self.loginButton,
            self.bottomStackView
        ]
            .forEach(self.view.addSubview)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.loginLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        self.idLabel.snp.makeConstraints {
            $0.top.equalTo(self.loginLabel.snp.bottom).offset(64)
            $0.leading.equalToSuperview().offset(16)
        }
        self.idTextField.snp.makeConstraints {
            $0.top.equalTo(self.idLabel.snp.bottom).offset(16)
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        self.pwLabel.snp.makeConstraints {
            $0.top.equalTo(self.idTextField.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        self.pwTextField.snp.makeConstraints {
            $0.top.equalTo(self.pwLabel.snp.bottom).offset(16)
            $0.height.equalTo(24)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.rx.tap
            .subscribe(with: self) { owner, _ in
                let loginFailVC = LoginFailViewController()
                loginFailVC.modalPresentationStyle = .overCurrentContext
                loginFailVC.modalTransitionStyle = .crossDissolve
                owner.present(loginFailVC, animated: true)
            }.disposed(by: disposeBag)
    }
}