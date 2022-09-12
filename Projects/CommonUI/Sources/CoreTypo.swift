//
//  CoreTypo.swift
//  CommonUI
//
//  Created by mincheol on 2022/09/12.
//  Copyright © 2022 team.io. All rights reserved.
//

import BonMot
import Foundation
import UIKit

extension String {
    /**
     ### Usage ###
     ```
     "SingleLineText".styled(typo: .text30Bold)
     "MultiLine\nText".styled(typo: .text30BoldN, byAdding: [.color(.black)])
     ```
     */
    func styled(typo: CoreTypo, byAdding: [BonMot.StringStyle.Part] = []) -> NSAttributedString {
        return self.styled(with: typo.style.byAdding(byAdding))
    }
    
    func styled(typo: CoreTypo, byAdding: BonMot.StringStyle.Part...) -> NSAttributedString {
        return self.styled(with: typo.style.byAdding(byAdding))
    }
}

/**
 ### Usage ###
 ```
 let singleLine = CoreTypo.text30Bold.style.byAdding([.color(.black)])
 let multiLine = CoreTypo.text30BoldN.style.byAdding([.color(.black)])
 ```
 */
public enum CoreTypo {
    case text32ExtraBold
}
extension CoreTypo {
    public var style: BonMot.StringStyle {
        return .init([
            .font(self.font!),
            .minimumLineHeight(self.lineHeight),
            .tracking(.point(self.letterSpacing))
        ])
    }
}
extension CoreTypo {
    var font: UIFont? {
        switch self {
        case .text32ExtraBold:
            return CommonUIFontFamily.AppleSDGothicNeoEB00.regular.font(size: 32)
        }
    }
    var lineHeight: CGFloat {
        switch self {
        case .text32ExtraBold: return 40
            
        }
    }
    
    var letterSpacing: CGFloat {
      switch self {
      case .text32ExtraBold: return -1.04
      }
    }
}

