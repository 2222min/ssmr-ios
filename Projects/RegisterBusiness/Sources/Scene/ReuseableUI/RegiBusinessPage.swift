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
        let numberCircles = (1...pageNumber).map { number -> UIButton in
            let button = UIButton()
            button.isEnabled = false
            button.layer.cornerRadius = 10
            button.setTitle(String(number), for: .normal)
            button.titleLabel?.font = CoreTypo.ButtomSmall.style.font
            button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 1, right: 0)
            button.setTitleColor(
                number == currentPage ? .white : CommonUIAsset.grey.color,
                for: .normal
            )
            button.backgroundColor = number == currentPage
                ? CommonUIAsset.pointColor.color
                : CommonUIAsset.whiteGrey.color
            button.snp.makeConstraints {
                $0.height.equalTo(20)
                $0.width.equalTo(20)
            }
            return button
        }
        numberCircles.forEach { stackView.addArrangedSubview($0) }
    }
}
