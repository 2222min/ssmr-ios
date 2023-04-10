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
   public func styled(typo: CoreTypo, byAdding: [BonMot.StringStyle.Part] = []) -> NSAttributedString {
         return self.styled(with: typo.style.byAdding(byAdding))
     }
}

public enum CoreTypo {
    case DDaengH1
    case DDaengH2
    case DDaengH3
    case DDaengB1
    case DDaengMB2
    case DDaenMB3_Bold
    case DDaengC1
    case DDaengC2
    case DDaengOverLine
    case ButtonLarge
    case ButtomSmall
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
        case .DDaengH1:
            return CommonUIFontFamily.AppleSDGothicNeoEB00.regular.font(size: 32)
        case .DDaengH2:
            return CommonUIFontFamily.AppleSDGothicNeoEB00.regular.font(size: 24)
        case .DDaengH3:
            return CommonUIFontFamily.AppleSDGothicNeoSB00.regular.font(size: 20)
        case .DDaengB1:
            return CommonUIFontFamily.AppleSDGothicNeoR00.regular.font(size: 18)
        case .DDaengMB2:
            return CommonUIFontFamily.AppleSDGothicNeoR00.regular.font(size: 17)
        case .DDaenMB3_Bold:
            return CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 14)
        case .DDaengC1:
            return CommonUIFontFamily.AppleSDGothicNeoR00.regular.font(size: 12)
        case .DDaengC2:
            return CommonUIFontFamily.AppleSDGothicNeoR00.regular.font(size: 11)
        case .DDaengOverLine:
            return CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 11)
        case .ButtonLarge:
            return CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 17)
        case .ButtomSmall:
            return CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 12)
        }
    }
    var lineHeight: CGFloat {
        switch self {
        case .DDaengH1: return 40
        case .DDaengH2: return 32
        case .DDaengH3: return 28
        case .DDaengB1: return 24
        case .DDaengMB2: return 24
        case .DDaenMB3_Bold: return 16
        case .DDaengC1: return 16
        case .DDaengC2: return 16
        case .DDaengOverLine: return 16
        case .ButtonLarge: return 20.4
        case .ButtomSmall: return 16
        }
    }
    
    var letterSpacing: CGFloat {
      switch self {
      case .DDaengH1: return -1.04
      case .DDaengH2: return 0
      case .DDaengH3: return 0
      case .DDaengB1: return 0
      case .DDaengMB2: return 0
      case .DDaenMB3_Bold: return 0
      case .DDaengC1: return 0
      case .DDaengC2: return 0
      case .DDaengOverLine: return 0
      case .ButtonLarge: return 0
      case .ButtomSmall: return 0
      }
    }
}

