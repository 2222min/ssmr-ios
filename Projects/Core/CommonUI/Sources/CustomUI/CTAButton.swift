//
//  CTAButton.swift
//  CommonUI
//
//  Created by mincheol on 2022/09/16.
//  Copyright © 2022 team.io. All rights reserved.
//

import Util
import UIKit

/*
 Ex) let button = CTAButton().then {
    $0.title = "버튼 타이틀" // 타이틀만 변경해서 사용하면 됨
    $0.isEnabled = false // disabled 의 경우
 }
 */


public class CTAButton: UIButton {
    public var title: String = "" {
        didSet {
            let attributedString = self.setTitleLabel(self.title)
            self.setAttributedTitle(attributedString, for: .normal)
            setNeedsLayout()
        }
    }
    
    public init() {
      super.init(frame: .zero)
        self.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .normal)
        self.setBackgroundColor(color: CommonUIAsset.grey.color, forState: .disabled)
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override public var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 48
        
        return size
    }
    
    private func setTitleLabel(_ title: String) -> NSAttributedString {
        return title.styled(
            typo: .Body2,
            byAdding: [.color(.white)]
        )
    }
}
