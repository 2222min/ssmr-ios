//
//  DatePickerView.swift
//  SignUp
//
//  Created by 정건호 on 2022/10/10.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

class DatePickerView: UIView {
    let datePicker = UIDatePicker()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        self.addSubview(datePicker)
        setupConstraints()
    }
    
    private func setupConstraints() {
        datePicker.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
