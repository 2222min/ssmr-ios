//
//  RightImageButton.swift
//  CommonUI
//
//  Created by 정건호 on 2022/11/06.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

/*
 오른쪽에 이미지 왼쪽에 라벨이 있는 UI
 
 Ex) let button = RightImageButton().then {
  Propertis Setting:
    Button State - Normal
        $0.normalTitle = NSAttributedString()
        $0.normalImage = UIImage()
    Button State - Selected
        $0.selectedTitle = NSAttributedString()
        $0.seletedImage = UIImage()
 }
 */

public final class RightImageButton: UIButton {
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
    
    public var selectedImage: UIImage = .init() {
        didSet {
            self.setImage(self.selectedImage, for: .selected)
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
        self.titleLabel?.numberOfLines = 0
        self.contentHorizontalAlignment = .leading
        self.contentVerticalAlignment = .top
        self.semanticContentAttribute = .forceRightToLeft
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

