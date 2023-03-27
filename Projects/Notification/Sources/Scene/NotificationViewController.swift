//
//  NotificationViewController.swift
//  NotificationDemoApp
//
//  Created by 정건호 on 2023/03/26.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import CommonUI
import RxSwift

class NotificationViewController: BaseViewController {
    
    // For Test
    private let typeArray = ["전ㅋㅋㅋ체", "전체", "전체", "전체", "전체", "전체", "전체"]
    
    private let typeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NotiTypeCell.self, forCellWithReuseIdentifier: NotiTypeCell.cellIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTopBar.titleLabel.text = "알림"
        setNotiType()
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(typeCollectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.typeCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.navigationTopBar.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    private func setNotiType() {
        Observable.just(self.typeArray)
            .bind(to: typeCollectionView.rx.items(cellIdentifier: NotiTypeCell.cellIdentifier, cellType: NotiTypeCell.self)) { index, title, cell in
                cell.setTypeButtonTitle(title)
            }
            .disposed(by: disposeBag)
    }
    
    // TODO: Dynamic cell width
}
