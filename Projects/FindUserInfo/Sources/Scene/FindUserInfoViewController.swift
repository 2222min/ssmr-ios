//
//  FindUserInfoViewController.swift
//  FindUserInfo
//
//  Created mincheol on 2022/09/24.
//  Copyright © 2022 team.io. All rights reserved.
//
import CommonUI
import Util

import UIKit
import SnapKit
import Then
import ReactorKit
import RxCocoa
import RxSwift

public final class FindUserInfoViewController: BaseViewController, ReactorKit.View {

    public typealias Reactor = FindUserInfoReactor

	// MARK: Constants
	private enum Constants {
        static let findIdLabel = "아이디 찾기".styled(
            typo: .DDaengMB2,
            byAdding: [.color(.black)]
        )
        static let findPwLabel = "비밀번호 찾기".styled(
            typo: .DDaengMB2,
            byAdding: [.color(.black)]
        )
    }

	// MARK: Properties
	
	// MARK: UI Properties
    private let topBar = NavigationTopBar().then {
        $0.leftButton.setImage(CommonUIAsset.chevronLeft.image, for: .normal)
    }
    
    private let titleLabel = UnderlineLabel().then {
        $0.labelText = "아이디/비밀번호 찾기"
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        self.idPager,
        self.pwPager
    ]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 0.5
    }
    
    private let idPager = PagerView().then {
        $0.title = Constants.findIdLabel
        $0.changeColor(true)
    }
    private let pwPager = PagerView().then {
        $0.title = Constants.findPwLabel
        $0.changeColor(false)
    }
    private let contentContainerView = UIView()
    private let findIdView = FindIdView()
    private let findPwView = FindPwView()
    
    private let confirmButton = CTAButton().then {
        $0.title = "다음"
        $0.setBackgroundColor(color: CommonUIAsset.grey.color, forState: .disabled)
        $0.isEnabled = false
    }
	// MARK: Initializing
	init(reactor: Reactor) {
		defer {
			self.reactor = reactor
		}
		super.init()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View Life Cycle
    public override func viewDidLoad() {
		super.viewDidLoad()
	}

    public override func configureUI() {
		super.configureUI()
        
        [
            self.topBar,
            self.titleLabel,
            self.stackView,
            self.confirmButton,
            self.contentContainerView
        ]
            .forEach(self.view.addSubview)
	}

	// MARK: Constraints
    public override func setupConstraints() {
		super.setupConstraints()
        self.topBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(16)
        }
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(21)
            $0.left.right.equalToSuperview()
        }
        self.confirmButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
        }
        self.contentContainerView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.confirmButton.snp.top)
        }
	}
}

// MARK: ReactorBind
extension FindUserInfoViewController {
    public func bind(reactor: Reactor) {
        // Func
        // State
        self.bindState(findType: reactor)
        // Action
        self.bindAction(didTapIdPager: reactor)
        self.bindAction(didTapPwPager: reactor)
	}
}

// MARK: Action
extension FindUserInfoViewController {
    private func bindAction(didTapIdPager reactor: Reactor) {
        self.idPager.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapIdPager }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    private func bindAction(didTapPwPager reactor: Reactor) {
        self.pwPager.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.didTapPwPager }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}

// MARK: State
extension FindUserInfoViewController {
    private func bindState(findType reactor: Reactor) {
        reactor.state.map { $0.findType }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self]  in
                switch $0 {
                case .id:
                    self?.idPager.changeColor(true)
                    self?.pwPager.changeColor(false)
                    self?.setUpFindIdView()
                case .password:
                    self?.idPager.changeColor(false)
                    self?.pwPager.changeColor(true)
                    self?.setUpFindPwView()
                }
                
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: Func
extension FindUserInfoViewController {
    public static func create() -> FindUserInfoViewController {
        let reactor: FindUserInfoReactor = .init()
        let viewController = FindUserInfoViewController.init(reactor: reactor)
        
        return viewController
    }
    private func setUpFindIdView() {
        self.contentContainerView.subviews.forEach {
            $0.removeFromSuperview()
        }
        self.contentContainerView.addSubview(self.findIdView)
        self.findIdView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func setUpFindPwView() {
        self.contentContainerView.subviews.forEach {
            $0.removeFromSuperview()
        }
        self.contentContainerView.addSubview(self.findPwView)
        self.findPwView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
