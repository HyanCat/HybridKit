//
//  Loading.swift
//  HybridKit
//
//  Created by Songming on 2019/7/11.
//

import Foundation

public protocol Loading {
    func startLoding(on viewController: HybridViewController)
    func endLoading(on viewController: HybridViewController, succeed: Bool)
}
