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
        static let emailPlaceholder = "인증했던 이메일 주소를 입력해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let firstWarningDescription = "가입 시 인증했던 이메일을 입력해 주세요".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let notFoundWarningDescription = "가입 정보가 없는 이메일입니다".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mRed.color)]
        )
    }
    
    // MARK: UIProperties
    private let emailTexField = UnderlineTextField().then {
        $0.textField.attributedPlaceholder = Constants.emailPlaceholder
    }
    private let firstWarning = LeftImageButton().then {
        $0.normalTitle = Constants.firstWarningDescription
        $0.normalImage = CommonUIAsset.informationMark.image
        $0.titleEdgeInsets = .init(top: -1, left: 4, bottom: 0, right: 0)
    }
    private let notFoundWarning = LeftImageButton().then {
        let image = CommonUIAsset.informationMark.image.withRenderingMode(.alwaysTemplate)
        $0.tintColor = CommonUIAsset.mRed.color
        $0.normalTitle = Constants.notFoundWarningDescription
        $0.normalImage = image
        $0.titleEdgeInsets = .init(top: -1, left: 4, bottom: 0, right: 0)
        $0.isHidden = true
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
            emailTexField,
            firstWarning,
            notFoundWarning
        ]
            .forEach(self.addSubview)
    }
    
    private func setConstraints() {
        self.emailTexField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(29)
        }
        self.firstWarning.snp.makeConstraints {
            $0.top.equalTo(emailTexField.snp.bottom).offset(12)
            $0.left.equalTo(emailTexField.snp.left)
            $0.right.equalTo(emailTexField.snp.right)
        }
        self.notFoundWarning.snp.makeConstraints {
            $0.top.equalTo(self.firstWarning.snp.bottom).offset(8)
            $0.left.equalTo(emailTexField.snp.left)
            $0.right.equalTo(emailTexField.snp.right)
        }
    }
}
