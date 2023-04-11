//
//  SerachTopBar.swift
//  Presentation
//
//  Created by mincheol on 2023/04/01.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift
import RxCocoa

class SerachTopBar: UIView {
    
    // MARK: Properties
    
    var deleteButtonIsHidden: Bool = true {
        didSet {
            self.deleteButton.isHidden = deleteButtonIsHidden
        }
    }
    
    var textFieldIsEnabled: Bool = true {
        didSet {
            self.searchButtonTextFiled.isEnabled = textFieldIsEnabled
        }
    }
    
    var borderWidth: CGFloat = 0 {
        didSet {
            self.searchButton.layer.borderWidth = borderWidth
        }
    }
    
    var borderColor: CGColor? {
        didSet {
            self.searchButton.layer.borderColor = borderColor
        }
    }
    
    // MARK: UIProperties
    
    private let container = UIView()
    fileprivate let backButton: UIButton = UIButton().then {
        $0.setImage(CommonUIAsset.chevronLeft.image, for: .normal)
    }
    fileprivate let searchButton: UIButton = UIButton().then {
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .white
    }
    private let searchButtonImage: UIImageView = UIImageView().then {
        $0.image = CommonUIAsset.search.image
    }
    fileprivate let searchButtonTextFiled: UITextField = UITextField().then {
        $0.attributedPlaceholder = "점포 이름, 메뉴를 검색하세요.".styled(typo: .DDaengMB2, byAdding: [.color(CommonUIAsset.grey.color), .maximumLineHeight(19.89), .minimumLineHeight(19.89)])
    }
    private let deleteButton: UIButton = UIButton().then {
        $0.setImage(CommonUIAsset.searchClose.image, for: .normal)
        $0.isHidden = true
    }
    init() {
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
            self.searchButtonTextFiled,
            self.deleteButton
        ]
            .forEach {
                self.searchButton.addSubview($0)
            }
        
        [
            self.backButton,
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
        self.backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(23)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        self.searchButton.snp.makeConstraints {
            $0.leading.equalTo(self.backButton.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(19)
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        self.searchButtonImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        self.searchButtonTextFiled.snp.makeConstraints {
            $0.leading.equalTo(self.searchButtonImage.snp.trailing).offset(10)
            $0.trailing.equalTo(self.deleteButton.snp.leading).offset(10)
            $0.centerY.equalToSuperview()
        }
        self.deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
}

extension Reactive where Base: SerachTopBar {
    
    var searchButtonDidTap: ControlEvent<Void> {
        return self.base.searchButton.rx.tap
    }
    
    var backButtonDidTap: ControlEvent<Void> {
        return self.base.backButton.rx.tap
    }
    
    var textFieldIsEditing: ControlProperty<String?> {
        return self.base.searchButtonTextFiled.rx.controlProperty(
            editingEvents: [.editingChanged, .valueChanged],
            getter: { textField in
                textField.text
            }, setter: { textField, value in
                if textField.text != value {
                    textField.text = value
                }
            })
        
    }
}
