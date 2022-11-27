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
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let offDayButtonNormalText = "휴무".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let offDayButtonSelectedText = "휴무".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let openLabelText = "OPEN".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let closeLabelText = "CLOSE".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
        static let completionButtonText = "완료".styled(
            typo: .ButtonLarge,
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
        $0.normalImage = UIImage(asset: CommonUIAsset.disapproveImage) ?? UIImage()
        $0.normalTitle = Constants.offDayButtonNormalText
        $0.selectedImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
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
        self.completionButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().offset(-9)
        }
    }
    
    private func subscribeUI() {
        self.completionButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner , _ in
                owner.timeSubject.onNext(owner.operatingTimeToString())
                owner.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func operatingTimeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: openTimePicker.date) + " - "
        + dateFormatter.string(from: closeTimePicker.date)
    }
}
