//
//  ResultSearchView.swift
//  Presentation
//
//  Created by mincheol on 2023/04/11.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import Then
import SnapKit
import CommonUI

class ResultSearchView: UIView {
    
    // MARK: UIProperties
//    private let collectionView: UICollectionView = UICollectionView()
    
    init() {
        super.init(frame: .zero)
        
        self.configureUI()
        self.setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
//        self.addSubview(self.collectionView)
    }
    
    private func setConstraints() {
//        self.collectionView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
}

