//
//  FindIdView.swift
//  FindUserInfoDemoApp
//
//  Created by mincheol on 2022/09/30.
//  Copyright © 2022 team.io. All rights reserved.
//

import CommonUI

import UIKit

final class FindIdView: UIView {
    
    // MARK: Constants
    
    private enum Constants {
        static let title = "이메일 입력하기".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let emailPlaceholder = "인증했던 이메일 주소를 입력해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let emailWarningDescription = "가입 시 인증했던 이메일을 입력해 주세요".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let emailErrorDescription = "가입 정보가 없는 이메일입니다".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mRed.color)]
        )
    }
    
    // MARK: UIProperties
    
    private let emailTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.title
        $0.textField.attributedPlaceholder = Constants.emailPlaceholder
    }
    private let emailWarning = LeftImageButton().then {
        $0.normalTitle = Constants.emailWarningDescription
        $0.normalImage = CommonUIAsset.informationMark.image
        $0.titleEdgeInsets = .init(top: -1, left: 4, bottom: 0, right: 0)
    }
    private let emailError = LeftImageButton().then {
        $0.normalTitle = Constants.emailErrorDescription
        $0.normalImage = CommonUIAsset.informationMark.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = CommonUIAsset.mRed.color
        $0.titleEdgeInsets = .init(top: -1, left: 4, bottom: 0, right: 0)
    }
    
    init() {
        super.init(frame: .zero)
        self.configureUI()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [
            emailTextField,
            emailWarning,
            emailError
        ]
            .forEach(self.addSubview)
    }
    
    private func setConstraints() {
        self.emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.emailWarning.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.left.equalTo(emailTextField.snp.left)
            $0.right.equalTo(emailTextField.snp.right)
        }
        self.emailError.snp.makeConstraints {
            $0.top.equalTo(emailWarning.snp.bottom).offset(8)
            $0.left.equalTo(emailTextField.snp.left)
            $0.right.equalTo(emailTextField.snp.right)
        }
    }
}
