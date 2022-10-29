//
//  SignUpViewController.swift
//  SignUpTests
//
//  Created by 정건호 on 2022/09/28.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI
import ReactorKit
import RxCocoa

class SignUpViewController: BaseViewController, ReactorKit.View {
    
    public typealias Reactor = SignUpReactor
    
    // MARK: Constants
    private enum Constants {
        static let signUpLabelText = "회원가입"
        static let guideLabelText = "로그인에 사용할 이메일주소와\n비밀번호를 입력해 주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let duplicationButtonText = "중복확인".styled(
            typo: .ButtomSmall,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let availableIDLabelText = "사용할 수 있는 아이디예요!".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let unavailableIDLabelText = "이미 존재하는 아이디예요!".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mRed.color)]
        )
        static let checkCapitalLetterText = "대소문자".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let checkSpecialLetterText = "특수문자".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let checkLetterLengthText = "8-20글자 이내".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let checkCapitalLetterSelectedText = "대소문자".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkSpecialLetterSelectedText = "특수문자".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkLetterLengthSelectedText = "8-20글자 이내".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkPasswordText = "비밀번호 일치".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
        static let checkPasswordSelectedText = "비밀번호 일치".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let idTextFieldTitle = "아이디".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let idTextFieldPlaceholder = "아이디를 입력해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let pwTextFieldTitle = "비밀번호".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let pwTextFieldPlaceholder = "비밀번호를 입력해 주세요".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let pwCheckTextFieldPlaceholder = "비밀번호를 재입력해 주세요.".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
    }
    // MARK: Properties
    
    // MARK: UI Properties
    
    private let signUpLabel = UnderlineLabel().then {
        $0.labelText = Constants.signUpLabelText
    }
    private let guideLabel = UILabel().then {
        $0.attributedText = Constants.guideLabelText
        $0.numberOfLines = 0
    }
    private let idTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.idTextFieldTitle
        $0.textField.attributedPlaceholder = Constants.idTextFieldPlaceholder
    }
    private let duplicationButton = UIButton().then {
        $0.setAttributedTitle(Constants.duplicationButtonText, for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.grey.color, forState: .disabled)
        $0.setBackgroundColor(color: CommonUIAsset.pointColor.color, forState: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    private let pwTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.pwTextFieldTitle
        $0.textField.attributedPlaceholder = Constants.pwTextFieldPlaceholder
        $0.textField.isSecureTextEntry = true
    }
    private let eyeImageOfPW = UIButton().then {
        $0.setBackgroundImage(UIImage(asset: CommonUIAsset.eyeOffImage), for: .normal)
        $0.setBackgroundImage(UIImage(asset: CommonUIAsset.eyeOnImage), for: .selected)
    }
    private let pwCheckTextField = UnderlineTextField().then {
        $0.textField.attributedPlaceholder = Constants.pwCheckTextFieldPlaceholder
        $0.textField.isSecureTextEntry = true
    }
    private let eyeImageOfPWCheck = UIButton().then {
        $0.setBackgroundImage(UIImage(asset: CommonUIAsset.eyeOffImage), for: .normal)
        $0.setBackgroundImage(UIImage(asset: CommonUIAsset.eyeOnImage), for: .selected)
    }
    private let availableIDLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.availableIDLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
        $0.isHidden = true
    }
    private let unavailableIDLabel = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.closeImage) ?? UIImage()
        $0.normalTitle = Constants.unavailableIDLabelText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
        $0.isHidden = true
    }
    private let checkCapitalLetter = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.disapproveImage) ?? UIImage()
        $0.normalTitle = Constants.checkCapitalLetterText
        $0.selectedImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.selectedTitle = Constants.checkCapitalLetterSelectedText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let checkSpecialLetter = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.disapproveImage) ?? UIImage()
        $0.normalTitle = Constants.checkSpecialLetterText
        $0.selectedImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.selectedTitle = Constants.checkSpecialLetterSelectedText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let checkLetterLength = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.disapproveImage) ?? UIImage()
        $0.normalTitle = Constants.checkLetterLengthText
        $0.selectedImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.selectedTitle = Constants.checkLetterLengthSelectedText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let checkPassword = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.disapproveImage) ?? UIImage()
        $0.normalTitle = Constants.checkPasswordText
        $0.selectedImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.selectedTitle = Constants.checkPasswordSelectedText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
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
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        [
            self.signUpLabel,
            self.guideLabel,
            self.idTextField,
            self.duplicationButton,
            self.pwTextField,
            self.eyeImageOfPW,
            self.pwCheckTextField,
            self.eyeImageOfPWCheck,
            self.nextButton,
            self.availableIDLabel,
            self.unavailableIDLabel,
            self.checkCapitalLetter,
            self.checkSpecialLetter,
            self.checkLetterLength,
            self.checkPassword
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        self.signUpLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        self.guideLabel.snp.makeConstraints {
            $0.top.equalTo(self.signUpLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        self.idTextField.snp.makeConstraints {
            $0.top.equalTo(self.guideLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.duplicationButton.snp.makeConstraints {
            $0.top.bottom.equalTo(self.idTextField.textField)
            $0.trailing.equalTo(self.idTextField.snp.trailing)
            $0.width.equalTo(72)
        }
        self.pwTextField.snp.makeConstraints {
            $0.top.equalTo(self.idTextField.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.eyeImageOfPW.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.trailing.equalTo(self.pwTextField.snp.trailing)
            $0.top.bottom.equalTo(self.pwTextField.textField)
        }
        self.pwCheckTextField.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(29)
        }
        self.eyeImageOfPWCheck.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.trailing.equalTo(self.pwCheckTextField.snp.trailing)
            $0.top.bottom.equalTo(self.pwCheckTextField.textField)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        // MARK: approve Label
        self.availableIDLabel.snp.makeConstraints {
            $0.top.equalTo(self.idTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.unavailableIDLabel.snp.makeConstraints {
            $0.top.equalTo(self.idTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.checkCapitalLetter.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        self.checkSpecialLetter.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self.checkCapitalLetter.snp.trailing).offset(8)
        }
        self.checkLetterLength.snp.makeConstraints {
            $0.top.equalTo(self.pwTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self.checkSpecialLetter.snp.trailing).offset(8)
        }
        self.checkPassword.snp.makeConstraints {
            $0.top.equalTo(self.pwCheckTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    private func moveToAddEMailPage() {
        let addEMailVC = AddEmailViewController()
        self.navigationController?.pushViewController(addEMailVC, animated: true)
    }
}

// MARK: ReactorBind
extension SignUpViewController {
    public func bind(reactor: Reactor) {
        self.moveToNextPage()
        self.checkIdTextField()
        self.tapEyeImageOfPW()
        self.tapEyeImageOfPWCheck()
        self.checkPWTextField()
    }
}

// MARK: Func
extension SignUpViewController {
    public static func create() -> SignUpViewController {
        let reactor: SignUpReactor = .init()
        let viewController = SignUpViewController.init(reactor: reactor)
        
        return viewController
    }
    
    private func moveToNextPage() {
        self.nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.moveToAddEMailPage()
            })
            .disposed(by: disposeBag)
    }
    
    private func checkIdTextField() {
        self.idTextField.textField.rx.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                guard let text = text else { return }
                owner.duplicationButton.isEnabled = text.count > 4
            })
            .disposed(by: disposeBag)
    }
    
    private func tapEyeImageOfPW() {
        self.eyeImageOfPW.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.eyeImageOfPW.isSelected.toggle()
                owner.pwTextField.textField.isSecureTextEntry = !owner.eyeImageOfPW.isSelected
            })
            .disposed(by: disposeBag)
    }
    private func tapEyeImageOfPWCheck() {
        self.eyeImageOfPWCheck.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.eyeImageOfPWCheck.isSelected.toggle()
                owner.pwCheckTextField.textField.isSecureTextEntry = !owner.eyeImageOfPWCheck.isSelected
            })
            .disposed(by: disposeBag)
    }
    
    private func checkPWTextField() {
        self.pwTextField.textField.rx.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                guard let text = text else { return }
                owner.checkCapitalLetter.isSelected = text.containUppercased && text.containLowercased
                owner.checkLetterLength.isSelected = 8 <= text.count && text.count <= 20
                owner.checkSpecialLetter.isSelected = text.containSpecialLetter
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            self.pwTextField.textField.rx.text,
            self.pwCheckTextField.textField.rx.text
        )
        .withUnretained(self)
        .subscribe(onNext: { owner, result in
            guard let pwText = result.0 else { return }
            guard let pwCheckText = result.1 else { return }
            owner.checkPassword.isSelected = (pwText == pwCheckText) && !pwText.isEmpty
        })
        .disposed(by: disposeBag)
    }
}
