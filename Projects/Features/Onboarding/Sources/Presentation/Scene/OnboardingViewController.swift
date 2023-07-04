//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import CommonUI

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then
import ReusableKit
import LoginDomain

public class OnboardingViewController: BaseViewController, ReactorKit.View {
    
    public struct Dependency {
        let loginVC: LoginViewControllerFactoryType
        public init(loginVC: LoginViewControllerFactoryType) {
            self.loginVC = loginVC
        }
    }
    
    public typealias Reactor = OnboardingReactor
    
    // MARK: Constants
    private enum Constants {
        static let skipButtonText = "서비스 둘러보기".styled(
            typo: .Body2,
            byAdding: [.color(CommonUIAsset.grey.color)]
        )
    }
    
    private enum Reusable {
        static let onboardingCollectionViewCell =
        ReusableCell<OnboardingCollectionViewCell>()
    }
    
    // MARK: Properties
    var previousOffset: CGFloat = 0
    // MARK: UI Properties
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
            $0.itemSize = .init(width: UIScreen.main.bounds.width, height: 513)
        }
    ).then {
        $0.showsHorizontalScrollIndicator = false
        $0.decelerationRate = .fast
        $0.isPagingEnabled = true
        $0.register(Reusable.onboardingCollectionViewCell)
    }
    
    private let nextButton = CTAButton()
    private let skipButton = UIButton().then {
        $0.setAttributedTitle(
            Constants.skipButtonText,
            for: .normal
        )
    }
    private let pageControl = UIPageControl().then {
        $0.numberOfPages = 3
        $0.pageIndicatorTintColor = CommonUIAsset.grey.color
        $0.currentPageIndicatorTintColor = CommonUIAsset.pointColor.color
    }
    public var dependency: Dependency
    // MARK: Initializing
    public init(
        reactor: Reactor,
        dependency: Dependency
    ) {
        defer {
            self.reactor = reactor
        }
        self.dependency = dependency
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    open override func configureUI() {
        super.configureUI()
        
        [
            self.collectionView,
            self.pageControl,
            self.nextButton,
            self.skipButton
        ]
            .forEach(self.view.addSubview)
    }
    
    // MARK: Constraints
    open override func setupConstraints() {
        super.setupConstraints()
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(513)
        }
        self.pageControl.snp.makeConstraints {
            $0.top.equalTo(self.collectionView.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(7)
        }
        self.nextButton.snp.makeConstraints {
            $0.top.equalTo(self.collectionView.snp.bottom).offset(80)
            $0.bottom.equalTo(self.skipButton.snp.top).offset(-13)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        self.skipButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(63)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }
}

// MARK: ReactorBind
extension OnboardingViewController {
    public func bind(reactor: Reactor) {
        //Func
        self.bindDidTapSkipButton()
        // Action
        self.bindAction(moveCurrentPage: reactor)
        self.bindAction(didTapCTAButton: reactor)
        // State
        self.bindState(imageArr: reactor)
        self.bindState(currenPage: reactor)
        self.bindState(moveToLoginPage: reactor)
    }
}

// MARK: Action
extension OnboardingViewController {
    private func bindAction(moveCurrentPage reactor: Reactor) {
        self.collectionView.rx.didEndDecelerating
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let offsetX = ceil(self.collectionView.contentOffset.x)
                let width = self.collectionView.frame.width
                let page = Int(offsetX / width)
                reactor.action.onNext(.moveCurrentPage(page))
            })
            .disposed(by: self.disposeBag)
    }
    private func bindAction(didTapCTAButton reactor: Reactor) {
        self.nextButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                if self.pageControl.currentPage != 2 {
                    let contentOffset = self.collectionView.contentOffset.x
                    let width = self.collectionView.bounds.width
                    self.collectionView.setContentOffset(.init(x: width + contentOffset, y: 0), animated: true)
                }
            })
            .map { Reactor.Action.didTapCTAButton(self.pageControl.currentPage) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}

// MARK: State
extension OnboardingViewController {
    private func bindState(imageArr reactor: Reactor) {
        reactor.state.map { $0.dataSoruce }
            .asDriver(onErrorJustReturn: [])
            .drive(self.collectionView.rx.items(
                cellIdentifier: Reusable.onboardingCollectionViewCell.identifier,
                cellType: Reusable.onboardingCollectionViewCell.class)) { _, item, cell in
                    cell.configure(item: item)
                }.disposed(by: disposeBag)
    }
    private func bindState(currenPage reactor: Reactor) {
        reactor.state.map { $0.currentPage }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] currentPage in
                guard let self = self else { return }
                self.changeCurrentPage(currentPage)
            })
            .disposed(by: self.disposeBag)
    }
    private func bindState(moveToLoginPage reactor: Reactor) {
        reactor.state.map { $0.moveToLoginPage }
            .filter { $0 }
            .asDriver(onErrorDriveWith: .empty())
            .drive (with: self, onNext: { (_, _) in
                let loginVC = self.dependency.loginVC.create(
                    payload: .init(paramA: "")
                )
                
                // rootViewController 변경
                guard let window = UIApplication.shared.windows.first else { return }
                let rootVC = UINavigationController(rootViewController: loginVC)
                
                UIView.transition(
                    with: window,
                    duration: 0.5,
                    options: .transitionCrossDissolve,
                    animations: {
                        window.rootViewController = rootVC
                    },
                    completion: nil
                )
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: Func
extension OnboardingViewController {
    public static func create(dependency: Dependency) -> OnboardingViewController? {
        let onboardingReactor = OnboardingReactor()
        let onboardingVC = OnboardingViewController(
            reactor: onboardingReactor,
            dependency: dependency
        )
        
        return onboardingVC
    }
    private func changeCurrentPage(_ page: Int) {
        self.pageControl.setIndicatorImage(nil, forPage: self.pageControl.currentPage)
        self.pageControl.currentPage = page
        self.pageControl.setIndicatorImage(CommonUIAsset.selectedDot.image, forPage: page)
        
        if page == 2 {
            self.nextButton.title = "땡리단길로 가기"
        } else {
            self.nextButton.title = "다음"
        }
    }
    private func bindDidTapSkipButton() {
        self.skipButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe { _ in
                // TODO: Home 페이지로 이동하는 코드 작성
                print("Move To Home Page")
            }
            .disposed(by: self.disposeBag)
            
    }
}
