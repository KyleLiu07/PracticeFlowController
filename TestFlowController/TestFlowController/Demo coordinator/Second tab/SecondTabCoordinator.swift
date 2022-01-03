//
//  SecondTabCoordinator.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

class SecondTabCoordinator: Coordinator<UINavigationController> {
    override func start() {
        guard !started else { return }
        let viewController = SecondTabViewController()
        viewController.delegate = self
        show(viewController: viewController)
        super.start()
    }
}

extension SecondTabCoordinator: SecondTabViewControllerDelegate {
    func pushToSecondPage(_ viewController: SecondTabViewController) {
        startChild(coordinator: SecondTabSecondPageCoordinator(viewController: rootViewController))
    }
}
