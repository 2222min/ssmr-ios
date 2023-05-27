//
//  SerachButton.swift
//  CommonUI
//
//  Created by mincheol on 2023/05/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

public class SerachButton: UIView {
    
    // MARK: Properties
    
    public var placeholder: String? {
        didSet {
            self.searchButtonTextFiled.attributedPlaceholder = placeholder?.styled(typo: .DDaengMB2, byAdding: [.color(CommonUIAsset.grey.color), .maximumLineHeight(19.89), .minimumLineHeight(19.89)])
        }
    }
    
    // MARK: UIProperties
    
    private let container = UIView().then {
        $0.layer.cornerRadius = 25
        $0.layer.borderColor = CommonUIAsset.pointColor.color.cgColor
        $0.layer.borderWidth = 2
    }
    
    fileprivate let searchButton: UIButton = UIButton().then {
        $0.backgroundColor = .white
    }
    private let searchButtonImage: UIImageView = UIImageView().then {
        $0.image = CommonUIAsset.search.image
    }
    fileprivate let searchButtonTextFiled: UITextField = UITextField()
    
    public init() {
        super.init(frame: .zero)
        
        self.configureUI()
        self.setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(self.container)
        [
            self.searchButtonImage,
            self.searchButtonTextFiled
        ]
            .forEach {
                self.searchButton.addSubview($0)
            }
        
        [
            self.searchButton
        ]
            .forEach {
                self.container.addSubview($0)
            }
        
    }
    
    private func setConstraints() {
        self.container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.searchButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        self.searchButtonImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        self.searchButtonTextFiled.snp.makeConstraints {
            $0.leading.equalTo(self.searchButtonImage.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
}
