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
            self.nextButton,
            self.textfield1,
            self.textfield2,
            self.textfield3,
            self.textfield4,
            self.textfield5,
            self.textfield6
        ]
            .forEach(self.view.addSubview)
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
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        // underline height 변경
        self.textfield1.snp.makeConstraints {
            $0.bottom.equalTo(self.guideLabel.snp.bottom).offset(88)
            $0.height.width.equalTo(40)
            $0.leading.equalToSuperview().offset(48)
        }
        self.textfield2.snp.makeConstraints {
            $0.bottom.equalTo(self.guideLabel.snp.bottom).offset(88)
            $0.height.width.equalTo(40)
            $0.leading.equalTo(self.textfield1.snp.trailing).offset(8)
        }
        self.textfield3.snp.makeConstraints {
            $0.bottom.equalTo(self.guideLabel.snp.bottom).offset(88)
            $0.height.width.equalTo(40)
            $0.leading.equalTo(self.textfield2.snp.trailing).offset(8)
        }
        self.textfield4.snp.makeConstraints {
            $0.bottom.equalTo(self.guideLabel.snp.bottom).offset(88)
            $0.height.width.equalTo(40)
            $0.leading.equalTo(self.textfield3.snp.trailing).offset(8)
        }
        self.textfield5.snp.makeConstraints {
            $0.bottom.equalTo(self.guideLabel.snp.bottom).offset(88)
            $0.height.width.equalTo(40)
            $0.leading.equalTo(self.textfield4.snp.trailing).offset(8)
        }
        self.textfield6.snp.makeConstraints {
            $0.bottom.equalTo(self.guideLabel.snp.bottom).offset(88)
            $0.height.width.equalTo(40)
            $0.leading.equalTo(self.textfield5.snp.trailing).offset(8)
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
