//
//  SearchKakaoPostCodeViewController.swift
//  RegisterBusiness
//
//  Created by mincheol on 2023/02/19.
//  Copyright © 2023 team.io. All rights reserved.
//

import Foundation
import CommonUI
import WebKit
import RxCocoa
import RxSwift

protocol SearchKakaoPostCodeViewControllerDelegate {
    func setAddressTextField(address: [String: Any])
}

class SearchKakaoPostCodeViewController: BaseViewController {
    
    // MARK: Properties
    
    let contentController = WKUserContentController()
    let configuration = WKWebViewConfiguration()
    let indicator = UIActivityIndicatorView(style: .medium)
    var delegate: SearchKakaoPostCodeViewControllerDelegate?
    
    // MARK: UI Properties
    private let container = UIButton()
    private lazy var webView = WKWebView()
    
    override init() {
        super.init()
        contentController.add(self, name: "callBackHandler")
        configuration.userContentController = contentController
        webView = WKWebView.init(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://2222min.github.io/ssmr-KaKao-PostCode/") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
        self.bind()
    }
    
    override func configureUI() {
        self.view.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0).withAlphaComponent(0.5)
        self.view.addSubview(self.container)
        self.container.addSubview(self.webView)
        self.webView.addSubview(self.indicator)
    }
    
    // MARK: Constraints
    override func setupConstraints() {
        self.container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.webView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(28)
            $0.height.equalTo(400)
        }
        self.indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func bind() {
        self.container.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dismiss(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}

extension SearchKakaoPostCodeViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        guard  let data = message.body as? [String: Any]
        else { return }
        
        self.delegate?.setAddressTextField(address: data)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchKakaoPostCodeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
