//
//  LoginFailViewController.swift
//  Login
//
//  Created by 정건호 on 2022/09/22.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation
import CommonUI
import UIKit

class LoginFailViewController: BaseViewController {
    
    // MARK: Constants
    private enum Constants {
        static let confirmButtonText = "확인".styled(
            typo: .text17NeoBold,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
    }
    
    // MARK: Properties
    
    // MARK: UI Properties
    private let uiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }
    
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
    
    private let confirmButton = UIButton().then {
        $0.setAttributedTitle(Constants.confirmButtonText, for: .normal)
        $0.backgroundColor = CommonUIAsset.ponitColor.color
        $0.layer.cornerRadius = 8
    }

    override func configureUI() {
        self.view.backgroundColor = UIColor(red: 0.43, green: 0.43, blue: 0.43, alpha: 0.5)
        self.view.addSubview(uiView)
        [
            self.loginFailLabel,
            self.failCountLabel,
            self.confirmButton
        ]
            .forEach(self.uiView.addSubview)
    }
    
    override func setupConstraints() {
        self.uiView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(288)
        }
        
        self.loginFailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(28)
        }
        
        self.failCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.loginFailLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confirmButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }
}
