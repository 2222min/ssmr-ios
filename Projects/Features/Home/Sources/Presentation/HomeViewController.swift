//
//  HomeViewController.swift
//  Root
//
//  Created mincheol on 2023/04/18.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import SnapKit
import Then
import ReactorKit
import RxCocoa
import RxSwift
import CommonUI

final public class HomeViewController: BaseViewController, ReactorKit.View {

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
    
    private let sectionA = SectionAViewController()
    private let sectionB = MDPickSectionViewController()
    private let sectionC = SectionCViewController()
    private let sectionD = SectionDViewController()
    private let sectionE = SectionEViewController()

	// MARK: UI Properties
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    private let container = UIStackView().then {
        $0.backgroundColor = .white
        $0.axis = .vertical
        $0.spacing = 36
    }
    
	// MARK: Initializing
    public init(reactor: HomeReactor) {
		defer {
			self.reactor = reactor
		}
        super.init()
	}

    required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View Life Cycle
    override public func viewDidLoad() {
		super.viewDidLoad()
	}

    override public func configureUI() {
        super.configureUI()
        hideNavigationBar()
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(container)
        [
            self.sectionA.view,
            self.sectionB.view,
            self.sectionC.view,
            self.sectionD.view,
            self.sectionE.view
        ].forEach(self.container.addArrangedSubview)
	}

	// MARK: Constraints
    override public func setupConstraints() {
        super.setupConstraints()
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.container.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self.scrollView)
        }
        
        self.container.setCustomSpacing(24, after: self.sectionA.view)
	}
}

// MARK: ReactorBind
extension HomeViewController {
    public func bind(reactor: HomeReactor) {
	}
}

// MARK: Action
extension HomeViewController {}

// MARK: State
extension HomeViewController {}

// MARK: Func
extension HomeViewController {}
