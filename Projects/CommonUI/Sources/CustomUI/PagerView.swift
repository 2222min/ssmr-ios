//
//  PagerView.swift
//  CommonUI
//
//  Created by mincheol on 2022/09/24.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

/*
 private let pager = PagerView().then {
     $0.title = "타이틀" // pager 타이틀
     $0.changeColor(true) // pager 백그라운드 color 변경 true: 선택, false: 미선택
 }
 */

public final class PagerView: UIButton {
    
    // MARK: UI Properties
    private let pagerTitleLabel = UILabel()
    private let bottomLineView = UIView()
    
    
    // MARK: Properties
    public var title: NSAttributedString = .init() {
        didSet {
            self.pagerTitleLabel.attributedText = self.title
            setNeedsLayout()
        }
    }
    /// 선택 안됐을때 타이틀 색상
    public var normalTitleColor: UIColor = CommonUIAsset.grey.color
    /// 선택 안됐을때 바텀라인 색상
    public var normalBottomLineColor: UIColor = CommonUIAsset.whiteGrey.color
    /// 선택 됐을때 타이틀 색상
    public var selectedTitleColor: UIColor = .black
    /// 선택 됐을때 바텀라인 색상
    public var selectedBottomLineColor: UIColor = CommonUIAsset.pointColor.color
    
    public init() {
        super.init(frame: .zero)
        
        self.configureUI()
        self.setConstraints()
        self.changeColor()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [
            self.pagerTitleLabel,
            self.bottomLineView
        ]
            .forEach(self.addSubview)
    }
    
    private func setConstraints() {
        self.pagerTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(24)
        }
        self.bottomLineView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 50
        
        return size
    }
}

// MARK: - Func

extension PagerView {
    public func changeColor(_ isSeleced: Bool = false) {
        switch isSeleced {
        case false:
            self.bottomLineView.backgroundColor = self.normalBottomLineColor
            self.pagerTitleLabel.textColor = self.normalTitleColor
        case true:
            self.bottomLineView.backgroundColor = self.selectedBottomLineColor
            self.pagerTitleLabel.textColor = self.selectedTitleColor
        }
    }
}
