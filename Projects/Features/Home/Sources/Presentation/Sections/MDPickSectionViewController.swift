//
//  MDPickSectionViewController.swift
//  HomePresentation
//
//  Created by 정건호 on 2023/04/24.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift
import RxCocoa

class MDPickSectionViewController: BaseViewController {
    
    // For test
    private let testURL: [String] = ["testURL", "testURL", "testURL", "testURL", "testURL"]

    private let uiView = UIView().then {
        $0.backgroundColor = .white
    }
    private let sectionLabel = UILabel().then {
        $0.text = "MD's PICK"
        $0.font = CoreTypo.Body2.style.font
        $0.textColor = CommonUIAsset.black.color
    }
    
    private let mdPickCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 12
        $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(MDPickCell.self, forCellWithReuseIdentifier: MDPickCell.cellIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    override func configureUI() {
        self.view.addSubview(uiView)
        self.uiView.addSubview(sectionLabel)
        self.uiView.addSubview(mdPickCollectionView)
        
        mdPickCollectionView.delegate = self
    }
    
    override func setupConstraints() {
        self.uiView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(186)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
        self.sectionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(24)
        }
        self.mdPickCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.sectionLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(146)
        }
    }
    
    private func bindUI() {
        Observable.just(testURL)
            .bind(to: mdPickCollectionView.rx.items(cellIdentifier: MDPickCell.cellIdentifier, cellType: MDPickCell.self)) { index, url, cell in
                cell.setImage(url)
            }
            .disposed(by: disposeBag)
    }
}

extension MDPickSectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 146, height: 146)
    }
}
