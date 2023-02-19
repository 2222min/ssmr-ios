//
//  BaseViewController.swift
//  CommonUI
//
//  Created by mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

open class BaseViewController: UIViewController {
    
    // MARK: Properties
    public var disposeBag: DisposeBag = DisposeBag()
    var viewDisposeBag: DisposeBag?
    
    private(set) var didSetupConstraints = false
    private(set) var didSetupSubViews = false
    
    private var scrollViewOriginalContentInsetAdjustmentBehaviorRawValue: Int?
    
    public var navigationTopBar = NavigationTopBar().then {
        $0.leftButton.setImage(CommonUIAsset.chevronLeft.image, for: .normal)
    }
    
    // MARK: UI Properties
    
    var convertSccenSize: CGFloat {
        return min(UIScreen.main.bounds.width, 375)
    }
    
    // MARK: Initializing
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsUpdateConstraints()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.configureUI()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // fix is 11 scroll view bug
        if let scrollView = self.view.subviews.first as? UIScrollView {
            self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue = scrollView.contentInsetAdjustmentBehavior.rawValue
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        viewDisposeBag = DisposeBag()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewDisposeBag = nil
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let navi = self.navigationController, navi.viewControllers.first != self {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        if let scrollView = self.view.subviews.first as? UIScrollView,
           let rawValue = self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue,
           let behavior = UIScrollView.ContentInsetAdjustmentBehavior(rawValue: rawValue) {
            scrollView.contentInsetAdjustmentBehavior = behavior
        }
    }
    
    
    // 뷰컨트롤의 뷰 제약조건을 업데이트 하기 위해 호출
    open override func updateViewConstraints() {
        if !self.didSetupConstraints {
            // TODO -- 공통으로 필요한 것을 여기서 생성
            
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
        
    }
    
    // 뷰컨트롤러의 뷰가 하위뷰를 표시했음을 알리기 위해 호출
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !self.didSetupSubViews {
            self.setupSubViews()
            self.didSetupSubViews = true
        }
    }
    
    // MARK: Func
    
    open func configureUI() {
        self.view.addSubview(navigationTopBar)
    }
    
    open func setupConstraints() {
        self.navigationTopBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
    }
    
    open func setupSubViews() {}
    
    open func subscribeUI() {
        self.navigationTopBar.rx.leftButtonDidTap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    open func hideNavigationBar() {
        self.navigationTopBar.isHidden = true
    }
}

extension BaseViewController: UIGestureRecognizerDelegate { }


extension Reactive where Base: BaseViewController {
    internal var barIsHidden: Binder<Bool> {
        return Binder(self.base) { view, hidden in
            UIView.animate(withDuration: 0.5) {
                view.tabBarController?.tabBar.isHidden = hidden
            }
        }
    }
}

