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
import RxDataSources

class NotificationViewController: BaseViewController {
    
    // For Test
    private let typeArray = ["전체", "전체", "전체", "전체", "전체", "전체", "전체"]
    private let notiArray = [
        NotiElementSection(header: "3.24 오늘", items: [
            NotiElement(type: "나의 리뷰", content: "애정마라탕에서의 식사 어떠셨나요? 괜찮으셨다면 애정마라탕을 위한 리뷰를 남겨주세요.")
        ]),
        NotiElementSection(header: "3.23 어제", items: [
            NotiElement(type: "나의 리뷰", content: "애정마라탕에서의 식사 어떠셨나요? 괜찮으셨다면 애정마라탕을 위한 리뷰를 남겨주세요."),
            NotiElement(type: "나의 리뷰", content: "애정마라탕에서의 식사 어떠셨나요? 괜찮으셨다면 애정마라탕을 위한 리뷰를 남겨주세요.")
        ])
    ]
    //
    
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
    
    private let notiTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(NotiElementCell.self, forCellReuseIdentifier: NotiElementCell.cellIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTopBar.titleLabel.text = "알림"
        setNotiType()
        bind()
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(typeCollectionView)
        self.view.addSubview(notiTableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.typeCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.navigationTopBar.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        self.notiTableView.snp.makeConstraints {
            $0.top.equalTo(self.typeCollectionView.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setNotiType() {
        Observable.just(self.typeArray)
            .bind(to: typeCollectionView.rx.items(cellIdentifier: NotiTypeCell.cellIdentifier, cellType: NotiTypeCell.self)) { index, title, cell in
                cell.setTypeButtonTitle(title)
            }
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        let dataSource = RxTableViewSectionedReloadDataSource<NotiElementSection>(
            configureCell: { _, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NotiElementCell.cellIdentifier) as? NotiElementCell
                else { return UITableViewCell() }
                
                cell.configureCell(item)
                
                return cell
            }
        )
        
        dataSource.titleForHeaderInSection = { datasource, index in
            return datasource.sectionModels[index].header
        }
        
        Observable.just(notiArray)
            .bind(to: notiTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    // TODO: Dynamic cell width
}

struct NotiElement {
    let type: String
    let content: String
}

struct NotiElementSection {
    let header: String
    var items: [NotiElement]
    
    init(header: String, items: [NotiElement]) {
        self.header = header
        self.items = items
    }
}

extension NotiElementSection: SectionModelType {
    init(original: NotiElementSection, items: [NotiElement]) {
        self = original
        self.items = items
    }
}
