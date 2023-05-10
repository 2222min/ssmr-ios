//
//  BaseCollectionViewCell.swift
//  CommonUI
//
//  Created by mincheol on 2022/09/15.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

import RxSwift

open class BaseCollectionViewCell: UICollectionViewCell {
    
    private(set) var didSetupConstraints = false
    public var disposeBag = DisposeBag()
    
    var converCellSzie: CGFloat {
        return min(UIScreen.main.bounds.width, 375)
    }
    
    // MARK: Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: Func
    
    public override func updateConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    public func configure() {
        self.setNeedsUpdateConstraints()
    }
    
    open func configureUI() {
        self.contentView.backgroundColor = .white
    }
    
    open func setupConstraints() {}
}

