//
//  JSBridgePlugin.swift
//  HybridKit
//
//  Created by Songming on 2019/6/12.
//

import Foundation

public protocol JSBridgePlugin {
    typealias Name = String
    typealias Param = [String: Any]

    var name: Name { get set }
    func handle(params: Param?) -> Any?
}
