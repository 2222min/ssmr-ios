//
//  Certification.swift
//  SignUp
//
//  Created by 정건호 on 2022/10/03.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI

class CertificationViewController: BaseViewController {

    // MARK: Constants
    private enum Constants {
        static let signUpLabelText = "회원가입"
        static let guideLabelText = "입력하신 이메일 주소에\n메일을 발송했어요".styled(
            typo: .Body1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let resendButtonText = "재전송".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let checkSuccessLabelText = "확인 완료".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let checkFailLabelText = "인증정보가 확인되지 않습니다.".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.mRed.color)]
        )
        static let failTitleLabelText = "인증메일이 안와요".styled(
            typo: .Caption2,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let failGuideLabel1Text = "스팸메일함을 확인해주세요!".styled(
            typo: .Caption2,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let failGuideLabel2Text = "인증메일이 도착하지 않았을 경우,\n땡리단길 1:1 카카오톡 채널을 이용해주세요!".styled(
            typo: .Caption2,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let resendSuccessLabelText = "메일이 재전송 되었습니다.".styled(
            typo: .Caption2,
            byAdding: [.color(CommonUIAsset.mGreen.color)]
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
    // TODO: 타이머 구현
//    private let timerLabel = UILabel().then {
//    }
    private let resendButton = UIButton().then {
        $0.setAttributedTitle(Constants.resendButtonText, for: .normal)
        $0.backgroundColor = CommonUIAsset.grey.color
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let checkFailLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.closeImage) ?? UIImage()
        $0.normalTitle = Constants.checkFailLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let checkSuccessLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage)?.withTintColor(CommonUIAsset.grey.color) ?? UIImage()
        $0.normalTitle = Constants.checkSuccessLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
        $0.isHidden = true
    }
    private let resendSuccessLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.informationMark)?.withTintColor(CommonUIAsset.mGreen.color) ?? UIImage()
        $0.normalTitle = Constants.resendSuccessLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let textfield1 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
        $0.textField.tag = 0
    }
    private let textfield2 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
        $0.textField.tag = 1
    }
    private let textfield3 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
        $0.textField.tag = 2
    }
    private let textfield4 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
        $0.textField.tag = 3
    }
    private let textfield5 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
        $0.textField.tag = 4
    }
    private let textfield6 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
        $0.textField.tag = 5
    }
    private let textfieldStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    private let failTitleBackground = UIView().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = CommonUIAsset.cream.color
    }
    private let failTitleLabel = UILabel().then {
        $0.attributedText = Constants.failTitleLabelText
    }
    private let failGuideBackground = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = CommonUIAsset.cream.color
    }
    private let failGuideLabel1 = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.dotImage) ?? UIImage()
        $0.normalTitle = Constants.failGuideLabel1Text
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 4, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    private let failGuideLabel2 = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.dotImage) ?? UIImage()
        $0.normalTitle = Constants.failGuideLabel2Text
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 10, right: 0)
    }
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
    }
    
    override func configureUI() {
        super.configureUI()
        [
            self.signUpLabel,
            self.guideLabel,
            self.resendButton,
            self.textfieldStackView,
            self.checkSuccessLabel,
            self.checkFailLabel,
            self.resendSuccessLabel,
            self.failTitleBackground,
            self.failGuideBackground,
            self.nextButton
        ]
            .forEach(self.view.addSubview)
        [
            self.textfield1,
            self.textfield2,
            self.textfield3,
            self.textfield4,
            self.textfield5,
            self.textfield6
        ]
            .forEach(self.textfieldStackView.addArrangedSubview)
        self.failTitleBackground.addSubview(failTitleLabel)
        self.failGuideBackground.addSubview(failGuideLabel1)
        self.failGuideBackground.addSubview(failGuideLabel2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [
            self.textfield1.textField,
            self.textfield2.textField,
            self.textfield3.textField,
            self.textfield4.textField,
            self.textfield5.textField,
            self.textfield6.textField
        ]
            .forEach {
                $0.delegate = self
            }
        subscribeUI()
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.signUpLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationTopBar.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        self.guideLabel.snp.makeConstraints {
            $0.top.equalTo(self.signUpLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.resendButton.snp.makeConstraints {
            $0.bottom.equalTo(self.guideLabel.snp.bottom)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
            $0.width.equalTo(62)
        }
        self.textfield1.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        self.textfield2.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        self.textfield3.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        self.textfield4.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        self.textfield5.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        self.textfield6.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        self.textfieldStackView.snp.makeConstraints {
            $0.bottom.equalTo(self.guideLabel.snp.bottom).offset(88)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        self.checkSuccessLabel.snp.makeConstraints {
            $0.top.equalTo(self.textfieldStackView.snp.bottom).offset(12)
            $0.leading.equalTo(self.textfieldStackView.snp.leading)
        }
        self.checkFailLabel.snp.makeConstraints {
            $0.top.equalTo(self.textfieldStackView.snp.bottom).offset(12)
            $0.leading.equalTo(self.textfieldStackView.snp.leading)
        }
        self.resendSuccessLabel.snp.makeConstraints {
            $0.top.equalTo(self.checkSuccessLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.textfieldStackView.snp.leading)
        }
        self.failTitleBackground.snp.makeConstraints {
            $0.bottom.equalTo(self.failGuideBackground.snp.top).offset(-4)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(110)
            $0.height.equalTo(24)
        }
        self.failTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(6)
        }
        self.failGuideBackground.snp.makeConstraints {
            $0.bottom.equalTo(self.nextButton.snp.top).offset(-24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(72)
        }
        self.failGuideLabel1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        self.failGuideLabel2.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.moveToAddInfoPage()
            })
            .disposed(by: disposeBag)
        
        subscribeTextField()
    }
    
    private func subscribeTextField() {
        let textFields = [
            self.textfield1.textField,
            self.textfield2.textField,
            self.textfield3.textField,
            self.textfield4.textField,
            self.textfield5.textField,
            self.textfield6.textField,
        ]
        
        textFields.forEach { textField in
            textField.rx.controlEvent(.editingChanged)
                .withUnretained(self)
                .subscribe(onNext: { owner, _ in
                    textField.attributedText = textField.text?.styled(typo: .Display)
                    textField.textAlignment = .center
                    if textField.text?.count == 1 {
                        if textFields.count == textField.tag + 1 {
                            owner.textfield6.textField.resignFirstResponder()
                        } else {
                            textFields[textField.tag + 1].becomeFirstResponder()
                        }
                    } else if textField.text?.count == 0 {
                        if textField.tag != 0 {
                            textFields[textField.tag - 1].becomeFirstResponder()
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func moveToAddInfoPage() {
        let addInfoVC = AddInfoViewController()
        self.navigationController?.pushViewController(addInfoVC, animated: true)
    }
}

extension CertificationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text?.count ?? 0 < 1 else { return false }
        return true
    }
}
