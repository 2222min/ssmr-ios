//
//  AddEmailViewController.swift
//  SignUp
//
//  Created by 정건호 on 2022/10/03.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI

class AddEmailViewController: BaseViewController {

    // MARK: Constants
    private enum Constants {
        static let signUpLabelText = "회원가입"
        static let guideLabelText = "인증번호를 받을\n이메일 주소를 작성해 주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let infoLabelText = "아이디 분실 시 입력하신 이메일로 찾을 수 있어요.".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let emailTextFieldTitle = "이메일".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let emailTextFieldPlaceholder = "인증받을 이메일 주소를 입력해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
    }
    
    // MARK: Properties
    
    // MARK: UI Properties
    private let signUpLabel = UnderlineLabel().then {
        $0.labelText = Constants.signUpLabelText
    }
    private let guideLabel = UILabel().then {
        $0.attributedText = Constants.guideLabelText
        $0.numberOfLines = 0
    }
    private let emailTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.emailTextFieldTitle
        $0.textField.attributedPlaceholder = Constants.emailTextFieldPlaceholder
    }
    private let infoLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.informationMark) ?? UIImage()
        $0.normalTitle = Constants.infoLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
        $0.isEnabled = false
    }
    
    override func configureUI() {
        [
            self.signUpLabel,
            self.guideLabel,
            self.emailTextField,
            self.infoLabel,
            self.nextButton
        ]
            .forEach(self.view.addSubview)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
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
        self.emailTextField.snp.makeConstraints {
            $0.top.equalTo(self.guideLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.infoLabel.snp.makeConstraints {
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func subscribeUI() {
        self.emailTextField.textField.rx.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                guard let text = text else { return }
                owner.nextButton.isEnabled = text.isValidEmail()
            })
            .disposed(by: disposeBag)
        
        self.nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.moveToCertificationPage()
            })
            .disposed(by: disposeBag)
    }
    
    private func moveToCertificationPage() {
        let certificationVC = CertificationViewController()
        self.navigationController?.pushViewController(certificationVC, animated: true)
    }
}
