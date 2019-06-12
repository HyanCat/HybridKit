//
//  JSBridgeEngine.swift
//  HybridKit
//
//  Created by Songming on 2019/6/12.
//

import Foundation

public class JSBridgeEngine {
    public static let `default` = JSBridgeEngine()

    internal private(set) var plugins: [JSBridgePlugin] = []

    public func register(plugin: JSBridgePlugin) {
        plugins.append(plugin)
    }
}
