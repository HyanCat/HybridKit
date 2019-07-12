//
//  ErrorView.swift
//  HybridKit
//
//  Created by Songming on 2019/7/12.
//

import Foundation

public protocol ErrorView {
    func show(on viewController: HybridViewController, with error: Error)
}
