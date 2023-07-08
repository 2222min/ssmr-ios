//
//  ReviewCell.swift
//  Home
//
//  Created by 정건호 on 2023/05/02.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI

/*
 해당 셀 디자인 변경으로 인해
 땡스레터의 리뷰셀로 사용하면 됨
 */

class ReviewCell: UITableViewCell {
    static let cellIdentifier = "ReviewCell"
    
    private let titleLabel = UILabel().then {
        $0.font = CoreTypo.Body3_B.style.font
        $0.textColor = CommonUIAsset.deepGrey.color
    }
    
    private let hashTagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    private let reviewInfoLabel = UILabel().then {
        $0.font = CoreTypo.Caption2.style.font
        $0.textColor = CommonUIAsset.deepGrey.color
    }
    
    private let contentLabel = UILabel().then {
        $0.font = CoreTypo.Caption2.style.font
        $0.textColor = CommonUIAsset.grey.color
        $0.numberOfLines = 2
    }
    
    private let reviewImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
    }
    
    private let ratingButton = LeftImageButton().then {
        $0.normalImage = CommonUIAsset.starImage.image
        $0.titleEdgeInsets = .init(top: 0.4, left: 4, bottom: 0, right: -4)
    }
    
    private let distanceButton = LeftImageButton().then {
        $0.normalImage = CommonUIAsset.locationImage.image
        $0.titleEdgeInsets = .init(top: 0.4, left: 4, bottom: 0, right: -4)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fill
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(titleLabel)
        self.addSubview(hashTagStackView)
        self.addSubview(reviewInfoLabel)
        self.addSubview(contentLabel)
        self.addSubview(reviewImageView)
        self.addSubview(stackView)
        self.stackView.addArrangedSubview(ratingButton)
        self.stackView.addArrangedSubview(distanceButton)
        setConstraints()
    }
    
    private func setConstraints() {
        self.titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.height.equalTo(16)
        }
        self.hashTagStackView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(12)
        }
        self.reviewInfoLabel.snp.makeConstraints {
            $0.top.equalTo(self.hashTagStackView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(self.reviewImageView.snp.leading).offset(16)
        }
        self.contentLabel.snp.makeConstraints {
            $0.top.equalTo(self.reviewInfoLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(self.reviewImageView.snp.leading).offset(-35)
        }
        self.reviewImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.height.width.equalTo(UIScreen.main.bounds.width / 3)
            $0.trailing.equalToSuperview().offset(-16)
        }
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.contentLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(self.reviewImageView.snp.leading).offset(-16)
        }
    }
    
    func configureCell(_ review: ReviewEntity) {
        self.titleLabel.text = review.title
        self.configureHashTagButton(review.hashTag)
        self.reviewInfoLabel.text = "작성자: " + review.writer + " " + review.date
        self.contentLabel.text = review.content
        
        self.ratingButton.normalTitle =  String(review.rating).styled(
            typo: .Caption2,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        self.distanceButton.normalTitle =  String("매장까지 " + review.distance).styled(
            typo: .Caption2,
            byAdding: [.color(CommonUIAsset.deepGrey.color)]
        )
        self.reviewImageView.kf.setImage(
            with: review.image,
            placeholder: UIImage(asset: CommonUIAsset.readyImage)
        )
    }
    
    private func configureHashTagButton(_ hashTags: [String]) {
        let buttons = hashTags.map { title -> UIButton in
            let button = UIButton().then {
                $0.setTitle(title, for: .normal)
                $0.setTitleColor(CommonUIAsset.pointColor.color, for: .normal)
                $0.titleLabel?.font = CoreTypo.Caption2.style.font
                $0.titleEdgeInsets = .init(top: 0, left: 0, bottom: 1, right: 0)
                $0.layer.borderWidth = 1.4
                $0.layer.cornerRadius = 10
                $0.layer.borderColor = CommonUIAsset.mLightOrange.color.cgColor
                $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
            }
            
            return button
        }
        
        buttons.forEach { self.hashTagStackView.addArrangedSubview($0) }
    }
}
