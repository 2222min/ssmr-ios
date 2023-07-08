//
//  TimePickerViewController.swift
//  RegisterBusiness
//
//  Created by 정건호 on 2022/11/26.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift
import Then

class TimePickerViewController: BaseViewController {
    
    // MARK: Constants
    private enum Constants {
        static let operatingTimeLabelText = "운영시간".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let offDayButtonNormalText = "휴무".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let offDayButtonSelectedText = "휴무".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let openLabelText = "OPEN".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let closeLabelText = "CLOSE".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let completionButtonText = "완료".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
    }
    
    // MARK: Properties
    private let uiViewWidth = UIScreen.main.bounds.width - 58
    var timeSubject = PublishSubject<String>()
    
    // MARK: UI Properties
    private let uiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    private let operatingTimeLabel = UILabel().then {
        $0.attributedText = Constants.operatingTimeLabelText
    }
    private let offDayButton = LeftImageButton().then {
        $0.normalImage = CommonUIAsset.disapproveImage.image
        $0.normalTitle = Constants.offDayButtonNormalText
        $0.selectedImage = CommonUIAsset.approveImage.image.withTintColor(CommonUIAsset.pointColor.color)
        $0.selectedTitle = Constants.offDayButtonSelectedText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let openLabel = UILabel().then {
        $0.attributedText = Constants.openLabelText
    }
    private let openTimePicker = UIDatePicker().then {
        $0.datePickerMode = .time
        $0.preferredDatePickerStyle = .wheels
        $0.minuteInterval = 30
        $0.locale = NSLocale(localeIdentifier: "en_GB") as Locale
    }
    private let openStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
    }
    private let closeTimePicker = UIDatePicker().then {
        $0.datePickerMode = .time
        $0.preferredDatePickerStyle = .wheels
        $0.minuteInterval = 30
        $0.locale = NSLocale(localeIdentifier: "en_GB") as Locale
    }
    private let closeLabel = UILabel().then {
        $0.attributedText = Constants.closeLabelText
    }
    private let closeStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
    }
    private let timeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
    }
    private let openEmptyView = UIImageView().then {
        $0.image = CommonUIAsset.noTimeImage.image
        $0.isHidden = true
    }
    private let closeEmptyView = UIImageView().then {
        $0.image = CommonUIAsset.noTimeImage.image
        $0.isHidden = true
    }
    private let completionButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.completionButtonText,
            for: .normal
        )
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
        self.view.backgroundColor = UIColor(red: 0.43, green: 0.43, blue: 0.43, alpha: 0.5)
    }
    
    override func configureUI() {
        [
            self.openLabel,
            self.openTimePicker
        ]
            .forEach(self.openStackView.addArrangedSubview)
        
        [
            self.closeLabel,
            self.closeTimePicker
        ]
            .forEach(self.closeStackView.addArrangedSubview)
        
        [
            self.openStackView,
            self.closeStackView
        ]
            .forEach(self.timeStackView.addArrangedSubview)
        
        [
            self.operatingTimeLabel,
            self.offDayButton,
            self.timeStackView,
            self.openEmptyView,
            self.closeEmptyView,
            self.completionButton
        ]
            .forEach(self.uiView.addSubview)
        self.view.addSubview(self.uiView)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        let spacing = (uiViewWidth - 200) / 3
        
        self.uiView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(338)
            $0.leading.trailing.equalToSuperview().inset(29)
        }
        self.operatingTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.centerX.equalToSuperview()
        }
        self.offDayButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-16)
        }
        self.openStackView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(135)
        }
        self.closeStackView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(135)
        }
        self.timeStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(spacing)
            $0.top.equalTo(self.operatingTimeLabel.snp.bottom).offset(48)
        }
        self.openEmptyView.snp.makeConstraints {
            $0.centerX.equalTo(self.openLabel)
            $0.top.equalTo(self.openLabel.snp.bottom).offset(16)
        }
        self.closeEmptyView.snp.makeConstraints {
            $0.centerX.equalTo(self.closeLabel)
            $0.top.equalTo(self.closeLabel.snp.bottom).offset(16)
        }
        self.completionButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().offset(-9)
        }
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        Observable.combineLatest(
            self.openTimePicker.rx.value,
            self.closeTimePicker.rx.value
        )
        .withUnretained(self)
        .subscribe(onNext: { owner, dates in
            owner.completionButton.isEnabled = dates.0 < dates.1
        })
        .disposed(by: disposeBag)
        
        self.completionButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner , _ in
                let time = owner.offDayButton.isSelected ? "휴무" : owner.operatingTimeToString()
                owner.timeSubject.onNext(time)
                owner.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        self.offDayButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.offDayButton.isSelected.toggle()
                owner.hideTimePicker(owner.offDayButton.isSelected)
//                owner.completionButton.isEnabled = true
                if owner.offDayButton.isSelected {
                    owner.completionButton.isEnabled = true
                } else {
                    owner.completionButton.isEnabled = owner.openTimePicker.date < owner.closeTimePicker.date
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func operatingTimeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: openTimePicker.date) + " - "
        + dateFormatter.string(from: closeTimePicker.date)
    }
    
    private func hideTimePicker(_ isHidden: Bool) {
        let stackViewHeight = isHidden ? 16 : 135
        self.openTimePicker.isHidden = isHidden
        self.closeTimePicker.isHidden = isHidden
        self.openEmptyView.isHidden = !isHidden
        self.closeEmptyView.isHidden = !isHidden
        
        self.openStackView.snp.updateConstraints {
            $0.height.equalTo(stackViewHeight)
        }
        self.closeStackView.snp.updateConstraints {
            $0.height.equalTo(stackViewHeight)
        }
    }
}
