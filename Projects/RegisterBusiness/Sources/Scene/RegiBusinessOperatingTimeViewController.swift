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
        static let savedOperatingTimeLabelSelectedText = "저장된 운영시간 (모든 요일 필수)".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
    }
    
    // MARK: Properties
    
    // index 0 -> 월, index 6 -> 일
    private var selectedDays = [false, false, false, false, false, false, false]
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
        $0.setBackgroundColor(color: CommonUIAsset.whiteGrey.color, forState: .disabled)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
        $0.isEnabled = false
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
        $0.selectedImage = UIImage(asset: CommonUIAsset.watchImage)?.withTintColor(CommonUIAsset.deepGrey.color) ?? UIImage()
        $0.selectedTitle = Constants.savedOperatingTimeLabelSelectedText
        $0.imageEdgeInsets = .init(top: 2, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
//    private let operatingTimeCheckImage = UIImageView().then {
//        $0.image = UIImage(asset: CommonUIAsset.diceImage)?
//            .withTintColor(CommonUIAsset.grey.color, renderingMode: .alwaysOriginal)
//    }
    private let operatingTimeCheckImage = UIButton().then {
        $0.setImage(CommonUIAsset.approveImage.image.withTintColor(CommonUIAsset.grey.color), for: .normal)
        $0.setImage(CommonUIAsset.approveImage.image.withTintColor(CommonUIAsset.pointColor.color), for: .selected)
    }
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
        $0.isEnabled = false
    }
    private let monLabel = UILabel().then {
        $0.text = "월"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let tueLabel = UILabel().then {
        $0.text = "화"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let wedLabel = UILabel().then {
        $0.text = "수"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let thuLabel = UILabel().then {
        $0.text = "목"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let friLabel = UILabel().then {
        $0.text = "금"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let satLabel = UILabel().then {
        $0.text = "토"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let sunLabel = UILabel().then {
        $0.text = "일"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let monTime = UILabel().then {
        $0.text = "없음"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let tueTime = UILabel().then {
        $0.text = "없음"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let wedTime = UILabel().then {
        $0.text = "없음"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let thuTime = UILabel().then {
        $0.text = "없음"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let friTime = UILabel().then {
        $0.text = "없음"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let satTime = UILabel().then {
        $0.text = "없음"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    private let sunTime = UILabel().then {
        $0.text = "없음"
        $0.font = CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        $0.textColor = CommonUIAsset.grey.color
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
        bindUI()
    }
    
    override func configureUI() {
        super.configureUI()
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
            self.nextButton,
            self.monLabel,
            self.tueLabel,
            self.wedLabel,
            self.thuLabel,
            self.friLabel,
            self.satLabel,
            self.sunLabel,
            self.monTime,
            self.tueTime,
            self.wedTime,
            self.thuTime,
            self.friTime,
            self.satTime,
            self.sunTime
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
        self.monLabel.snp.makeConstraints {
            $0.top.equalTo(self.savedOperatingTimeLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(40)
        }
        self.tueLabel.snp.makeConstraints {
            $0.top.equalTo(self.monLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(40)
        }
        self.wedLabel.snp.makeConstraints {
            $0.top.equalTo(self.tueLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(40)
        }
        self.thuLabel.snp.makeConstraints {
            $0.top.equalTo(self.wedLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(40)
        }
        self.friLabel.snp.makeConstraints {
            $0.top.equalTo(self.thuLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(40)
        }
        self.satLabel.snp.makeConstraints {
            $0.top.equalTo(self.friLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(40)
        }
        self.sunLabel.snp.makeConstraints {
            $0.top.equalTo(self.satLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(40)
        }
        self.monTime.snp.makeConstraints {
            $0.top.equalTo(self.savedOperatingTimeLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.monLabel.snp.trailing).offset(8)
        }
        self.tueTime.snp.makeConstraints {
            $0.top.equalTo(self.monTime.snp.bottom).offset(4)
            $0.leading.equalTo(self.tueLabel.snp.trailing).offset(8)
        }
        self.wedTime.snp.makeConstraints {
            $0.top.equalTo(self.tueTime.snp.bottom).offset(4)
            $0.leading.equalTo(self.wedLabel.snp.trailing).offset(8)
        }
        self.thuTime.snp.makeConstraints {
            $0.top.equalTo(self.wedTime.snp.bottom).offset(4)
            $0.leading.equalTo(self.thuLabel.snp.trailing).offset(8)
        }
        self.friTime.snp.makeConstraints {
            $0.top.equalTo(self.thuTime.snp.bottom).offset(4)
            $0.leading.equalTo(self.friLabel.snp.trailing).offset(8)
        }
        self.satTime.snp.makeConstraints {
            $0.top.equalTo(self.friTime.snp.bottom).offset(4)
            $0.leading.equalTo(self.satLabel.snp.trailing).offset(8)
        }
        self.sunTime.snp.makeConstraints {
            $0.top.equalTo(self.satTime.snp.bottom).offset(4)
            $0.leading.equalTo(self.sunLabel.snp.trailing).offset(8)
        }
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        self.operatingTimeTextField.textField.rx.controlEvent(.touchDown)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.presentTimePicker()
            })
            .disposed(by: disposeBag)
        
        self.monButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.monButton.isSelected.toggle()
                owner.selectedDays[0] = owner.monButton.isSelected
            })
            .disposed(by: disposeBag)
        
        self.tueButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.tueButton.isSelected.toggle()
                owner.selectedDays[1] = owner.tueButton.isSelected
            })
            .disposed(by: disposeBag)
        
        self.wedButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.wedButton.isSelected.toggle()
                owner.selectedDays[2] = owner.wedButton.isSelected
            })
            .disposed(by: disposeBag)
        
        self.thuButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.thuButton.isSelected.toggle()
                owner.selectedDays[3] = owner.thuButton.isSelected
            })
            .disposed(by: disposeBag)
        
        self.friButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.friButton.isSelected.toggle()
                owner.selectedDays[4] = owner.friButton.isSelected
            })
            .disposed(by: disposeBag)
        
        self.satButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.satButton.isSelected.toggle()
                owner.selectedDays[5] = owner.satButton.isSelected
            })
            .disposed(by: disposeBag)
        
        self.sunButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.sunButton.isSelected.toggle()
                owner.selectedDays[6] = owner.sunButton.isSelected
            })
            .disposed(by: disposeBag)
        
        self.saveButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.savedOperatingTimeLabel.isSelected = true
                owner.setDayTimeLabel()
                owner.operatingTimeTextField.textField.text = String()
                owner.saveButton.isEnabled = false
                owner.initDayButton()
                if owner.setTimeIsDone() {
                    self.operatingTimeCheckImage.isSelected = true
                    self.nextButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindUI() {
        self.timeSubject
            .withUnretained(self)
            .subscribe(onNext: { owner, time in
                owner.operatingTimeTextField.textField.text = time
                owner.saveButton.isEnabled = !time.isEmpty
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
    
    private func initDayButton() {
        self.monButton.isSelected = false
        self.tueButton.isSelected = false
        self.wedButton.isSelected = false
        self.thuButton.isSelected = false
        self.friButton.isSelected = false
        self.satButton.isSelected = false
        self.sunButton.isSelected = false
        self.selectedDays = [false, false, false, false, false, false, false]
    }
    
    private func setDayTimeLabel() {
        let timeText = self.operatingTimeTextField.textField.text
        let labelColor = timeText == "휴무" ? CommonUIAsset.mRed.color : CommonUIAsset.deepGrey.color
        for (index, value) in self.selectedDays.enumerated() {
            if value == true {
                switch index {
                case 0:
                    self.monTime.text = timeText
                    self.monTime.textColor = labelColor
                    self.monLabel.textColor = CommonUIAsset.deepGrey.color
                case 1:
                    self.tueTime.text = timeText
                    self.tueTime.textColor = labelColor
                    self.tueLabel.textColor = CommonUIAsset.deepGrey.color
                case 2:
                    self.wedTime.text = timeText
                    self.wedTime.textColor = labelColor
                    self.wedLabel.textColor = CommonUIAsset.deepGrey.color
                case 3:
                    self.thuTime.text = timeText
                    self.thuTime.textColor = labelColor
                    self.thuLabel.textColor = CommonUIAsset.deepGrey.color
                case 4:
                    self.friTime.text = timeText
                    self.friTime.textColor = labelColor
                    self.friLabel.textColor = CommonUIAsset.deepGrey.color
                case 5:
                    self.satTime.text = timeText
                    self.satTime.textColor = labelColor
                    self.satLabel.textColor = CommonUIAsset.deepGrey.color
                case 6:
                    self.sunTime.text = timeText
                    self.sunTime.textColor = labelColor
                    self.sunLabel.textColor = CommonUIAsset.deepGrey.color
                default:
                    break
                }
            }
        }
    }
    
    private func setTimeIsDone() -> Bool {
        var isDone = true
        let timeLabels = [monTime, tueTime, wedTime, thuTime, friTime, satTime, sunTime]
        timeLabels.forEach {
            if $0.text == "없음" {
                isDone = false
            }
        }
        return isDone
    }
}
