//
//  CategoryViewController + CompositionalLayout.swift
//  Search
//
//  Created by mincheol on 2023/04/11.
//  Copyright © 2023 team.io. All rights reserved.
//
import UIKit

extension CategoryViewController {
     func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex:Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(60),
                heightDimension: .absolute(36)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(60)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            group.interItemSpacing = .fixed(12)
            group.edgeSpacing = .init(leading: nil, top: .fixed(8), trailing: nil, bottom: nil)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
            section.supplementariesFollowContentInsets = false
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .vertical
            let layout = UICollectionViewCompositionalLayout(section: section)
            layout.configuration = config
            // Header
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(52)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            // Background
            let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "background")
            
            section.decorationItems = [sectionBackgroundDecoration]
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
}
