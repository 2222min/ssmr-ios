//
//  ThanksLetterViewController.swift
//  ThanksLetterPresentation
//
//  Created by 정건호 on 2023/07/18.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import SnapKit
import Then
import ReactorKit
import RxCocoa
import RxSwift
import CommonUI

final public class ThanksLetterViewController: BaseViewController, ReactorKit.View {

    // MARK: Constants
    private enum Constants { }

    // MARK: Properties
    private let tabTitleLabel = UILabel().then {
        $0.text = "땡스레터"
        $0.font = CoreTypo.Heading.style.font
        $0.textColor = CommonUIAsset.black.color
    }
    
    private let thanksLetterTitleLabel = UILabel().then {
        $0.font = CoreTypo.Body2.style.font
        $0.numberOfLines = 0
    }

    // MARK: UI Properties
    
    
    // MARK: Initializing
    public init(reactor: ThanksLetterReactor) {
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
        hideNavigationBar()
        self.reactor?.action.onNext(.setTitle)
    }

    override public func configureUI() {
        super.configureUI()
        
        self.view.addSubview(tabTitleLabel)
        self.view.addSubview(thanksLetterTitleLabel)
    }

    // MARK: Constraints
    override public func setupConstraints() {
        super.setupConstraints()
        
        self.tabTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(22)
            $0.leading.equalToSuperview().offset(16)
        }
        self.thanksLetterTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.tabTitleLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(16)
        }
    }
}

// MARK: ReactorBind
extension ThanksLetterViewController {
    public func bind(reactor: ThanksLetterReactor) {
        self.bindState(title: reactor)
    }
}

// MARK: Action
extension ThanksLetterViewController {}

// MARK: State
extension ThanksLetterViewController {
    private func bindState(title reactor: ThanksLetterReactor) {
        reactor.state.compactMap { $0.title }
            .asDriver(onErrorDriveWith: .empty())
            .map { title in
                let attributedString = NSMutableAttributedString(string: title)
                let range = (title as NSString).range(of: "사장님의 땡스레터")
                attributedString.addAttribute(
                    .foregroundColor,
                    value: CommonUIAsset.pointColor.color,
                    range: range
                )
                return attributedString
            }
            .drive(self.thanksLetterTitleLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
    }
}

// MARK: Func
extension ThanksLetterViewController {}
