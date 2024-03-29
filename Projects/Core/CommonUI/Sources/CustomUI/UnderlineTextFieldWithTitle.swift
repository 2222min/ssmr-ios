//
//  UnderlineTextFieldWithTitle.swift
//  CommonUI
//
//  Created by 정건호 on 2022/09/20.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import RxCocoa

/*
 타이틀과 밑줄이 있는 TextField
 
 Ex) let underlineTextField = UnderlineTextFieldWithTitle().then {
    $0.title.attributedText = Constants.title
    $0.textField.attributedPlaceholder = Constants.placeHolder
 }
 
 // height 값을 할당해줘야 TextField 사용 가능
 underlineTextField.snp.makeConstraints {
    $0.height.equalTo(73)
 }
 */

public class UnderlineTextFieldWithTitle: UIView {
    public let title = UILabel().then {
        $0.textColor = CommonUIAsset.blackGrey.color
    }
    
    public let textField = UITextField().then {
        $0.textColor = CommonUIAsset.black.color
    }
    
    private let underline = UIView().then {
        $0.backgroundColor = CommonUIAsset.whiteGrey.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(title)
        addSubview(textField)
        addSubview(underline)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        title.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(28)
            $0.leading.trailing.equalToSuperview()
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(self.title.snp.bottom).offset(16)
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        underline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(4)
        }
    }
}
