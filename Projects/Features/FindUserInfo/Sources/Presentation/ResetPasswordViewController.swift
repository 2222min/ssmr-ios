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
        static let descriptionLabel = "새로운 비밀번호를 설정해 주세요.".styled(
            typo: .Body1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let textFieldTitle = "비밀번호".styled(
            typo: .Subhead,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let firstInputPlaceholder = "비밀번호를 입력해주세요.".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let secondInputPlaceholder = "비밀번호를 재입력해 주세요.".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let checkCapitalLetterText = "대소문자".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkSpecialLetterText = "특수문자".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkLetterLengthText = "8-20글자 이내".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkPasswordText = "비밀번호 일치".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
    }
    
    // MARK: Properties
    
    // MARK: UI Properties
    
    private let titleLabel = UnderlineLabel().then {
        $0.labelText = "비밀번호 재설정하기"
    }
    
    private let descriptionLabel = UILabel().then {
        $0.attributedText = Constants.descriptionLabel
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        self.checkCapitalLetter,
        self.checkSpecialLetter,
        self.checkLetterLength
    ]).then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    private let firstInputTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.textFieldTitle
        $0.textField.attributedPlaceholder = Constants.firstInputPlaceholder
    }
    private let checkCapitalLetter = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkCapitalLetterText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    private let checkSpecialLetter = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkSpecialLetterText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    private let checkLetterLength = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkLetterLengthText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    private let secondInputTextField = UnderlineTextField().then {
        $0.textField.attributedPlaceholder = Constants.secondInputPlaceholder
    }
    private let checkPassword = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkPasswordText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    
    private let changePasswordButton = CTAButton().then {
        $0.title = "비밀번호 변경하기"
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
        subscribeUI()
    }
    
    override func configureUI() {
        super.configureUI()
        [
            titleLabel,
            descriptionLabel,
            firstInputTextField,
            stackView,
            secondInputTextField,
            checkPassword,
            changePasswordButton
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationTopBar.snp.bottom).offset(28)
            $0.left.equalToSuperview().offset(16)
        }
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(17)
            $0.left.equalTo(self.titleLabel.snp.left)
        }
        self.firstInputTextField.snp.makeConstraints {
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(64)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.firstInputTextField.snp.bottom).offset(12)
            $0.left.equalTo(self.firstInputTextField.snp.left)
        }
        self.secondInputTextField.snp.makeConstraints {
            $0.top.equalTo(self.stackView.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        self.checkPassword.snp.makeConstraints {
            $0.top.equalTo(self.secondInputTextField.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(16)
        }
        self.changePasswordButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(50)
        }
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
