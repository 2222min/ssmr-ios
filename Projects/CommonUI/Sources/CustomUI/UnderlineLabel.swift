//
//  UnderlineLabel.swift
//  CommonUITests
//
//  Created by 정건호 on 2022/09/14.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import SnapKit
import Then
import CommonUI

public class UnderlineLabel: UILabel {
    
    private let label = UILabel().then {
        $0.attributedText = Constants.labelStyle
    }
    
    private let underline = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        self.addSubview(label)
        self.addSubview(underline)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.trailing.equalToSuperview().inset(8)
        }
        
        underline.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalTo(label.snp.bottom)
            $0.height.equalTo(14)
        }
    }
    
    func congfigureText(text: String) {
        label.text = text
    }
}

private enum Constants {
    static let labelStyle = String().styled(
        typo: .text32ExtraBold,
        byAdding: [.color(CommonUIAsset.black.color)]
    )
}
