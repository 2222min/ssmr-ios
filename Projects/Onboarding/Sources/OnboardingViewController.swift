//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import CommonUI

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then


open class OnboardingViewController: BaseViewController {
    
    private let reactor: OnboardingReactor
   
    // MARK: Constants
    private enum Constants {
        static let firstTitleLabel = "반가워요".styled(
            typo: .text32ExtraBold,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let firstDescription = "여기는 땡리단길이에요!"
        
        static let secondTitleLabel = "빠르고 간편하게"
        static let secondDescription = "지도를 보고 지금 갈 곳을 선택해요."
        
        static let thirdTitleLabel = "스티커로 저장"
        static let thirdDescription = "마음에 드는 곳에 스티커 도장을 찍어 저장해요."
    }
    
    // MARK: Properties
    
    // MARK: UI Properties
    private let titleLabel = UILabel().then {
        $0.attributedText = Constants.firstTitleLabel
        
        
    }
    private let descriptionLabel = UILabel().then {
        $0.text = Constants.firstDescription
    }
    private let imageView = UIImageView().then {
        $0.image = OnboardingDemoAppAsset.onboarding1.image
    }
    
    // MARK: Initializing
    init(reactor: OnboardingReactor) {
        self.reactor = reactor
        super.init()
        self.bind(reactor: reactor)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    open override func configureUI() {
        super.configureUI()
        
        [
            self.titleLabel,
            self.descriptionLabel,
            self.imageView
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
    open override func setupConstraints() {
        super.setupConstraints()
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(96)
            $0.centerX.equalToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(84)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(214)
        }
    }
}

// MARK: ReactorBind
extension OnboardingViewController {
    func bind(reactor: OnboardingReactor) {
    }
}

// MARK: Action
extension OnboardingViewController {}

// MARK: State
extension OnboardingViewController {}

// MARK: Func
extension OnboardingViewController {
    public static func create() -> OnboardingViewController? {
        let onboardingReactor = OnboardingReactor()
        let onboardingVC = OnboardingViewController(reactor: onboardingReactor)
        
        return onboardingVC
    }
}
