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
    case Display
    case Heading
    case Subhead
    case Body1
    case Body2
    case Body2_B
    case Body3
    case Body3_B
    case Caption1_B
    case Caption1
    case Caption2
}
extension CoreTypo {
    public var style: BonMot.StringStyle {
        return .init([
            .font(self.font!),
            .minimumLineHeight(self.lineHeight),
            .maximumLineHeight(self.lineHeight),
            .tracking(.point(self.letterSpacing))
        ])
    }
}
extension CoreTypo {
    var font: UIFont? {
        switch self {
        case .Display:
            return CommonUIFontFamily.Pretendard.extraBold.font(size: 32)
        case .Heading:
            return CommonUIFontFamily.Pretendard.extraBold.font(size: 24)
        case .Subhead:
            return CommonUIFontFamily.Pretendard.semiBold.font(size: 20)
        case .Body1:
            return CommonUIFontFamily.Pretendard.regular.font(size: 18)
        case .Body2:
            return CommonUIFontFamily.Pretendard.regular.font(size: 17)
        case .Body2_B:
            return CommonUIFontFamily.Pretendard.bold.font(size: 17)
        case .Body3:
            return CommonUIFontFamily.Pretendard.regular.font(size: 14)
        case .Body3_B:
            return CommonUIFontFamily.Pretendard.bold.font(size: 14)
        case .Caption1_B:
            return CommonUIFontFamily.Pretendard.bold.font(size: 12)
        case .Caption1:
            return CommonUIFontFamily.Pretendard.regular.font(size: 12)
        case .Caption2:
            return CommonUIFontFamily.Pretendard.regular.font(size: 11)
        }
    }
    var lineHeight: CGFloat {
        switch self {
        case .Display: return 40
        case .Heading: return 32
        case .Subhead: return 28
        case .Body1: return 24
        case .Body2: return 24
        case .Body2_B: return 24
        case .Body3: return 16
        case .Body3_B: return 16
        case .Caption1_B: return 16
        case .Caption1: return 16
        case .Caption2: return 12
        }
    }
    
    var letterSpacing: CGFloat {
      switch self {
      case .Display: return 0
      case .Heading: return 0
      case .Subhead: return 0
      case .Body1: return 0
      case .Body2: return 0
      case .Body2_B: return 0
      case .Body3: return 0
      case .Body3_B: return 0
      case .Caption1_B: return 0
      case .Caption1: return 0
      case .Caption2: return 0
      }
    }
}

