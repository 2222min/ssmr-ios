//
//  LoginFailView.swift
//  Login
//
//  Created by 정건호 on 2022/09/22.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit
import CommonUI

class LoginFailView: UIView {
    private let loginFailLabel = UILabel().then {
        $0.attributedText = "로그인에 실패했어요".styled(
            typo: .text20NeoNormal,
            byAdding: [.color(CommonUIAsset.black.color)])
    }
    
    private let failCountLabel = UILabel().then {
        $0.attributedText = "(1회 실패)".styled(
            typo: .text12NeoNormal,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
    }
    
    private let checkImage = UIImageView().then {
        $0.image = CommonUIAsset.checkImage.image
    }
}
