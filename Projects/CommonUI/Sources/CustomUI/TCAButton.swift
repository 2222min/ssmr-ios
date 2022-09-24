//
//  TCAButton.swift
//  CommonUI
//
//  Created by mincheol on 2022/09/16.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

public class TCAButton: UIButton {
    public var title: String = "" {
        didSet {
            let attributedString = self.setTitleLabel(self.title)
            self.setAttributedTitle(attributedString, for: .normal)
            setNeedsLayout()
        }
    }
    
    public init() {
      super.init(frame: .zero)
        self.backgroundColor = CommonUIAsset.ponitColor.color
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitleLabel(_ title: String) -> NSAttributedString {
        return title.styled(
            typo: .ButtonLarge,
            byAdding: [.color(.white)]
        )
    }
}
