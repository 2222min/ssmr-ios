//
//  SectionEViewController.swift
//  HomePresentation
//
//  Created by 정건호 on 2023/04/24.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI

class UsageSectionViewController: BaseViewController {

    private let uiView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let usageLabel = UILabel().then {
        let attributedString = NSMutableAttributedString(string: "땡리단길 ")
        attributedString.append(NSAttributedString(
            string: "사용법",
            attributes: [NSAttributedString.Key.foregroundColor: CommonUIAsset.pointColor.color])
        )
        $0.attributedText = attributedString
    }
    
    private let guideLabel = UILabel().then {
        $0.text = "땡리단길이 아직 어려우신가요?\n이거 하나면 땡리단길은 마스터! 얼른 읽으러 가보실까요? 🙌"
        $0.numberOfLines = 2
        $0.textColor = CommonUIAsset.deepGrey.color
    }
    
    private let readButton = UIButton().then {
        $0.setTitle("읽으러 가기", for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .normal)
        $0.setTitleColor(CommonUIAsset.cream.color, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        self.view.addSubview(uiView)
        self.uiView.addSubview(usageLabel)
        self.uiView.addSubview(guideLabel)
        self.uiView.addSubview(readButton)
    }
    
    override func setupConstraints() {
        self.uiView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
        self.usageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(24)
        }
        self.guideLabel.snp.makeConstraints {
            $0.top.equalTo(self.usageLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        self.readButton.snp.makeConstraints {
            $0.top.equalTo(self.guideLabel.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            $0.width.equalTo(126)
        }
    }
}
