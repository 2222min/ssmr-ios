//
//  StringExtension.swift
//  CommonUI
//
//  Created by koochowon on 2022/10/26.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation

extension String {
    //MARK: String 유효성 검사
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let correctEmail = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return correctEmail.evaluate(with: self)
    }
    
    public var containLowercased: Bool {
        let lowercaseRegEx = ".*[a-z]+.*"
        let lowercase = NSPredicate(format: "SELF MATCHES %@", lowercaseRegEx)
        return lowercase.evaluate(with: self)
    }
    
    public var containUppercased: Bool {
        let uppercaseRegEx = ".*[A-Z]+.*"
        let uppercase = NSPredicate(format: "SELF MATCHES %@", uppercaseRegEx)
        return uppercase.evaluate(with: self)
    }
    
    // TODO: 특수문자 허용범위 물어본 후 수정
    public var containSpecialLetter: Bool {
        let speicalLetterRegEx = ".*[!&^%$#@()/]+.*"
        let speicalLetter = NSPredicate(format: "SELF MATCHES %@", speicalLetterRegEx)
        return speicalLetter.evaluate(with: self)
    }

}
