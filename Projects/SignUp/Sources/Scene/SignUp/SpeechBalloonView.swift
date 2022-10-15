//
//  SpeechBalloonView.swift
//  SignUp
//
//  Created by 정건호 on 2022/10/10.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import SnapKit

class SpeechBalloonView: UIView {
    private let backgroundImageView = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.speechBalloonImage)
    }
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        self.addSubview(backgroundImageView)
        self.addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.backgroundImageView.snp.makeConstraints {
            $0.width.equalTo(132)
            $0.height.equalTo(37)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(self.backgroundImageView).offset(5)
            $0.leading.trailing.equalTo(self.backgroundImageView).inset(8)
        }
    }
}
