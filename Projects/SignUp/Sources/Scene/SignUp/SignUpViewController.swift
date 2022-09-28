//
//  SignUpViewController.swift
//  SignUpTests
//
//  Created by 정건호 on 2022/09/28.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI

class SignUpViewController: BaseViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let guideLabelText = "로그인에 사용할 이메일주소와\n비밀번호를 입력해 주세요".styled(
            typo: .DDaengB1,
            byAdding: [.color(CommonUIAsset.blackGrey.color)]
        )
    }
    // MARK: Properties
    
    // MARK: UI Properties
    
    private let signUpLabel = UnderlineLabel().then {
        $0.labelText = "회원가입"
    }
    
    private let guideLabel = UILabel().then {
        $0.attributedText = Constants.guideLabelText
        $0.numberOfLines = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        self.view.addSubview(signUpLabel)
        self.view.addSubview(guideLabel)
    }
    
    override func setupConstraints() {
        self.signUpLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        self.guideLabel.snp.makeConstraints {
            $0.top.equalTo(self.signUpLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
