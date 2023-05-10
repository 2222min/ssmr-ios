//
//  UIButtonExtension.swift
//  CommonUI
//
//  Created by 정건호 on 2022/11/10.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

extension UIButton {
    public func isSelectedToggleWithBorderColor() {
        self.isSelected.toggle()
        self.layer.borderColor = isSelected
        ? UIColor(asset: CommonUIAsset.pointColor)?.cgColor
        : UIColor(asset: CommonUIAsset.whiteGrey)?.cgColor
    }
}
