//
//  UnderlineTextField.swift
//  CommonUI
//
//  Created by 정건호 on 2022/09/20.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import RxCocoa

public class UnderlineTextField: UIView {
    public let textField = UITextField().then {
        $0.clearButtonMode = .whileEditing
        $0.textColor = CommonUIAsset.black.color
        $0.attributedPlaceholder = NSAttributedString(
            string: String(),
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.red]
        )
    }
    
    let underline = UIView().then {
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
        self.isUserInteractionEnabled = true
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
}