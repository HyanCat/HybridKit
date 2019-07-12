//
//  HybridOption.swift
//  HybridKit
//
//  Created by Songming on 2019/7/10.
//

import Foundation

open class HybridOptions {
    open var showNavigationBar: Bool = true
    open var preferWebTitle: Bool = true
    open var loading: Loading? = nil
    open var errorView: ErrorView? = nil

    public init() {}
}
