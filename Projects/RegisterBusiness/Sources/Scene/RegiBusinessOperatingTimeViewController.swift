//
//  RegiBusinessOperatingTimeViewController.swift
//  RegisterBusiness
//
//  Created by 정건호 on 2022/11/12.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift

class RegiBusinessOperatingTimeViewController: BaseViewController {

    // MARK: Constants
    private enum Constants {
        static let titleLabelText = "가게 정보 입력하기"
        static let subTitleLabeltext = "이게 거의 다왔어요!\n간단한 점포정보를 입력해주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let operatingTimeLabelText = "운영시간".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let monButtonText = "월".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let tueButtonText = "화".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let wedButtonText = "수".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let thuButtonText = "목".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let friButtonText = "금".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let satButtonText = "토".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let sunButtonText = "일".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let operatingTimeTextFieldPlaceHolder = "운영시간을 선택해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let saveButtonText = "저장".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let operatingTimeGuideLabelText = "자세한 가게 운영시간 및 가게 정보는 가입 완료 후 수정 가능합니다".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let savedOperatingTimeLabelText = "저장된 운영시간 (모든 요일 필수)".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
    }
    
    // MARK: Properties
    
    private let timeSubject = PublishSubject<String>()
    
    // MARK: UI Properties
    
    private let titleLabel = UnderlineLabel().then {
        $0.labelText = Constants.titleLabelText
    }
    private let subTitleLabel = UILabel().then {
        $0.attributedText = Constants.subTitleLabeltext
        $0.numberOfLines = 0
    }
    private let operatingTimeLabel = UILabel().then {
        $0.attributedText = Constants.operatingTimeLabelText
    }
    private let dayStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    private let monButton = UIButton().then {
        $0.setAttributedTitle(Constants.monButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let tueButton = UIButton().then {
        $0.setAttributedTitle(Constants.tueButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let wedButton = UIButton().then {
        $0.setAttributedTitle(Constants.wedButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let thuButton = UIButton().then {
        $0.setAttributedTitle(Constants.thuButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let friButton = UIButton().then {
        $0.setAttributedTitle(Constants.friButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let satButton = UIButton().then {
        $0.setAttributedTitle(Constants.satButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let sunButton = UIButton().then {
        $0.setAttributedTitle(Constants.sunButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let operatingTimeTextField = UnderlineTextField().then {
        $0.textField.attributedPlaceholder = Constants.operatingTimeTextFieldPlaceHolder
    }
    private let saveButton = UIButton().then {
        $0.setAttributedTitle(Constants.saveButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.grey.color, forState: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .selected)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let operatingTimeGuideLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.informationMark) ?? UIImage()
        $0.normalTitle = Constants.operatingTimeGuideLabelText
        $0.imageEdgeInsets = .init(top: 2, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let savedOperatingTimeLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.watchImage) ?? UIImage()
        $0.normalTitle = Constants.savedOperatingTimeLabelText
        $0.imageEdgeInsets = .init(top: 2, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let operatingTimeCheckImage = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.approveImage)?
            .withTintColor(CommonUIAsset.grey.color, renderingMode: .alwaysOriginal)
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
            self.monButton,
            self.tueButton,
            self.wedButton,
            self.thuButton,
            self.friButton,
            self.satButton,
            self.sunButton
        ]
            .forEach(self.dayStackView.addArrangedSubview)
        [
            self.titleLabel,
            self.subTitleLabel,
            self.operatingTimeLabel,
            self.dayStackView,
            self.operatingTimeTextField,
            self.saveButton,
            self.operatingTimeGuideLabel,
            self.savedOperatingTimeLabel,
            self.operatingTimeCheckImage,
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
        self.operatingTimeLabel.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        self.dayStackView.snp.makeConstraints {
            $0.top.equalTo(self.operatingTimeLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        self.operatingTimeTextField.snp.makeConstraints {
            $0.top.equalTo(self.dayStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.saveButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.operatingTimeTextField.textField)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(51)
        }
        self.operatingTimeGuideLabel.snp.makeConstraints {
            $0.top.equalTo(self.operatingTimeTextField.underline.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.savedOperatingTimeLabel.snp.makeConstraints {
            $0.top.equalTo(self.operatingTimeGuideLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        self.operatingTimeCheckImage.snp.makeConstraints {
            $0.centerY.equalTo(self.savedOperatingTimeLabel).offset(2)
            $0.leading.equalTo(self.savedOperatingTimeLabel.snp.trailing).offset(6)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func subscribeUI() {
        self.operatingTimeTextField.textField.rx.controlEvent(.touchDown)
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                owner.presentTimePicker()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindUI() {
        self.timeSubject
            .withUnretained(self)
            .subscribe(onNext: { owner, time in
                owner.operatingTimeTextField.textField.text = time
            })
            .disposed(by: disposeBag)
    }
    
    private func presentTimePicker() {
        let timePicker = TimePickerViewController()
        timePicker.modalPresentationStyle = .overCurrentContext
        timePicker.modalTransitionStyle = .crossDissolve
        timePicker.timeSubject = self.timeSubject
        self.present(timePicker, animated: true)
    }
}
