//
//  FindUserInfoViewController.swift
//  FindUserInfo
//
//  Created mincheol on 2022/09/24.
//  Copyright © 2022 team.io. All rights reserved.
//
import CommonUI

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

import LoginDomain
import FindUserInfoDomain

public final class FindUserInfoViewController: BaseViewController, ReactorKit.View, FindUserInfoViewControllerType {

    public typealias Reactor = FindUserInfoReactor
    
    public struct Dependency {
        let loginVC: LoginViewControllerFactoryType
        public init(loginVC: LoginViewControllerFactoryType) {
            self.loginVC = loginVC
        }
    }

	// MARK: Constants
	private enum Constants {
        static let findIdLabel = "아이디 찾기".styled(
            typo: .Body2,
            byAdding: [.color(.black)]
        )
        static let findPwLabel = "비밀번호 찾기".styled(
            typo: .Body2,
            byAdding: [.color(.black)]
        )
    }

	// MARK: Properties
	
	// MARK: UI Properties
    
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
    }
    
    public var dependency: Dependency
    // MARK: Initializing
    public init(
        reactor: Reactor,
        dependency: Dependency
    ) {
        defer {
            self.reactor = reactor
        }
        self.dependency = dependency
        super.init()
    }
    
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View Life Cycle
    public override func viewDidLoad() {
		super.viewDidLoad()
        subscribeUI()
	}

    public override func configureUI() {
		super.configureUI()
        
        [
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
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationTopBar.snp.bottom).offset(28)
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
        // State
        self.bindState(findType: reactor)
        // Action
        self.bindAction(didTapIdPager: reactor)
        self.bindAction(didTapPwPager: reactor)
        self.bindAction(didTapConfirmButton: reactor)
	}
}

// MARK: Action
extension FindUserInfoViewController {
    private func bindAction(didTapIdPager reactor: Reactor) {
        self.idPager.rx.tap
            .asDriver()
            .throttle(.milliseconds(300))
            .map { Reactor.Action.didTapIdPager }
            .drive(reactor.action)
            .disposed(by: self.disposeBag)
    }
    private func bindAction(didTapPwPager reactor: Reactor) {
        self.pwPager.rx.tap
            .asDriver()
            .throttle(.milliseconds(300))
            .map { Reactor.Action.didTapPwPager }
            .drive(reactor.action)
            .disposed(by: self.disposeBag)
    }
    private func bindAction(didTapConfirmButton reactor: Reactor) {
        self.confirmButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let reactor = ResetPasswordReactor.init()
                let vc = ResetPasswordViewController.init(reactor: reactor)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: State
extension FindUserInfoViewController {
    private func bindState(findType reactor: Reactor) {
        reactor.state.map { $0.findType }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] in
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
