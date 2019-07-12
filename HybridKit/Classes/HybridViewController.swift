//
//  HybridViewController.swift
//  HybridKit
//
//  Created by Songming on 2019/6/12.
//

import UIKit
import WebKit

extension WKProcessPool {
    static var sharedHybridProcessPool = WKProcessPool()
}

open class HybridViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {

    open var url: URL? {
        return nil
    }

    open var options: HybridOptions {
        return HybridOptions()
    }

    private var currentURL: URL? = nil

    private let webviewConfiguration = WKWebViewConfiguration()

    public lazy var webView: WKWebView = {
        webviewConfiguration.processPool = WKProcessPool.sharedHybridProcessPool
        return WKWebView(frame: .zero, configuration: webviewConfiguration)
    }()

    public let navigationBar: UINavigationBar = UINavigationBar()

    private lazy var jsBridgeContainer: JSBridgeContainer = {
        let container = JSBridgeContainer(webView: webView)
        container.jsBridge.setWebViewDelegate(self)
        return container
    }()

    private var navigationBarHeightConstraint: NSLayoutConstraint?

    override open func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle(for: HybridViewController.self).url(forResource: "HybridKit", withExtension: "bundle") {
            let assetBundle = Bundle(url: url)
            let image = UIImage(named: "hybrid_navigation_back", in: assetBundle, compatibleWith: nil)
            self.navigationItem.leftBarButtonItem =
                UIBarButtonItem(image: image,
                                style: .plain,
                                target: self,
                                action: #selector(navigationLeftButtonToueched(_:)))
        }

        webView.frame = self.view.bounds
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.delegate = self
        webView.scrollView.contentInset = .zero
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(webView)
        webView.scrollView.delegate = self

        self.view.bringSubviewToFront(navigationBar)

        loadWeb()

        jsBridgeContainer.boot()
    }

    func loadWeb() {
        guard let url = self.url else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        options.loading?.startLoding(on: self)
    }

    @objc
    private func navigationLeftButtonToueched(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - WKWebView Delegates

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if options.preferWebTitle {
            self.title = webView.title
        }
        options.loading?.endLoading(on: self, succeed: true)
        print("Hybrid: finished")
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        options.loading?.endLoading(on: self, succeed: false)
        options.errorView?.show(on: self, with: error)
        print("Hybrid: failed")
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
    }
}

extension HybridViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
