//
//  NavigationTopBar.swift
//  CommonUI
//
//  Created by mincheol on 2022/09/25.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/*
 커스텀 네비게이션 바
 Ex) private let topBar = NavigationTopBar().then {
     $0.titleLabel.text = "타이틀" // 네비게이션 타이틀 추가
     $0.leftButton.setImage(UIImage(), for: .normal) // 왼쪽 버튼에 이미지 추가
     $0.rightButton.setImage(UIImage(), for: .normal) // 오른쪽 버튼에 이미지 추가
 }
 */

public final class NavigationTopBar: UIView {
    
    // MARK: Constants
    
    // TODO: 추후 Constraints 정해지면 변경 필요
    private enum Constants {
        static let insetsLeftButton: UIEdgeInsets = .init(top: 24, left: 0, bottom: 0, right: 0)
        static let insetsRightButton: UIEdgeInsets = .init(top: 24, left: 0, bottom: 0, right: 0)
        
        static let heightSelf: CGFloat = 48
        
        static let widthLeftButton: CGFloat = 24
        static let widthRightButton: CGFloat = 24
        
        static let offsetLeftLeftButton: CGFloat = 16
        static let offsetRightRightButton: CGFloat = 16
    }
    
    // MARK: UI Properties
    
    
    fileprivate enum Typo {
        // TODO: 추후 네비게이션 타이틀 라벨 Font 정해지면 변경 필요
        static let titleLabel = CoreTypo.Body2.style
            .byAdding(.color(CommonUIAsset.black.color))
    }
    
    public let leftButton = UIButton().then {
        $0.contentEdgeInsets = Constants.insetsLeftButton
    }
    
    public let titleLabel = UILabel()
    
    public let rightButton = UIButton().then {
        $0.contentEdgeInsets = Constants.insetsRightButton
    }
    
    
    public init() {
        super.init(frame: .zero)
        
        self.configureUI()
        self.setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [
            self.leftButton,
            self.titleLabel,
            self.rightButton
        ]
            .forEach(self.addSubview)
        
    }
    
    private func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Constants.heightSelf)
        }
        
        self.leftButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(Constants.widthLeftButton)
            $0.left.equalToSuperview().offset(Constants.offsetLeftLeftButton)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.rightButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.greaterThanOrEqualTo(Constants.widthRightButton)
            $0.right.equalToSuperview().offset(-Constants.offsetRightRightButton)
        }
    }
    
}

extension Reactive where Base: NavigationTopBar {
    
    var title: Binder<String?> {
        return Binder(self.base) { base, value in
            base.titleLabel.attributedText = value?.styled(with: NavigationTopBar.Typo.titleLabel)
        }
    }
    
    public var leftButtonDidTap: ControlEvent<Void> {
        return self.base.leftButton.rx.tap
    }
    
    public var rightButtonDidTap: ControlEvent<Void> {
        return self.base.rightButton.rx.tap
    }
}
