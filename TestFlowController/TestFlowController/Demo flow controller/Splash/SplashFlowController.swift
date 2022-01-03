//
//  SplashFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/20.
//

import UIKit

protocol SplashFlowControllerDelegate: AnyObject {
    func splashFlowControllerDidFinishLaunch(_ flowController: SplashFlowController)
}

class SplashFlowController: LogViewController {
    weak var delegate: SplashFlowControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = SplashViewController()
        viewController.delegate = self
        add(viewController)
    }
}

extension SplashFlowController: SplashViewControllerDelegate {
    func splashViewControllerDidFinishLaunch(_ viewController: SplashViewController) {
        delegate?.splashFlowControllerDidFinishLaunch(self)
    }
}
