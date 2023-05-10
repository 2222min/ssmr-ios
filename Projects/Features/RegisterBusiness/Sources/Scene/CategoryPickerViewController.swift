//
//  CategoryPickerViewController.swift
//  RegisterBusiness
//
//  Created by 정건호 on 2022/11/09.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift
import RxCocoa

class CategoryPickerViewController: BaseViewController {
    
    // MARK: Properties
    private var pickerTest = [String]()
    var pickerSubject = PublishSubject<String>()
    private var selectedPickerText = String()
    
    // MARK: UI Properties
    private let uiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }
    public let categoryLabel = UILabel()
    
    private let picker = UIPickerView()
    
    private let confirmButton = CTAButton().then {
        $0.title = "완료"
    }
    
    override func configureUI() {
        self.view.backgroundColor = UIColor(red: 0.43, green: 0.43, blue: 0.43, alpha: 0.5)
        
        self.view.addSubview(uiView)
        self.uiView.addSubview(categoryLabel)
        self.uiView.addSubview(picker)
        self.uiView.addSubview(confirmButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        subscribeUI()
        
        pickerTest = ["음식점", "문화/예술", "스포츠/레저", "오락", "테마파크"]
        selectedPickerText = pickerTest[0]
    }
    
    override func setupConstraints() {
        self.uiView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(340)
        }
        self.categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
        }
        self.picker.snp.makeConstraints {
            $0.top.equalTo(self.categoryLabel.snp.bottom)
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
    
    override func subscribeUI() {
        super.subscribeUI()
        confirmButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.pickerSubject.onNext(owner.selectedPickerText)
                owner.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    public func setTitle(_ title: String) {
        self.categoryLabel.attributedText = title.styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.pointColor.color)]
        )
    }
}

extension CategoryPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerTest.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerTest[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 34
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPickerText = pickerTest[row]
    }
}
