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
        static let guideLabelText = "입력하신 이메일 주소에\n메일을 발송했어요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let resendButtonText = "재전송".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let checkSuccessLabelText = "확인 완료".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let checkFailLabelText = "인증정보가 확인되지 않습니다.".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mRed.color)]
        )
        static let failTitleLabelText = "인증메일이 안와요".styled(
            typo: .DDaengOverLine,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let failGuideLabel1Text = "스팸메일함을 확인해주세요!".styled(
            typo: .DDaengC2,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let failGuideLabel2Text = "인증메일이 도착하지 않았을 경우,\n땡리단길 1:1 카카오톡 채널을 이용해주세요!".styled(
            typo: .DDaengC2,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let resendSuccessLabelText = "메일이 재전송 되었습니다.".styled(
            typo: .DDaengC2,
            byAdding: [.color(CommonUIAsset.mGreen.color)]
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
    }
    private let textfield2 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
    }
    private let textfield3 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
    }
    private let textfield4 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
    }
    private let textfield5 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
    }
    private let textfield6 = UnderlineTextField().then {
        $0.underline.backgroundColor = CommonUIAsset.grey.color
        $0.textField.clearButtonMode = .never
        $0.textField.textAlignment = .center
        $0.textField.keyboardType = .numberPad
        $0.setTextFieldHeight(height: 40)
        $0.setUnderlineHeight(height: 2)
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
        addTargetToTextFields()
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
            $0.top.equalTo(self.checkSuccessLabel.snp.bottom).offset(257)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(110)
            $0.height.equalTo(24)
        }
        self.failTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(6)
        }
        self.failGuideBackground.snp.makeConstraints {
            $0.top.equalTo(self.failTitleBackground.snp.bottom).offset(5)
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
    
    private func addTargetToTextFields() {
        textfield1.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textfield2.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textfield3.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textfield4.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textfield5.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textfield6.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc func textDidChange(textField: UITextField) {
        textField.attributedText = textField.text?.styled(typo: .DDaengH1)
        let text = textField.text
        
        if text?.count == 1 {
            switch textField {
            case textfield1.textField:
                textfield2.textField.becomeFirstResponder()
            case textfield2.textField:
                textfield3.textField.becomeFirstResponder()
            case textfield3.textField:
                textfield4.textField.becomeFirstResponder()
            case textfield4.textField:
                textfield5.textField.becomeFirstResponder()
            case textfield5.textField:
                textfield6.textField.becomeFirstResponder()
            case textfield6.textField:
                textfield6.textField.resignFirstResponder()
            default:
                break
            }
        }
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
