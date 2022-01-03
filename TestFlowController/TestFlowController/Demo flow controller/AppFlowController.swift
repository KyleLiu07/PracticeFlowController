//
//  AppFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/11.
//

import UIKit

class AppFlowController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        startSplash()
    }
}

private extension AppFlowController {
    func startMain() {
        let flowController = RootTabBarFlowController()
        add(flowController)
        flowController.presentLoginOption(with: false)
    }

    func startSplash() {
        let flowController = SplashFlowController()
        flowController.delegate = self
        add(flowController)
    }
}

extension AppFlowController: SplashFlowControllerDelegate {
    func splashFlowControllerDidFinishLaunch(_ flowController: SplashFlowController) {
        guard let splashController = children.first as? SplashFlowController else { return }
        remove(child: splashController)
        startMain()
    }
}
