//
//  DatePickerViewController.swift
//  SignUp
//
//  Created by 정건호 on 2022/10/15.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift
import RxCocoa

class DatePickerViewController: BaseViewController {
    
    // MARK: Properties
    var dateSubject = PublishSubject<String>()
    
    // MARK: UI Properties
    private let uiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }
    private let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko")
    }
    private let confirmButton = CTAButton().then {
        $0.title = "완료"
    }
    
    override func configureUI() {
        self.view.backgroundColor = UIColor(red: 0.43, green: 0.43, blue: 0.43, alpha: 0.5)
        
        self.view.addSubview(uiView)
        self.uiView.addSubview(datePicker)
        self.uiView.addSubview(confirmButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeUI()
    }
    
    override func setupConstraints() {
        self.uiView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(320)
        }
        
        self.datePicker.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.confirmButton.snp.top).offset(-12)
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    func subscribeUI() {
        confirmButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dateSubject.onNext(owner.dateToString(date: owner.datePicker.date))
                owner.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
