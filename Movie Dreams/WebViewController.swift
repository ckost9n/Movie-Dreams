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
    private var progressView: UIProgressView!
    
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        configureWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        setupToolBar()
    }
    
    //MARK: - Private Methods
    @objc private func shareTapped() {
        let viewController = UIActivityViewController(activityItems: [webView.url ?? "Not found"], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }
    
    private func configureWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView?.navigationDelegate = self
        view = webView
    }
    
    private func setupWebView() {
        view.backgroundColor = .black
        guard let unwrappedURL = webSite else { return }
        guard let url = URL(string: unwrappedURL) else { return }
        webView?.load(URLRequest(url: url))
        webView?.allowsBackForwardNavigationGestures = true
        webView?.addObserver(self,
                             forKeyPath: #keyPath(WKWebView.estimatedProgress),
                             options: .new,
                             context: nil)
    }
    
    private func setupToolBar() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: webView,
                                   action: #selector(webView.goBack))
        let forward = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"),
                                      style: .plain,
                                      target: webView,
                                      action: #selector(webView.goForward))
        
        toolbarItems = [back, spacer, forward, spacer, share, spacer, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "estimatedProgress" {
                progressView.progress = Float(webView.estimatedProgress)
            }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        let url = navigationAction.request.url
//        if url!.absoluteString.range(of: "about:blank") != nil {
//                decisionHandler(.cancel)
//                return
//           }
//            decisionHandler(.cancel)
//    }
    
}
