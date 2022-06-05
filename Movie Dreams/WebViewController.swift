//
//  WatchNowController.swift
//  Movie Dreams
//
//  Created by Илья Шаповалов on 04.06.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    //MARK: - Public Properties
    var webSite: String?
    //MARK: - Private Properties
    private var webView: WKWebView!
    
    
    private lazy var closeButton: UIButton = {
        $0.frame = CGRect(x: 40, y: 40, width: 0, height: 0)
        $0.setImage(UIImage(systemName: "xmark.square.fill"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
      return $0
    }(UIButton())
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        configureWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setConstrains()
    }
    
    @objc private func closeTapped() {
        self.dismiss(animated: true)
    }
    
   //MARK: - configureWebView
    private func configureWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView?.navigationDelegate = self
        view.addSubview(webView)
        webView.frame = view.bounds
        view.sendSubviewToBack(webView)
        view.addSubview(closeButton)
        
    }
    //MARK: - setupWebView
    private func setupWebView() {
        guard let unwrappedURL = webSite else { return }
        guard let url = URL(string: unwrappedURL) else { return }
        webView?.load(URLRequest(url: url))
        webView?.allowsBackForwardNavigationGestures = true
        
    }
    
}

extension WebViewController {
    
    private func setConstrains() {
    NSLayoutConstraint.activate([
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        closeButton.widthAnchor.constraint(equalToConstant: 60),
        closeButton.heightAnchor.constraint(equalToConstant: 60)
    ])
    }
}
