//
//  SignUpSuccessViewController.swift
//  SignUp
//
//  Created by 정건호 on 2022/10/15.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI

class SignUpSuccessViewController: BaseViewController {
    
    // MARK: Constants
    private enum Constants {
        static let titleLabelText = "XXXX님,\n땡리단길 가입을\n축하드립니다 🎉".styled(
            typo: .Display,
            byAdding: [.color(CommonUIAsset.black.color)]
        )
        static let subtitleLabelText = "혹시 대표님이신가요?\n가게 등록을 손쉽게 진행하고\n입점해 볼까요?".styled(
            typo: .Body1,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let registerStoreButtonText = "3분만에 입점하기".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = Constants.titleLabelText
        $0.numberOfLines = 0
    }
    private let subtitleLabel = UILabel().then {
        $0.attributedText = Constants.subtitleLabelText
        $0.numberOfLines = 0
    }
    private let registerStoreButton = UIButton().then {
        $0.setAttributedTitle(Constants.registerStoreButtonText, for: .normal)
        $0.setImage(UIImage(asset: CommonUIAsset.rightArrowImage), for: .normal)
        $0.setImage(UIImage(asset: CommonUIAsset.rightArrowImage), for: .highlighted)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = .init(top: 3, left: 3, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 3, right: 0)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(asset: CommonUIAsset.pointColor)?.cgColor
    }
    private let celebrationImageView = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.celebrationImage)
    }
    private let moveToMainButton = CTAButton().then {
        $0.title = "땡리단길로 가기"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func configureUI() {
        [
            self.titleLabel,
            self.subtitleLabel,
            self.registerStoreButton,
            self.celebrationImageView,
            self.moveToMainButton
        ]
            .forEach(self.view.addSubview)
    }
    
    override func setupConstraints() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.registerStoreButton.snp.makeConstraints {
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(193)
            $0.height.equalTo(46)
        }
        self.celebrationImageView.snp.makeConstraints {
            $0.top.equalTo(self.registerStoreButton.snp.bottom).offset(40)
            $0.height.equalTo(self.view.frame.width * 0.573)
            $0.leading.trailing.equalToSuperview()
        }
        self.moveToMainButton.snp.makeConstraints {
//            $0.bottom.equalToSuperview().offset(-50)
            $0.top.equalTo(self.celebrationImageView.snp.bottom).offset(76)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        
        self.moveToMainButton.rx.tap
            .subscribe(with: self) { owner, _ in
                // TODO: 가입 성공 화면 -> 사업 등록 페이지 이동
            }
            .disposed(by: disposeBag)
    }
}
