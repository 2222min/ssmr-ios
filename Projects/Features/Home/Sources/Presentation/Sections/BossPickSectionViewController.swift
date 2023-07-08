//
//  BossPickSectionViewController.swift
//  HomePresentation
//
//  Created by 정건호 on 2023/04/24.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift
import RxCocoa

class BossPickSectionViewController: BaseViewController {
    
    // Test Data
    private let categoryDatas = ["음식점", "스포츠/레저", "문화/예술", "오락", "음료 전문점", "D.I.Y", "테마파크"]
    let homeReviewDatas = [
        HomeReviewEntity(storeName: "애정마라탕탕탕탕탕애정마라탕탕탕탕탕", menuName: "애정꿔바로우", writer: "활보하는고양이이이", image: nil),
        HomeReviewEntity(storeName: "애정마라탕", menuName: "애정꿔바로우애정꿔바로우", writer: "활보하는고양이이이", image: nil),
        HomeReviewEntity(storeName: "애정마라탕", menuName: "애정꿔바로우", writer: "활보하는고양이이이활보하는고양이이이", image: nil),
        HomeReviewEntity(storeName: "애정마라탕", menuName: "애정꿔바로우", writer: "활보하는고양이이이", image: nil)
    ]
    
    private let uiView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let sectionLabel = UILabel().then {
        let attributedString = NSMutableAttributedString(
            string: "사장님's PICK ",
            attributes: [
                NSAttributedString.Key.font: CommonUIFontFamily.Pretendard.semiBold.font(size: 20)
            ]
        )
        attributedString.append(NSAttributedString(
            string: "리뷰왕",
            attributes: [
                NSAttributedString.Key.foregroundColor: CommonUIAsset.pointColor.color,
                NSAttributedString.Key.font: CommonUIFontFamily.Pretendard.semiBold.font(size: 20)
            ])
        )
        $0.attributedText = attributedString
    }
    
    private let sectionGuideLabel = UILabel().then {
        $0.text = "사장님까지 PICK한 리뷰가 궁금하다면 여기로!"
        $0.font = CoreTypo.Body3.style.font
        $0.textColor = CommonUIAsset.black.color
    }
    
    private let categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 8
        $0.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }).then {
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.cellIdentifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }).then {
        $0.register(HomeReviewCell.self, forCellWithReuseIdentifier: HomeReviewCell.cellIdentifier)
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    
    private let thanksLetterButton = UIButton().then {
        $0.setTitle("땡스레터로 가기", for: .normal)
        $0.setBackgroundColor(color: CommonUIAsset.cream.color, forState: .normal)
        $0.setTitleColor(CommonUIAsset.deepGrey.color, for: .normal)
        $0.titleLabel?.font = CoreTypo.Body2.style.font
        $0.layer.cornerRadius = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    override func configureUI() {
        self.view.addSubview(uiView)
        self.uiView.addSubview(sectionLabel)
        self.uiView.addSubview(sectionGuideLabel)
        self.uiView.addSubview(categoryCollectionView)
        self.uiView.addSubview(reviewCollectionView)
        self.uiView.addSubview(thanksLetterButton)
        
        self.categoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        self.reviewCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    override func setupConstraints() {
        let padding = (UIScreen.main.bounds.width - 328) / 3
        
        self.uiView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        self.sectionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(24)
        }
        self.sectionGuideLabel.snp.makeConstraints {
            $0.top.equalTo(self.sectionLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(16)
        }
        self.categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.sectionGuideLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
        self.reviewCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.categoryCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.height.equalTo(344)
        }
        self.thanksLetterButton.snp.makeConstraints {
            $0.top.equalTo(self.reviewCollectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func bindUI() {
        Observable.just(self.categoryDatas)
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: CategoryCell.cellIdentifier, cellType: CategoryCell.self)) { index, category, cell in
                cell.setCategoryButtonTitle(category)
            }
            .disposed(by: disposeBag)
        
        Observable.just(self.homeReviewDatas)
            .bind(to: reviewCollectionView.rx.items(cellIdentifier: HomeReviewCell.cellIdentifier, cellType: HomeReviewCell.self)) { index, review, cell in
                cell.configureCell(review)
            }
            .disposed(by: disposeBag)
    }
}

extension BossPickSectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isScrollEnabled {
            let label = UILabel()
            label.text = self.categoryDatas[indexPath.row]
            label.font = CoreTypo.Body3_B.style.font
            label.sizeToFit()
            
            let width = label.frame.width + 32
            
            return CGSize(width: width, height: 32)
        } else {
            return CGSize(width: 164, height: 164)
        }
    }
}
