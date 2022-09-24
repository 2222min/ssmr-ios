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

public class UnderlineLabel: UILabel {
    
    private lazy var label = UILabel()
    
    // TODO: 색상 변경
    private let underline = UIView().then {
        $0.backgroundColor = CommonUIAsset.ponitColor.color
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
        self.bringSubviewToFront(label)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        underline.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.snp.bottom).offset(-11)
            $0.height.equalTo(14)
        }
    }
    
}

extension UnderlineLabel {
    public var labelText: String  {
        set {
            self.label.attributedText = newValue.styled(
                typo: .text24ExtraBold,
                byAdding: [.color(CommonUIAsset.black.color)]
            )
        }
        get {
            return self.label.text ?? ""
        }
    }
}
