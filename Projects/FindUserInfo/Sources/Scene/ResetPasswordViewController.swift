//
//  ResetPasswordViewController.swift
//  FindUserInfo
//
//  Created mincheol on 2022/10/15.
//  Copyright © 2022 team.io. All rights reserved.
//

import CommonUI

import UIKit
import SnapKit
import Then
import ReactorKit
import RxCocoa
import RxSwift

final class ResetPasswordViewController: BaseViewController, ReactorKit.View {

	typealias Reactor = ResetPasswordReactor

	// MARK: Constants
	private enum Constants {
        static let descriptionLabel = "새로운 비밀번호를 설정해 주세요.".styled(typo: .DDaengB1, byAdding: [.color(CommonUIAsset.)])
    }

	// MARK: Properties
	
	// MARK: UI Properties
    private let topBar = NavigationTopBar().then {
        $0.leftButton.setImage(CommonUIAsset.chevronLeft.image
                               , for: .normal)
    }

    private let titleLabel = UnderlineLabel().then {
        $0.labelText = "비밀번호 재설정하기"
    }
    
    private let descriptionLabel = UILabel().then {
        $0.attributedText =
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
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureUI() {
		super.configureUI()
	}

	// MARK: Constraints
	override func setupConstraints() {
		super.setupConstraints()
	}
}

// MARK: ReactorBind
extension ResetPasswordViewController {
	func bind(reactor: Reactor) { 
	}
}

// MARK: Action
extension ResetPasswordViewController {}

// MARK: State
extension ResetPasswordViewController {}

// MARK: Func
extension ResetPasswordViewController {}
