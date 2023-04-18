//
//  HomeViewController.swift
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

final public class HomeViewController: BaseViewController, ReactorKit.View {

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties

	// MARK: UI Properties
    private let container = UIView().then {
        $0.backgroundColor = .blue
    }
	// MARK: Initializing
    public init(reactor: HomeReactor) {
		defer {
			self.reactor = reactor
		}
        super.init()
	}

    required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View Life Cycle
    override public func viewDidLoad() {
		super.viewDidLoad()
	}

    override public func configureUI() {
        super.configureUI()
        self.view.addSubview(self.container)
	}

	// MARK: Constraints
    override public func setupConstraints() {
        super.setupConstraints()
        self.container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
	}
}

// MARK: ReactorBind
extension HomeViewController {
    public func bind(reactor: HomeReactor) {
	}
}

// MARK: Action
extension HomeViewController {}

// MARK: State
extension HomeViewController {}

// MARK: Func
extension HomeViewController {}
