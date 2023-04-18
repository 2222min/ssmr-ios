//
//  NotiElementCell.swift
//  Notification
//
//  Created by 정건호 on 2023/04/10.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI

class NotiElementCell: UITableViewCell {
    static let cellIdentifier = "NotiElementCell"
    
    private let notiImage = UIImageView().then {
        $0.image = CommonUIAsset.watchImage.image
    }
    
    private let notiTypeLabel = UILabel().then {
        $0.font = CoreTypo.ButtomSmall.style.font
        $0.textColor = CommonUIAsset.grey.color
    }
    
    private let notiContentLabel = UILabel().then {
        $0.font = CoreTypo.DDaengMB2.style.font
        $0.textColor = CommonUIAsset.deepGrey.color
        $0.numberOfLines = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(notiImage)
        self.addSubview(notiTypeLabel)
        self.addSubview(notiContentLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        self.notiImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(41)
        }
        self.notiTypeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(self.notiImage.snp.trailing).offset(12)
            $0.height.equalTo(16)
        }
        self.notiContentLabel.snp.makeConstraints {
            $0.top.equalTo(self.notiTypeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(self.notiImage.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func configureCell(_ element: NotiElementEntity) {
        self.notiTypeLabel.text = element.type
        self.notiContentLabel.text = element.content
    }
}
