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
	private enum Constants { }

	// MARK: Properties
	
	// MARK: UI Properties
    private let imageView = UIImageView().then {
        $0.image = OnboardingAsset.splashIOS.image
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
        self.view.addSubview(self.imageView)
    }
    
    // MARK: Constraints
    open override func setupConstraints() {
        super.setupConstraints()
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
