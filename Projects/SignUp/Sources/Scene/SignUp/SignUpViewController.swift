//
//  SignUpViewController.swift
//  SignUpTests
//
//  Created by 정건호 on 2022/09/28.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxCocoa

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
        static let availableIDLabelText = "사용할 수 있는 아이디예요!".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let unavailableIDLabelText = "이미 존재하는 아이디예요!".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mRed.color)]
        )
        static let checkCapitalLetterText = "대소문자".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkSpecialLetterText = "특수문자".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkLetterLengthText = "8-20글자 이내".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkPasswordText = "비밀번호 일치".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
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
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
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
    
    private let eyeImageOfPW = UIButton().then {
        $0.setBackgroundImage(UIImage(asset: CommonUIAsset.eyeOffImage), for: .normal)
        $0.setBackgroundImage(UIImage(asset: CommonUIAsset.eyeOnImage), for: .selected)
    }
    
    private let pwCheckTextField = UnderlineTextField().then {
        $0.textField.attributedPlaceholder =  NSAttributedString(
            string: "비밀번호를 재입력해 주세요.",
            attributes: [NSAttributedString.Key.foregroundColor : CommonUIAsset.whiteGrey.color]
        )
        $0.textField.isSecureTextEntry = true
    }
    
    private let eyeImageOfPWCheck = UIButton().then {
        $0.setBackgroundImage(UIImage(asset: CommonUIAsset.eyeOffImage), for: .normal)
        $0.setBackgroundImage(UIImage(asset: CommonUIAsset.eyeOnImage), for: .selected)
    }
    
    private let availableIDLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.availableIDLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
        $0.isHidden = true
    }
    
    private let unavailableIDLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.closeImage) ?? UIImage()
        $0.normalTitle = Constants.unavailableIDLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
        $0.isHidden = true
    }
    
    private let checkCapitalLetter = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkCapitalLetterText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    private let checkSpecialLetter = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkSpecialLetterText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    private let checkLetterLength = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkLetterLengthText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    private let checkPassword = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkPasswordText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        [
            self.signUpLabel,
            self.guideLabel,
            self.idTextField,
            self.duplicationButton,
            self.pwTextField,
            self.eyeImageOfPW,
            self.pwCheckTextField,
            self.eyeImageOfPWCheck,
            self.nextButton,
            self.availableIDLabel,
            self.unavailableIDLabel,
            self.checkCapitalLetter,
            self.checkSpecialLetter,
            self.checkLetterLength,
            self.checkPassword
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
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
            $0.height.equalTo(29)
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
        // MARK: approve Label
        self.availableIDLabel.snp.makeConstraints {
            $0.top.equalTo(self.idTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.unavailableIDLabel.snp.makeConstraints {
            $0.top.equalTo(self.idTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.checkCapitalLetter.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.checkSpecialLetter.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self.checkCapitalLetter.snp.trailing).offset(8)
        }
        self.checkLetterLength.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self.checkSpecialLetter.snp.trailing).offset(8)
        }
        self.checkPassword.snp.makeConstraints {
            $0.top.equalTo(self.pwCheckTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    // 테스트를 위한 구독 임시 함수
    private func subscribeUI() {
        nextButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.moveToAddEMailPage()
            }.disposed(by: disposeBag)
    }
    
    private func moveToAddEMailPage() {
        let addEMailVC = AddEmailViewController()
        self.navigationController?.pushViewController(addEMailVC, animated: true)
    }
}
