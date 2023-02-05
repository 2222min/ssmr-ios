//
//  RegiBusinessCategoryViewController.swift
//  RegisterBusiness
//
//  Created by 정건호 on 2022/11/26.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift

class RegiBusinessCategoryViewController: BaseViewController {

    // MARK: Constants
    private enum Constants {
        static let titleLabelText = "사업자 등록하기"
        static let subTitleLabeltext = "입점을 위해\n사업자 등록 정보를 입력해주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let businessCategorylabelText = "업태/업종".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let largeCategoryText = "대분류".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let largeCategorySelectedText = "대분류".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let mediumCategoryText = "중분류".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let mediumCategorySelectedText = "중분류".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let businessNameTextFieldTitle = "상호명".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let businessNameTextFieldPlaceHolder = "상호명(법인명)을 입력해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
    }
    
    // MARK: Properties
    private let largeCategorySubject = PublishSubject<String>()
    private let mediumCategorySubject = PublishSubject<String>()
    
    // MARK: UI Properties
    private let titleLabel = UnderlineLabel().then {
        $0.labelText = Constants.titleLabelText
    }
    private let subTitleLabel = UILabel().then {
        $0.attributedText = Constants.subTitleLabeltext
        $0.numberOfLines = 0
    }
    private let businessCategoryLabel = UILabel().then {
        $0.attributedText = Constants.businessCategorylabelText
    }
    private let largeCategory = LabelWithCategory().then {
        $0.category.setAttributedTitle(Constants.largeCategoryText, for: .normal)
        $0.category.setAttributedTitle(Constants.largeCategorySelectedText, for: .selected)
    }
    private let mediumCategory = LabelWithCategory().then {
        $0.category.setAttributedTitle(Constants.mediumCategoryText, for: .normal)
        $0.category.setAttributedTitle(Constants.mediumCategorySelectedText, for: .selected)
    }
    private let businessNameTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.businessNameTextFieldTitle
        $0.textField.attributedPlaceholder = Constants.businessNameTextFieldPlaceHolder
    }
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
        $0.isEnabled = true
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
        bindUI()
    }
    
    override func configureUI() {
        [
            self.titleLabel,
            self.subTitleLabel,
            self.businessCategoryLabel,
            self.largeCategory,
            self.mediumCategory,
            self.businessNameTextField,
            self.nextButton
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.businessCategoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        self.largeCategory.snp.makeConstraints {
            $0.top.equalTo(self.businessCategoryLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        self.mediumCategory.snp.makeConstraints {
            $0.top.equalTo(self.largeCategory.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        self.businessNameTextField.snp.makeConstraints {
            $0.top.equalTo(self.mediumCategory.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func subscribeUI() {
        self.largeCategory.category.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.presentToLargeCategoryPicker()
            })
            .disposed(by: disposeBag)
        
        self.mediumCategory.category.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.presentToMediumCategoryPicker()
            })
            .disposed(by: disposeBag)
        
        self.nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.moveToRegiBusinessAddressVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindUI() {
        self.largeCategorySubject
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                self.largeCategory.category.isSelected = true
                self.largeCategory.label.text = text
            })
            .disposed(by: disposeBag)
        self.mediumCategorySubject
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                self.mediumCategory.category.isSelected = true
                self.mediumCategory.label.text = text
            })
            .disposed(by: disposeBag)
    }
    
    private func presentToLargeCategoryPicker() {
        let categoryPickerVC = CategoryPickerViewController()
        categoryPickerVC.pickerSubject = largeCategorySubject
        categoryPickerVC.setTitle(self.largeCategory.category.titleLabel?.text ?? String())
        categoryPickerVC.modalPresentationStyle = .overCurrentContext
        categoryPickerVC.modalTransitionStyle = .crossDissolve
        self.present(categoryPickerVC, animated: true)
    }
    
    private func presentToMediumCategoryPicker() {
        let categoryPickerVC = CategoryPickerViewController()
        categoryPickerVC.pickerSubject = mediumCategorySubject
        categoryPickerVC.setTitle(self.mediumCategory.category.titleLabel?.text ?? String())
        categoryPickerVC.modalPresentationStyle = .overCurrentContext
        categoryPickerVC.modalTransitionStyle = .crossDissolve
        self.present(categoryPickerVC, animated: true)
    }
    private func moveToRegiBusinessAddressVC() {
        let regiBusinessAddressVC = RegiBusinessAddressViewController()
        self.navigationController?.pushViewController(regiBusinessAddressVC, animated: true)
    }
}
