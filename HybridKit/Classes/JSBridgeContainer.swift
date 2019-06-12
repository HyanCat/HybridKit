//
//  JSBridgeContainer.swift
//  HybridKit
//
//  Created by Songming on 2019/6/12.
//

import Foundation
import WebViewJavascriptBridge

class JSBridgeContainer {

    let webView: WKWebView
    let jsBridge: WKWebViewJavascriptBridge

    init(webView: WKWebView) {
        self.webView = webView
        self.jsBridge = WKWebViewJavascriptBridge(for: webView)

        #if DEBUG
        WKWebViewJavascriptBridge.enableLogging()
        #endif
    }

    func boot() {
        JSBridgeEngine.default.plugins.forEach { plugin in
            self.jsBridge.registerHandler(plugin.name, handler: { (data, callback) in
                let params: JSBridgePlugin.APIParam? = data as? JSBridgePlugin.APIParam
                let result = plugin.handle(params: params)
                callback?(result)
            })
        }
    }
}
