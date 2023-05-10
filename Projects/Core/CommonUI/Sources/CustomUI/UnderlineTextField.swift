//
//  UnderlineTextField.swift
//  CommonUI
//
//  Created by 정건호 on 2022/09/30.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import RxCocoa

/*
 밑줄이 있는 TextField
 
 Ex) let underlineTextField = UnderlineTextField().then {
    // TextField's placeHolder
    $0.textField.attributedPlaceholder = Constants.placeHolder
 }
 
 // height 값을 할당해줘야 TextField 사용 가능
 businessNumberTextField.snp.makeConstraints {
    $0.height.equalTo(24)
 }
 */

public class UnderlineTextField: UIView {
    
    public let textField = UITextField().then {
        $0.textColor = CommonUIAsset.black.color
    }
    
    public let underline = UIView().then {
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
        addSubview(textField)
        addSubview(underline)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        underline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(4)
        }
    }
    
    public func setTextFieldHeight(height: CGFloat) {
        textField.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
    public func setUnderlineHeight(height: CGFloat) {
        underline.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
}

