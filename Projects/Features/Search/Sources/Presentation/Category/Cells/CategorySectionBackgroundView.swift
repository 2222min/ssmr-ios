//
//  CategorySectionBackgroundView.swift
//  Presentation
//
//  Created by mincheol on 2023/04/10.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI

class CategorySectionBackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = CommonUIAsset.cream.color
    }
    
}
