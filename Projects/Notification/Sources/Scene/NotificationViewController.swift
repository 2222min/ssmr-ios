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
    private let typeArray = ["전체", "오늘의 할인", "나의 리뷰", "공지사항"]
    private let notiArray = [
        NotiElementSection(header: "3.24 오늘", items: [
            NotiElement(type: "나의 리뷰", content: "애정마라탕에서의 식사 어떠셨나요?")
        ]),
        NotiElementSection(header: "3.23 어제", items: [
            NotiElement(type: "나의 리뷰", content: "애정마라탕에서의 식사 어떠셨나요? 괜찮으셨다면 애정마라탕을 위한 리뷰를 남겨주세요."),
            NotiElement(type: "나의 리뷰", content: "애정마라탕에서의 식사 어떠셨나요? 괜찮으셨다면 애정마라탕을 위한 리뷰를 남겨주세요.")
        ]),
        NotiElementSection(header: "3.22 수요일", items: [
            NotiElement(type: "나의 리뷰", content: "애정마라탕에서의 식사 어떠셨나요?"),
            NotiElement(type: "나의 리뷰", content: "애정마라탕에서의 식사 어떠셨나요? 괜찮으셨다면 애정마라탕을 위한 리뷰를 남겨주세요.")
        ])
    ]
    
    private let typeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 12
        $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(NotiTypeCell.self, forCellWithReuseIdentifier: NotiTypeCell.cellIdentifier)
    }

    
    private let notiTableView = UITableView(frame: .zero, style: .grouped).then {
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
                tableView.rowHeight = UITableView.automaticDimension
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = CommonUIAsset.mLightOrange.color
                
                cell.selectedBackgroundView = backgroundView
                return cell
            }
        )
        
        Observable.just(notiArray)
            .bind(to: notiTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        notiTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let headerLabel = UILabel().then {
            $0.textColor = CommonUIAsset.black.color
            $0.font = CoreTypo.ButtonLarge.style.font
            $0.text = notiArray[section].header
        }
        
        let border = UIView().then {
            $0.backgroundColor = CommonUIAsset.whiteGrey.color
        }
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(border)
        
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        border.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
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
