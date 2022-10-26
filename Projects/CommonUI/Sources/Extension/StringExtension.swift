//
//  StringExtension.swift
//  CommonUI
//
//  Created by koochowon on 2022/10/26.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation

extension String {
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let correctEmail = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return correctEmail.evaluate(with: self)
    }
}
