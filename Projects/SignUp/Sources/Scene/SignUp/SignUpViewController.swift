//
//  SignUpViewController.swift
//  SignUpTests
//
//  Created by 정건호 on 2022/09/28.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI

class SignUpViewController: BaseViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let guideLabelText = "로그인에 사용할 이메일주소와\n비밀번호를 입력해 주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        
        static let duplicationButtonText = "중복확인".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        
        static let nextButtonText = "다음".styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
    }
    // MARK: Properties
    
    // MARK: UI Properties
    
    private let signUpLabel = UnderlineLabel().then {
        $0.labelText = "회원가입"
    }
    
    private let guideLabel = UILabel().then {
        $0.attributedText = Constants.guideLabelText
        $0.numberOfLines = 0
    }
    
    private let idTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = "아이디".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.blackGrey.color)])
        $0.textField.attributedPlaceholder = NSAttributedString(
            string: "아이디를 입력해 주세요",
            attributes: [NSAttributedString.Key.foregroundColor : CommonUIAsset.whiteGrey.color]
        )
    }
    
    private let duplicationButton = UIButton().then {
        $0.setAttributedTitle(Constants.duplicationButtonText, for: .normal)
        $0.backgroundColor = CommonUIAsset.grey.color
        $0.layer.cornerRadius = 12
    }
    
    private let pwTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = "비밀번호".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.blackGrey.color)])
        $0.textField.attributedPlaceholder =  NSAttributedString(
            string: "비밀번호를 입력해 주세요.",
            attributes: [NSAttributedString.Key.foregroundColor : CommonUIAsset.whiteGrey.color]
        )
        $0.textField.isSecureTextEntry = true
    }
    
    private let eyeImageOfPW = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.eyeImage)
    }
    
    private let pwCheckTextField = UnderlineTextField().then {
        $0.textField.attributedPlaceholder =  NSAttributedString(
            string: "비밀번호를 재입력해 주세요.",
            attributes: [NSAttributedString.Key.foregroundColor : CommonUIAsset.whiteGrey.color]
        )
        $0.textField.isSecureTextEntry = true
    }
    
    private let eyeImageOfPWCheck = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.eyeImage)
    }
    
    private let nextButton = TCAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        self.view.addSubview(signUpLabel)
        self.view.addSubview(guideLabel)
        self.view.addSubview(idTextField)
        self.view.addSubview(duplicationButton)
        self.view.addSubview(pwTextField)
        self.view.addSubview(eyeImageOfPW)
        self.view.addSubview(pwCheckTextField)
        self.view.addSubview(eyeImageOfPWCheck)
        self.view.addSubview(nextButton)
    }
    
    override func setupConstraints() {
        self.signUpLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        self.guideLabel.snp.makeConstraints {
            $0.top.equalTo(self.signUpLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.idTextField.snp.makeConstraints {
            $0.top.equalTo(self.guideLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        // TODO: 중복 버튼 상하 간격
        self.duplicationButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.idTextField.textField)
            $0.trailing.equalTo(self.idTextField.snp.trailing)
            $0.width.equalTo(72)
        }
        self.pwTextField.snp.makeConstraints {
            $0.top.equalTo(self.idTextField.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.eyeImageOfPW.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.trailing.equalTo(self.pwTextField.snp.trailing)
            $0.top.bottom.equalTo(self.pwTextField.textField)
        }
        self.pwCheckTextField.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.eyeImageOfPWCheck.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.trailing.equalTo(self.pwCheckTextField.snp.trailing)
            $0.top.bottom.equalTo(self.pwCheckTextField.textField)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
