//
//  JSBridgePlugin.swift
//  HybridKit
//
//  Created by Songming on 2019/6/12.
//

import Foundation

public protocol JSBridgePlugin {
    typealias APIName = String
    typealias APIParam = [String: String]

    var name: APIName { get set }
    func handle(params: APIParam?) -> Any?
}
