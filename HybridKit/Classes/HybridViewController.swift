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

    let webView: WKWebView = WKWebView(frame: .zero)
    let navigationBar: UINavigationBar = UINavigationBar()

    private lazy var jsBridgeContainer: JSBridgeContainer = {
        JSBridgeContainer(webView: webView)
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()

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

    // MARK: - WKWebView Delegates

    private func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if preferWebTitle {
            self.title = webView.title
        }
        print("Hybrid: finished")
    }

    private func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Hybrid: failed")
    }

    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
    }
}

