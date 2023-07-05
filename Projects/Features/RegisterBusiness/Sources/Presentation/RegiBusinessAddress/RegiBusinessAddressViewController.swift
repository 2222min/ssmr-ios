//
//  RegiBusinessAddressViewController.swift
//  RegisterBusiness
//
//  Created by 정건호 on 2022/11/12.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift
import ReactorKit

class RegiBusinessAddressViewController: BaseViewController, ReactorKit.View  {
    
    typealias Reactor = RegiBusinessAddressReactor
    
    // MARK: Constants
    private enum Constants {
        static let titleLabelText = "사업자 등록하기"
        static let subTitleLabeltext = "입점을 위해\n사업자 등록 정보를 입력해주세요".styled(
            typo: .Body1,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let nameTextFieldTitleText = "대표자 성함".styled(
            typo: .Subhead,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let nameTextFieldPlaceHolderText = "대표님의 성함을 입력해 주세요".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let nameTextFieldGuideLabelText = "외국인 사업자의 경우, 영문명으로 입력해 주세요".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let addressTextFieldTitleText = "주소".styled(
            typo: .Subhead,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        static let addressTextFieldPlaceHolderText = "주소를 등록해 주세요".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let searchButtonText = "검색".styled(
            typo: .Caption1,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
    }
    
    // MARK: Properties
    
    // MARK: UI Properties
    
    private let titleLabel = UnderlineLabel().then {
        $0.labelText = Constants.titleLabelText
    }
    private let subTitleLabel = UILabel().then {
        $0.attributedText = Constants.subTitleLabeltext
        $0.numberOfLines = 0
    }
    private let nameTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.nameTextFieldTitleText
        $0.textField.attributedPlaceholder = Constants.nameTextFieldPlaceHolderText
    }
    private let nameTextFieldGuideLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.informationMark) ?? UIImage()
        $0.normalTitle = Constants.nameTextFieldGuideLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 2, bottom: 0, right: -4)
    }
    private let addressTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.addressTextFieldTitleText
        $0.textField.attributedPlaceholder = Constants.addressTextFieldPlaceHolderText
    }
    private let searchButton = UIButton().then {
        $0.setAttributedTitle(Constants.searchButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.grey.color, forState: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
        $0.isEnabled = true
    }
    private let pageView = RegiBusinessPage().then {
        $0.makePage(pageNumber: 5, currentPage: 3)
    }
    
    // MARK: Initializing
    
    init(reactor: Reactor) {
      defer {
        self.reactor = reactor
      }
      super.init()
    }
    
    required init?(coder: NSCoder) {
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
            self.titleLabel,
            self.subTitleLabel,
            self.nameTextField,
            self.nameTextFieldGuideLabel,
            self.addressTextField,
            self.searchButton,
            self.nextButton,
            self.pageView
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        super.setupConstraints()
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationTopBar.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.nameTextField.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.nameTextFieldGuideLabel.snp.makeConstraints {
            $0.top.equalTo(self.nameTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.addressTextField.snp.makeConstraints {
            $0.top.equalTo(self.nameTextFieldGuideLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.searchButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.addressTextField.textField)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(51)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        self.pageView.snp.makeConstraints {
            $0.top.equalTo(self.navigationTopBar.snp.top).offset(24)
            $0.trailing.equalTo(self.navigationTopBar.snp.trailing).offset(-16)
        }
    }
    
    override func subscribeUI() {
        super.subscribeUI()
    }
    
    func bind(reactor: Reactor) {
        self.nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.moveToRegiBusinessThirdVC()
            })
            .disposed(by: disposeBag)
        self.searchButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.searchAddress()
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: Func

extension RegiBusinessAddressViewController {
    private func moveToRegiBusinessThirdVC() {
        let regiBusinessContactVC = RegiBusinessContactViewController()
        self.navigationController?.pushViewController(regiBusinessContactVC, animated: true)
    }
    private func searchAddress() {
        let kakaoPostcodeVC = SearchKakaoPostCodeViewController()
        kakaoPostcodeVC.delegate = self
        kakaoPostcodeVC.modalTransitionStyle = .crossDissolve
        kakaoPostcodeVC.modalPresentationStyle = .overCurrentContext
        self.present(kakaoPostcodeVC, animated: true)
    }
}

// MARK: SearchKakaoPostCodeViewControllerDelegate

extension RegiBusinessAddressViewController: SearchKakaoPostCodeViewControllerDelegate {
    func setAddressTextField(address: [String: Any]) {
        // TODO: 추가로 필요한 데이터가 있으면 address 딕셔너리에서 꺼내서 쓰면 됨
        // Key 값:  jibunAddress, roadAddress, zonecode
        guard let address = address["roadAddress"] as? String else { return }
        self.addressTextField.textField.text = address
    }
}


