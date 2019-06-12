//
//  ViewController.swift
//  HybridKit
//
//  Created by 加少 on 06/12/2019.
//  Copyright (c) 2019 加少. All rights reserved.
//

import UIKit
import HybridKit

class Plugin4User: JSBridgePlugin {
    var name: JSBridgePlugin.APIName = "user"

    func handle(params: JSBridgePlugin.APIParam?) -> Any? {
        print("handle js api: user")
        return nil
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        JSBridgeEngine.default.register(plugin: Plugin4User())
    }

}

