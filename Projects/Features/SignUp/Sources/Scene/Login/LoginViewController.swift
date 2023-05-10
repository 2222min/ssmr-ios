//
//  LoginViewController.swift
//  SignUp
//
//  Created mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import CommonUI

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then

open class LoginViewController: BaseViewController {
    private let reactor: LoginReactor
    
    // MARK: Constants
    private enum Constants { }
    
    // MARK: Properties
    
    // MARK: UI Properties
    private let label = UnderlineLabel().then {
        $0.labelText = "회원가입"
    }
    
    
    // MARK: Initializing
    init(reactor: LoginReactor) {
        self.reactor = reactor
        super.init()
        self.bind(reactor: reactor)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    open override func configureUI() {
        super.configureUI()
        self.view.addSubview(self.label)
    }
    
    // MARK: Constraints
    open override func setupConstraints() {
        super.setupConstraints()
        self.label.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.left.equalToSuperview().offset(20)
        }
    }
    
}

// MARK: ReactorBind
extension LoginViewController {
    func bind(reactor: LoginReactor) {
    }
}

// MARK: Action
extension LoginViewController {}

// MARK: State
extension LoginViewController {}

// MARK: Func
extension LoginViewController {
    public static func create() -> LoginViewController? {
        let signUpProvider = SignUpAPIProvider(isStub: true)
        let loginReactor = LoginReactor(signUpProvider: signUpProvider)
        let loginVC = LoginViewController(reactor: loginReactor)
        
        return loginVC
    }
}

