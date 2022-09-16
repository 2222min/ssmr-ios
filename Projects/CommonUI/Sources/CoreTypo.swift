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
    case text32ExtraBold
    case text17NeoBold
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
        case .text17NeoBold:
            return CommonUIFontFamily.AppleSDGothicNeoB00.regular.font(size: 17)
        }
    }
    var lineHeight: CGFloat {
        switch self {
        case .text32ExtraBold: return 40
        case .text17NeoBold: return 20
        }
    }
    
    var letterSpacing: CGFloat {
      switch self {
      case .text32ExtraBold: return -1.04
      case .text17NeoBold: return 0
      }
    }
}

