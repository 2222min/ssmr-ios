//
//  RegiBusinessNumberViewController.swift
//  RegisterBusiness
//
//  Created by 정건호 on 2022/11/26.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift

class RegiBusinessNumberViewController: BaseViewController {

    // MARK: Constants
    private enum Constants {
        static let titleLabelText = "사업자 등록하기"
        static let subTitleLabeltext = "입점을 위해\n사업자 등록 정보를 입력해주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let businessNumberlabelText = "사업자구분 및 번호".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let individualButtonText = "개인".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let individualButtonSelectedText = "개인".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let corporationButtonText = "법인".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let corporationButtonSelectedText = "법인".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let businessNumberTextFieldPlaceHolder = "사업자번호를 입력해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let checkButtonText = "확인".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let checkBusinessNumberText = "사업자번호 확인".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let checkBusinessNumberSelectedText = "사업자번호 확인".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
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
    private let businessNumberLabel = UILabel().then {
        $0.attributedText = Constants.businessNumberlabelText
    }
    private let guideImageView = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.informationMarkBold)
    }
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.distribution = .fillEqually
    }
    private let individualButton = UIButton().then {
        $0.setAttributedTitle(Constants.individualButtonText, for: .normal)
        $0.setAttributedTitle(Constants.individualButtonSelectedText, for: .selected)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(asset: CommonUIAsset.whiteGrey)?.cgColor
    }
    private let corporationButton = UIButton().then {
        $0.setAttributedTitle(Constants.corporationButtonText, for: .normal)
        $0.setAttributedTitle(Constants.corporationButtonSelectedText, for: .selected)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(asset: CommonUIAsset.whiteGrey)?.cgColor
    }
    private let businessNumberTextField = UnderlineTextField().then {
        $0.textField.keyboardType = .numberPad
        $0.textField.attributedPlaceholder = Constants.businessNumberTextFieldPlaceHolder
    }
    private let checkButton = UIButton().then {
        $0.setAttributedTitle(Constants.checkButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.grey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let checkBusinessNumber = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.disapproveImage) ?? UIImage()
        $0.normalTitle = Constants.checkBusinessNumberText
        $0.selectedImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.selectedTitle = Constants.checkBusinessNumberSelectedText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
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
        $0.makePage(pageNumber: 5, currentPage: 1)
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
    }
    
    override func configureUI() {
        super.configureUI()
        [
            self.individualButton,
            self.corporationButton
        ]
            .forEach(self.buttonStackView.addArrangedSubview)
        [
            self.titleLabel,
            self.subTitleLabel,
            self.businessNumberLabel,
            self.guideImageView,
            self.buttonStackView,
            self.businessNumberTextField,
            self.checkButton,
            self.checkBusinessNumber,
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
        self.businessNumberLabel.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        self.guideImageView.snp.makeConstraints {
            $0.centerY.equalTo(self.businessNumberLabel).offset(2)
            $0.leading.equalTo(self.businessNumberLabel.snp.trailing).offset(10)
        }
        self.buttonStackView.snp.makeConstraints {
            $0.top.equalTo(self.businessNumberLabel.snp.bottom).offset(12)
            $0.height.equalTo(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        self.businessNumberTextField.snp.makeConstraints {
            $0.top.equalTo(self.buttonStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        self.checkButton.snp.makeConstraints {
            $0.top.equalTo(self.businessNumberTextField.snp.top)
            $0.height.equalTo(self.businessNumberTextField.textField)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(51)
        }
        self.checkBusinessNumber.snp.makeConstraints {
            $0.top.equalTo(self.businessNumberTextField.underline.snp.bottom).offset(12)
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
        self.individualButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.individualButton.isSelectedToggleWithBorderColor()
                if owner.individualButton.isSelected && owner.corporationButton.isSelected {
                    owner.corporationButton.isSelectedToggleWithBorderColor()
                }
            })
            .disposed(by: disposeBag)
        self.corporationButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.corporationButton.isSelectedToggleWithBorderColor()
                if owner.individualButton.isSelected && owner.corporationButton.isSelected {
                    owner.individualButton.isSelectedToggleWithBorderColor()
                }
            })
            .disposed(by: disposeBag)
        
        self.nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.moveToRegiBusinessCategoryVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func moveToRegiBusinessCategoryVC() {
        let regiBusinessCategoryVC = RegiBusinessCategoryViewController()
        self.navigationController?.pushViewController(regiBusinessCategoryVC, animated: true)
    }
}
