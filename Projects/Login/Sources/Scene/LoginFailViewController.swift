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
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        
        static let guideLabelText = NSAttributedString.composed(
            of: [
                "5회 오류 시 로그인이 ".styled(
                    typo: .DDaengC1,
                    byAdding: [.color(CommonUIAsset.black.color)]
                ),
                "1분간 ".styled(
                    typo: .DDaengC1,
                    byAdding: [.color(CommonUIAsset.mRed.color)]
                ),
                "제한되어\n아이디/비밀번호 찾기를 통해\n비밀번호를 재설정해 주세요".styled(
                    typo: .DDaengC1,
                    byAdding: [.color(CommonUIAsset.black.color)]
                )
            ]
        )
        
        static let caution1Text = "땡리단길 회원이 아닌 경우".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.black.color)]
        )
        
        static let caution2Text = "아이디 또는 비밀번호를 잘못 입력한 경우".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.black.color)]
        )
        
        static let caution3Text = "5회 이상 입력 오류 시 개인정보 보호를 위해\n잠시 동안 로그인이 제한됩니다".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.black.color)]
        )
    }
    
    // MARK: Properties
    
    // MARK: UI Properties
    private let uiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }
    
    private let normalView = UIView().then {
        $0.isHidden = false
    }
    
    private let restrictedView = UIView().then {
        $0.isHidden = true
    }
    
    // normalView
    
    private let loginFailLabel = UILabel().then {
        $0.attributedText = "로그인에 실패했어요".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.black.color)])
    }
    
    private let failCountLabel = UILabel().then {
        $0.attributedText = "(1회 실패)".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
    }
    
    private let caution1 = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.checkImage) ?? UIImage()
        $0.normalTitle = Constants.caution1Text
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
    }
    
    private let caution2 = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.checkImage) ?? UIImage()
        $0.normalTitle = Constants.caution2Text
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
    }
    
    private let caution3 = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.checkImage) ?? UIImage()
        $0.normalTitle = Constants.caution3Text
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
    }
    
    // restrictedView
    
    private let cautionImage = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.cautionImage)
    }
    
    private let fiveLoginFailLabel = UILabel().then {
        $0.attributedText = "5회 이상 로그인에 실패했어요".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.black.color)])
    }
    
    private let guideLabel = UILabel().then {
        $0.attributedText = Constants.guideLabelText
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let confirmButton = UIButton().then {
        $0.setAttributedTitle(Constants.confirmButtonText, for: .normal)
        $0.backgroundColor = CommonUIAsset.pointColor.color
        $0.layer.cornerRadius = 8
    }

    override func configureUI() {
        self.view.backgroundColor = UIColor(red: 0.43, green: 0.43, blue: 0.43, alpha: 0.5)
        self.view.addSubview(uiView)
        
        // normalView
        [
            self.loginFailLabel,
            self.failCountLabel,
            self.caution1,
            self.caution2,
            self.caution3
        ]
            .forEach(self.normalView.addSubview)
        
        // restrictedView
        [
            self.cautionImage,
            self.fiveLoginFailLabel,
            self.guideLabel
        ]
            .forEach(self.restrictedView.addSubview)
        
        [
            self.normalView,
            self.restrictedView,
            self.confirmButton
        ]
            .forEach(self.uiView.addSubview)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        self.uiView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(288)
        }
        self.confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        // normalView
        self.normalView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        self.loginFailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.height.equalTo(28)
            $0.centerX.equalToSuperview()
        }
        
        self.failCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.loginFailLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        self.caution1.snp.makeConstraints {
            $0.top.equalTo(self.failCountLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(74)
            $0.trailing.equalToSuperview()
        }
        
        self.caution2.snp.makeConstraints {
            $0.top.equalTo(self.caution1.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(74)
            $0.trailing.equalToSuperview()
        }
        
        self.caution3.snp.makeConstraints {
            $0.top.equalTo(self.caution2.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(74)
            $0.trailing.equalToSuperview()
        }
        
        // restrictedView
        self.restrictedView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        self.cautionImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.height.width.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        self.fiveLoginFailLabel.snp.makeConstraints {
            $0.top.equalTo(self.cautionImage.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        self.guideLabel.snp.makeConstraints {
            $0.top.equalTo(self.fiveLoginFailLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
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
