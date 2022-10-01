//
//  LeftImageButton.swift
//  CommonUI
//
//  Created by mincheol on 2022/09/24.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

public final class LeftImageButton: UIButton {
    public var normalTitle: NSAttributedString = .init() {
        didSet {
            self.setAttributedTitle(self.normalTitle, for: .normal)
            setNeedsLayout()
        }
    }
    
    public var selectedTitle: NSAttributedString = .init() {
        didSet {
            self.setAttributedTitle(self.selectedTitle, for: .selected)
            setNeedsLayout()
        }
    }
    
    public var normalImage: UIImage = .init() {
        didSet {
            self.setImage(self.normalImage, for: .normal)
            setNeedsLayout()
        }
    }
    
    public var seletedImage: UIImage = .init() {
        didSet {
            self.setImage(self.seletedImage, for: .selected)
            setNeedsLayout()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        self.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.lineBreakMode = .byTruncatingTail
        self.contentHorizontalAlignment = .leading
        self.contentVerticalAlignment = .top

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

