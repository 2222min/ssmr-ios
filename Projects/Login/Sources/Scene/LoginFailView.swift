//
//  LoginFailView.swift
//  Login
//
//  Created by 정건호 on 2022/09/22.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI

class LoginFailView: UIView {
    private let loginFailLabel = UILabel().then {
        $0.attributedText = "로그인에 실패했어요".styled(
            typo: .text20NeoNormal,
            byAdding: [.color(CommonUIAsset.black.color)])
    }
    
    private let failCountLabel = UILabel().then {
        $0.attributedText = "(1회 실패)".styled(
            typo: .text12NeoNormal,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
    }
    
    private let checkImage = UIImageView().then {
        $0.image = CommonUIAsset.checkImage.image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .clear
        addSubview(loginFailLabel)
        addSubview(failCountLabel)
        
        setupConstraints()
        self.isUserInteractionEnabled = true
    }
    
    private func setupConstraints() {
        loginFailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.centerX.equalToSuperview()
        }
        failCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.loginFailLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
}
