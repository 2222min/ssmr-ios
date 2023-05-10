//
//  SectionCViewController.swift
//  HomePresentation
//
//  Created by 정건호 on 2023/04/24.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI

class SectionCViewController: BaseViewController {

    private let uiView = UIView().then {
        $0.backgroundColor = .yellow
    }
    private let label = UILabel().then {
        $0.text = "사장님's PICK 리뷰왕"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        self.view.addSubview(uiView)
        self.uiView.addSubview(label)
    }
    
    override func setupConstraints() {
        self.uiView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
        self.label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
