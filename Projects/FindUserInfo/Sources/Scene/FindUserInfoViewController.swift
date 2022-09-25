//
//  FindUserInfoViewController.swift
//  FindUserInfo
//
//  Created mincheol on 2022/09/24.
//  Copyright © 2022 team.io. All rights reserved.
//
import CommonUI

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
    private let titleLabel = UnderlineLabel().then {
        $0.labelText = "아이디/비밀번호 찾기"
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        self.findIdView,
        self.findPwView
    ]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 0.5
    }
    
    private let findIdView = PagerView().then {
        $0.title = Constants.findIdLabel
        $0.changeColor(true)
    }
    private let findPwView = PagerView().then {
        $0.title = Constants.findPwLabel
        $0.changeColor(false)
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
            self.titleLabel,
            self.stackView
        ]
            .forEach(self.view.addSubview)
	}

	// MARK: Constraints
    public override func setupConstraints() {
		super.setupConstraints()
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.left.equalToSuperview().offset(16)
        }
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(21)
            $0.left.right.equalToSuperview()
        }
	}
}

// MARK: ReactorBind
extension FindUserInfoViewController {
    public func bind(reactor: Reactor) {
	}
}

// MARK: Action
extension FindUserInfoViewController {}

// MARK: State
extension FindUserInfoViewController {}

// MARK: Func
extension FindUserInfoViewController {
    public static func create() -> FindUserInfoViewController {
        let reactor: FindUserInfoReactor = .init()
        let viewController = FindUserInfoViewController.init(reactor: reactor)
        
        return viewController
    }
}
