//
//  RegiBusinessContactViewController.swift
//  RegisterBusiness
//
//  Created by 정건호 on 2022/11/26.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift

class RegiBusinessContactViewController: BaseViewController {

    // MARK: Constants
    private enum Constants {
        static let titleLabelText = "가게 정보 입력하기"
        static let subTitleLabeltext = "이게 거의 다왔어요!\n간단한 점포정보를 입력해주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let telTextFieldTitleText = "가게 전화번호".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let telTextFieldPlaceHolderText = "가게 전화번호를 입력해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let telGuideLabelText = "전화번호 오입력으로 인한 사용자 신고 접수 시 서비스 이용이 영구\n제한될 수 있습니다".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
    }
    
    // MARK: Properties
    
    // MARK: UI Properties
    
    private let titleLabel = UnderlineLabel().then {
        $0.labelText = Constants.titleLabelText
    }
    private let subTitleLabel = UILabel().then {
        $0.attributedText = Constants.subTitleLabeltext
        $0.numberOfLines = 0
    }
    private let telTextField = UnderlineTextFieldWithTitle().then {
        $0.textField.keyboardType = .numberPad
        $0.title.attributedText = Constants.telTextFieldTitleText
        $0.textField.attributedPlaceholder = Constants.telTextFieldPlaceHolderText
    }
    private let telTextFieldGuideLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.informationMark) ?? UIImage()
        $0.normalTitle = Constants.telGuideLabelText
        $0.imageEdgeInsets = .init(top: 2, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
        $0.isEnabled = true
    }
    private let pageView = RegiBusinessPage().then {
        $0.makePage(pageNumber: 5, currentPage: 4)
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
    }
    
    override func configureUI() {
        super.configureUI()
        [
            self.titleLabel,
            self.subTitleLabel,
            self.telTextField,
            self.telTextFieldGuideLabel,
            self.nextButton,
            self.pageView
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationTopBar.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.telTextField.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.telTextFieldGuideLabel.snp.makeConstraints {
            $0.top.equalTo(self.telTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        self.pageView.snp.makeConstraints {
            $0.top.equalTo(self.navigationTopBar.snp.top).offset(24)
            $0.trailing.equalTo(self.navigationTopBar.snp.trailing).offset(-16)
        }
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        self.nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.moveToRegiBusinessOperatingTimeVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func moveToRegiBusinessOperatingTimeVC() {
        let regiBusinessOperatingTimeVC = RegiBusinessOperatingTimeViewController()
        self.navigationController?.pushViewController(regiBusinessOperatingTimeVC, animated: true)
    }
}
