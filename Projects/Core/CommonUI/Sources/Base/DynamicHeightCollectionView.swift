//
//  DynamicHeightCollectionView.swift
//  CommonUI
//
//  Created by mincheol on 2023/03/25.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

public class DynamicHeightCollectionView: UICollectionView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
            // 스크롤이 안되는 경우 -> invalidateIntrinsicContentSize()를 호출
            // 컨텐츠 사이즈를 전체 크기로 변경
        if bounds.size != self.intrinsicContentSize && !self.isScrollEnabled {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
