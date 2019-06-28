//
//  HybridViewController.swift
//  HybridKit
//
//  Created by Songming on 2019/6/12.
//

import UIKit
import WebKit

open class HybridViewController: UIViewController, UIScrollViewDelegate, WKUIDelegate, WKNavigationDelegate {

    open var url: URL? {
        return nil
    }

    open var preferWebTitle: Bool = true

    private var currentURL: URL? = nil

    public let webView: WKWebView = WKWebView(frame: .zero)

    public let navigationBar: UINavigationBar = UINavigationBar()

    private lazy var jsBridgeContainer: JSBridgeContainer = {
        JSBridgeContainer(webView: webView)
    }()

    private var navigationBarHeightConstraint: NSLayoutConstraint?

    override open func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(navigationBar)
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hybrid_navigation_back"), style: .plain, target: self, action: #selector(navigationLeftButtonToueched))
        navigationBar.items = [navigationItem]
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.delegate = self
        if #available(iOS 9.0, *) {
            navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            if #available(iOS 11, *) {
                navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            } else {
                navigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            }
        }

        webView.frame = self.view.bounds
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.delegate = self
        webView.scrollView.contentInset = .zero
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(webView)
        webView.scrollView.delegate = self
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        webView.uiDelegate = self
        webView.navigationDelegate = self

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
    }

    @objc
    private func navigationLeftButtonToueched() {

    }

    // MARK: - WKWebView Delegates

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if preferWebTitle {
            self.title = webView.title
        }
        print("Hybrid: finished")
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
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
