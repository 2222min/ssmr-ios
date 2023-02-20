//
//  RegiBusinessPage.swift
//  RegisterBusiness
//
//  Created by 정건호 on 2023/02/20.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import SnapKit
import CommonUI

public class RegiBusinessPage: UIStackView {
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 9
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        self.addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func makePage(pageNumber: Int, currentPage: Int) {
        for number in 1...pageNumber {
            let numberCircle = UIButton().then {
                $0.isEnabled = false
                $0.layer.cornerRadius = 10
                $0.setTitle(String(number), for: .normal)
                $0.titleLabel?.font = CoreTypo.ButtomSmall.style.font
                $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 1, right: 0)
                $0.setTitleColor(
                    number == currentPage ? .white : CommonUIAsset.grey.color,
                    for: .normal
                )
                $0.backgroundColor = number == currentPage
                ? CommonUIAsset.pointColor.color
                : CommonUIAsset.whiteGrey.color
            }
            numberCircle.snp.makeConstraints {
                $0.height.equalTo(20)
                $0.width.equalTo(20)
            }
            stackView.addArrangedSubview(numberCircle)
        }
    }
}
