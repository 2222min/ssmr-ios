//
//  RegiBusinessFirstViewController.swift
//
//  Created by 정건호 on 2022/11/06.
//  Copyright © 2022 team.io. All rights reserved.
//

//import UIKit
//import CommonUI
//import RxSwift
//
//class RegiBusinessFirstViewController: BaseViewController {
//
//    // MARK: Constants
//    private enum Constants {
//        static let titleLabelText = "사업자 등록하기"
//        static let subTitleLabeltext = "입점을 위해\n사업자 등록 정보를 입력해주세요".styled(
//            typo: .DDaengB1,
//            byAdding: [.color(CommonUIAsset.deepGrey.color)]
//        )
//        static let businessNumberlabelText = "사업자구분 및 번호".styled(
//            typo: .DDaengH3,
//            byAdding: [.color(CommonUIAsset.deepGrey.color)]
//        )
//        static let individualButtonText = "개인".styled(
//            typo: .ButtomSmall,
//            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
//        )
//        static let individualButtonSelectedText = "개인".styled(
//            typo: .ButtomSmall,
//            byAdding: [.color(CommonUIAsset.pointColor.color)]
//        )
//        static let corporationButtonText = "법인".styled(
//            typo: .ButtomSmall,
//            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
//        )
//        static let corporationButtonSelectedText = "법인".styled(
//            typo: .ButtomSmall,
//            byAdding: [.color(CommonUIAsset.pointColor.color)]
//        )
//        static let businessNumberTextFieldPlaceHolder = "사업자번호를 입력해 주세요".styled(
//            typo: .DDaengMB2,
//            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
//        )
//        static let checkButtonText = "확인".styled(
//            typo: .ButtomSmall,
//            byAdding: [.color(CommonUIAsset.white.color)]
//        )
//        static let checkBusinessNumberText = "사업자번호 확인".styled(
//            typo: .DDaengC1,
//            byAdding: [.color(CommonUIAsset.grey.color)]
//        )
//        static let checkBusinessNumberSelectedText = "사업자번호 확인".styled(
//            typo: .DDaengC1,
//            byAdding: [.color(CommonUIAsset.pointColor.color)]
//        )
//        static let businessCategorylabelText = "업태/업종".styled(
//            typo: .DDaengH3,
//            byAdding: [.color(CommonUIAsset.deepGrey.color)]
//        )
//        static let largeCategoryText = "대분류".styled(
//            typo: .DDaengMB2,
//            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
//        )
//        static let largeCategorySelectedText = "대분류".styled(
//            typo: .DDaengMB2,
//            byAdding: [.color(CommonUIAsset.pointColor.color)]
//        )
//        static let mediumCategoryText = "중분류".styled(
//            typo: .DDaengMB2,
//            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
//        )
//        static let mediumCategorySelectedText = "중분류".styled(
//            typo: .DDaengMB2,
//            byAdding: [.color(CommonUIAsset.pointColor.color)]
//        )
//        static let businessNameTextFieldTitle = "상호명".styled(
//            typo: .DDaengH3,
//            byAdding: [.color(CommonUIAsset.deepGrey.color)]
//        )
//        static let businessNameTextFieldPlaceHolder = "상호명(법인명)을 입력해 주세요".styled(
//            typo: .DDaengMB2,
//            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
//        )
//        static let nextButtonText = "다음".styled(
//            typo: .ButtonLarge,
//            byAdding: [.color(CommonUIAsset.white.color)]
//        )
//    }
//    
//    // MARK: Properties
//    private let largeCategorySubject = PublishSubject<String>()
//    private let mediumCategorySubject = PublishSubject<String>()
//    
//    // MARK: UI Properties
//    private let titleLabel = UnderlineLabel().then {
//        $0.labelText = Constants.titleLabelText
//    }
//    private let subTitleLabel = UILabel().then {
//        $0.attributedText = Constants.subTitleLabeltext
//        $0.numberOfLines = 0
//    }
//    private let businessNumberLabel = UILabel().then {
//        $0.attributedText = Constants.businessNumberlabelText
//    }
//    private let guideImageView = UIImageView().then {
//        $0.image = UIImage(asset: CommonUIAsset.informationMarkBold)
//    }
//    private let buttonStackView = UIStackView().then {
//        $0.axis = .horizontal
//        $0.spacing = 16
//        $0.distribution = .fillEqually
//    }
//    private let individualButton = UIButton().then {
//        $0.setAttributedTitle(Constants.individualButtonText, for: .normal)
//        $0.setAttributedTitle(Constants.individualButtonSelectedText, for: .selected)
//        $0.layer.cornerRadius = 8
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor(asset: CommonUIAsset.whiteGrey)?.cgColor
//    }
//    private let corporationButton = UIButton().then {
//        $0.setAttributedTitle(Constants.corporationButtonText, for: .normal)
//        $0.setAttributedTitle(Constants.corporationButtonSelectedText, for: .selected)
//        $0.layer.cornerRadius = 8
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor(asset: CommonUIAsset.whiteGrey)?.cgColor
//    }
//    private let businessNumberTextField = UnderlineTextField().then {
//        $0.textField.attributedPlaceholder = Constants.businessNameTextFieldPlaceHolder
//    }
//    private let checkButton = UIButton().then {
//        $0.setAttributedTitle(Constants.checkButtonText, for: .normal)
//        $0.setBackgroundColor(color: CommonUIAsset.grey.color, forState: .normal)
//        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
//        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
//        $0.layer.cornerRadius = 12
//    }
//    private let checkBusinessNumber = LeftImageButton().then {
//        $0.normalImage = UIImage(asset: CommonUIAsset.disapproveImage) ?? UIImage()
//        $0.normalTitle = Constants.checkBusinessNumberText
//        $0.selectedImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
//        $0.selectedTitle = Constants.checkBusinessNumberSelectedText
//        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
//        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
//    }
//    private let businessCategoryLabel = UILabel().then {
//        $0.attributedText = Constants.businessCategorylabelText
//    }
//    private let largeCategory = LabelWithCategory().then {
//        $0.category.setAttributedTitle(Constants.largeCategoryText, for: .normal)
//        $0.category.setAttributedTitle(Constants.largeCategorySelectedText, for: .selected)
//    }
//    private let mediumCategory = LabelWithCategory().then {
//        $0.category.setAttributedTitle(Constants.mediumCategoryText, for: .normal)
//        $0.category.setAttributedTitle(Constants.mediumCategorySelectedText, for: .selected)
//    }
//    private let businessNameTextField = UnderlineTextFieldWithTitle().then {
//        $0.title.attributedText = Constants.businessNameTextFieldTitle
//        $0.textField.attributedPlaceholder = Constants.businessNameTextFieldPlaceHolder
//    }
//    private let nextButton = CTAButton().then {
//        $0.setAttributedTitle(
//            Constants.nextButtonText,
//            for: .normal
//        )
//        $0.isEnabled = true
//    }
//    
//    // MARK: View Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        subscribeUI()
//        bindUI()
//    }
//    
//    override func configureUI() {
//        [
//            self.individualButton,
//            self.corporationButton
//        ]
//            .forEach(self.buttonStackView.addArrangedSubview)
//        [
//            self.titleLabel,
//            self.subTitleLabel,
//            self.businessNumberLabel,
//            self.guideImageView,
//            self.buttonStackView,
//            self.businessNumberTextField,
//            self.checkButton,
//            self.checkBusinessNumber,
//            self.businessCategoryLabel,
//            self.largeCategory,
//            self.mediumCategory,
//            self.businessNameTextField,
//            self.nextButton
//        ]
//            .forEach(self.view.addSubview)
//    }
//    
//    // MARK: Constraints
//    override func setupConstraints() {
//        self.titleLabel.snp.makeConstraints {
//            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
//            $0.leading.equalToSuperview().offset(16)
//        }
//        self.subTitleLabel.snp.makeConstraints {
//            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
//            $0.leading.equalToSuperview().offset(16)
//        }
//        self.businessNumberLabel.snp.makeConstraints {
//            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(40)
//            $0.leading.equalToSuperview().offset(16)
//        }
//        self.guideImageView.snp.makeConstraints {
//            $0.centerY.equalTo(self.businessNumberLabel).offset(2)
//            $0.leading.equalTo(self.businessNumberLabel.snp.trailing).offset(10)
//        }
//        self.buttonStackView.snp.makeConstraints {
//            $0.top.equalTo(self.businessNumberLabel.snp.bottom).offset(12)
//            $0.height.equalTo(32)
//            $0.leading.trailing.equalToSuperview().inset(16)
//        }
//        self.businessNumberTextField.snp.makeConstraints {
//            $0.top.equalTo(self.buttonStackView.snp.bottom).offset(24)
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(24)
//        }
//        self.checkButton.snp.makeConstraints {
//            $0.top.equalTo(self.businessNumberTextField.snp.top)
//            $0.height.equalTo(self.businessNumberTextField.textField)
//            $0.trailing.equalToSuperview().inset(16)
//            $0.width.equalTo(51)
//        }
//        self.checkBusinessNumber.snp.makeConstraints {
//            $0.top.equalTo(self.businessNumberTextField.underline.snp.bottom).offset(12)
//            $0.leading.equalToSuperview().offset(16)
//        }
//        self.businessCategoryLabel.snp.makeConstraints {
//            $0.top.equalTo(self.checkBusinessNumber.snp.bottom).offset(32)
//            $0.leading.equalToSuperview().offset(16)
//        }
//        self.largeCategory.snp.makeConstraints {
//            $0.top.equalTo(self.businessCategoryLabel.snp.bottom).offset(16)
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(24)
//        }
//        self.mediumCategory.snp.makeConstraints {
//            $0.top.equalTo(self.largeCategory.snp.bottom).offset(24)
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(24)
//        }
//        self.businessNameTextField.snp.makeConstraints {
//            $0.top.equalTo(self.mediumCategory.snp.bottom).offset(32)
//            $0.leading.trailing.equalToSuperview().inset(16)
//            $0.height.equalTo(73)
//        }
//        self.nextButton.snp.makeConstraints {
//            $0.top.equalTo(self.businessNameTextField.textField.snp.bottom).offset(48)
//            $0.leading.trailing.equalToSuperview().inset(16)
//        }
//    }
//    
//    private func subscribeUI() {
//        self.largeCategory.category.rx.tap
//            .withUnretained(self)
//            .subscribe(onNext: { owner, _ in
//                owner.presentToLargeCategoryPicker()
//            })
//            .disposed(by: disposeBag)
//        
//        self.mediumCategory.category.rx.tap
//            .withUnretained(self)
//            .subscribe(onNext: { owner, _ in
//                owner.presentToMediumCategoryPicker()
//            })
//            .disposed(by: disposeBag)
//        self.individualButton.rx.tap
//            .withUnretained(self)
//            .subscribe(onNext: { owner, _ in
//                owner.individualButton.isSelectedToggleWithBorderColor()
//                if owner.individualButton.isSelected && owner.corporationButton.isSelected {
//                    owner.corporationButton.isSelectedToggleWithBorderColor()
//                }
//            })
//            .disposed(by: disposeBag)
//        self.corporationButton.rx.tap
//            .withUnretained(self)
//            .subscribe(onNext: { owner, _ in
//                owner.corporationButton.isSelectedToggleWithBorderColor()
//                if owner.individualButton.isSelected && owner.corporationButton.isSelected {
//                    owner.individualButton.isSelectedToggleWithBorderColor()
//                }
//            })
//            .disposed(by: disposeBag)
//        
//        self.nextButton.rx.tap
//            .withUnretained(self)
//            .subscribe(onNext: { owner, _ in
//                owner.moveToRegiBusinessSecondVC()
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    private func bindUI() {
//        self.largeCategorySubject
//            .withUnretained(self)
//            .subscribe(onNext: { owner, text in
//                self.largeCategory.category.isSelected = true
//                self.largeCategory.label.text = text
//            })
//            .disposed(by: disposeBag)
//        self.mediumCategorySubject
//            .withUnretained(self)
//            .subscribe(onNext: { owner, text in
//                self.mediumCategory.category.isSelected = true
//                self.mediumCategory.label.text = text
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    private func presentToLargeCategoryPicker() {
//        let categoryPickerVC = CategoryPickerViewController()
//        categoryPickerVC.pickerSubject = largeCategorySubject
//        categoryPickerVC.setTitle(self.largeCategory.category.titleLabel?.text ?? String())
//        categoryPickerVC.modalPresentationStyle = .overCurrentContext
//        categoryPickerVC.modalTransitionStyle = .crossDissolve
//        self.present(categoryPickerVC, animated: true)
//    }
//    
//    private func presentToMediumCategoryPicker() {
//        let categoryPickerVC = CategoryPickerViewController()
//        categoryPickerVC.pickerSubject = mediumCategorySubject
//        categoryPickerVC.setTitle(self.mediumCategory.category.titleLabel?.text ?? String())
//        categoryPickerVC.modalPresentationStyle = .overCurrentContext
//        categoryPickerVC.modalTransitionStyle = .crossDissolve
//        self.present(categoryPickerVC, animated: true)
//    }
//    private func moveToRegiBusinessSecondVC() {
//        let regiBusinessSecondVC = RegiBusinessSecondViewController()
//        self.navigationController?.pushViewController(regiBusinessSecondVC, animated: true)
//    }
//}
