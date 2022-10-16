//
//  AddInfoViewController.swift
//  SignUp
//
//  Created by 정건호 on 2022/10/09.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import RxCocoa
import CommonUI

class AddInfoViewController: BaseViewController {

    // MARK: Constants
    private enum Constants {
        static let signUpLabelText = "회원가입"
        static let guideLabelText = "사용하실 닉네임과\n생년월일을 입력해 주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let checkCountLetterText = "10글자 미만".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkSpaceText = "띄어쓰기 없음".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let checkAvailableText = "사용가능한 닉네임".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.mBlue.color)]
        )
        static let nextButtonText = "다음".styled(
            typo: .ButtonLarge,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let nicknameTextFieldTitle = "닉네임".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let nicknameTextFieldPlaceholder = "닉네임을 입력해주세요.".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let dateOfBirthTextFieldTitle = "생년월일".styled(
            typo: .DDaengH3,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
        static let dateOfBirthTextFieldPlaceholder = "2021.07.02".styled(
            typo: .DDaengMB2,
            byAdding: [.color(CommonUIAsset.whiteGrey.color)]
        )
        static let speechBallonViewText = "닉네임 결정하기 어렵다면?".styled(
            typo: .DDaengC2,
            byAdding: [.color(CommonUIAsset.white.color)]
        )
        static let recheckGuideLabelText = "멋진 날에 태어나셨네요~\n생년월일은 수정할 수 없으니 정확하게 기입되었는지 확인해 주세요!".styled(
            typo: .DDaengC1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
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
    private let nicknameTextField = UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.nicknameTextFieldTitle
        $0.textField.attributedPlaceholder = Constants.nicknameTextFieldPlaceholder
    }
    private let diceImageView = UIImageView().then {
        $0.image = UIImage(asset: CommonUIAsset.diceImage)
    }
    private let speechBalloonView = SpeechBalloonView().then {
        $0.label.attributedText = Constants.speechBallonViewText
    }
    private let checkCountLetter = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkCountLetterText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let checkSpace = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkSpaceText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let checkAvailable = LeftImageButton().then {
        $0.normalImage = UIImage(asset: CommonUIAsset.approveImage) ?? UIImage()
        $0.normalTitle = Constants.checkAvailableText
        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
    }
    private let dateOfBirthTextField =  UnderlineTextFieldWithTitle().then {
        $0.title.attributedText = Constants.dateOfBirthTextFieldTitle
        $0.textField.attributedPlaceholder = Constants.dateOfBirthTextFieldPlaceholder
    }
    private let recheckGuideLabel = LeftImageButton().then {
//        $0.normalImage = UIImage(asset: CommonUIAsset.informationMark) ?? UIImage()
        $0.normalTitle = Constants.recheckGuideLabelText
//        $0.imageEdgeInsets = .init(top: 3, left: 0, bottom: 0, right: 0)
//        $0.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
        
    }
    private let nextButton = CTAButton().then {
        $0.setAttributedTitle(
            Constants.nextButtonText,
            for: .normal
        )
    }
    
    override func configureUI() {
        [
            self.signUpLabel,
            self.guideLabel,
            self.nicknameTextField,
            self.diceImageView,
            self.speechBalloonView,
            self.checkCountLetter,
            self.checkSpace,
            self.checkAvailable,
            self.nextButton,
            self.dateOfBirthTextField,
            self.recheckGuideLabel
        ]
            .forEach(self.view.addSubview)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateOfBirthTextField.textField.delegate = self
        
        // 테스트를 위한 임시 구독
        self.dateOfBirthTextField.textField.rx.controlEvent(.touchDown)
            .subscribe(with: self) { owner, _ in
                owner.presentDatePicker()
            }
            .disposed(by: disposeBag)
        
        self.nextButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.moveToSuccessPage()
            }
            .disposed(by: disposeBag)
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
        self.nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(self.guideLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.diceImageView.snp.makeConstraints {
            $0.bottom.equalTo(self.nicknameTextField.textField.snp.bottom)
            $0.trailing.equalTo(self.nicknameTextField.snp.trailing).offset(-6)
        }
        self.speechBalloonView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(144)
            $0.top.equalTo(self.nicknameTextField.title.snp.top)
        }
        self.checkCountLetter.snp.makeConstraints {
            $0.top.equalTo(self.nicknameTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self.nicknameTextField.snp.leading)
        }
        self.checkSpace.snp.makeConstraints {
            $0.top.equalTo(self.nicknameTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self.checkCountLetter.snp.trailing).offset(8)
        }
        self.checkAvailable.snp.makeConstraints {
            $0.top.equalTo(self.nicknameTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self.checkSpace.snp.trailing).offset(8)
        }
        self.dateOfBirthTextField.snp.makeConstraints {
            $0.top.equalTo(self.nicknameTextField.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(73)
        }
        self.recheckGuideLabel.snp.makeConstraints {
            $0.top.equalTo(self.dateOfBirthTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
        self.nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func presentDatePicker() {
        let datePickerVC = DatePickerViewController()
        datePickerVC.modalPresentationStyle = .overCurrentContext
        datePickerVC.modalTransitionStyle = .crossDissolve
        self.present(datePickerVC, animated: true)
    }
    private func moveToSuccessPage() {
        let successVC = SignUpSuccessViewController()
        self.navigationController?.pushViewController(successVC, animated: true)
    }
}

extension AddInfoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
