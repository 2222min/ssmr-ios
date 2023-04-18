//
//  RootViewController.swift
//  Root
//
//  Created mincheol on 2023/04/18.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit

import SnapKit
import Then
import ReactorKit
import RxCocoa
import RxSwift
import CommonUI
import HomePresentation

final class RootViewController: UITabBarController, ReactorKit.View {
    var disposeBag: DisposeBag = .init()

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties

	// MARK: UI Properties
    private let homeViewController = HomeViewController(reactor: HomeReactor.init())

	// MARK: Initializing
	init(reactor: RootReactor) {
		defer {
			self.reactor = reactor
		}
        super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        self.configureUI()
        self.setupConstraints()
	}

	func configureUI() {
        self.viewControllers = [homeViewController]
	}

	// MARK: Constraints
	func setupConstraints() {
	}
}

// MARK: ReactorBind
extension RootViewController {
	func bind(reactor: RootReactor) {
	}
}

// MARK: Action
extension RootViewController {}

// MARK: State
extension RootViewController {}

// MARK: Func
extension RootViewController {}
