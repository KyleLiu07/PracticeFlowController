//
//  FirstTabCoordinator.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/8.
//

import UIKit

class FirstTabCoordinator: Coordinator<UINavigationController> {
    override func start() {
        guard !started else { return }
        let viewController = FirstTabViewController()
        viewController.delegate = self
        show(viewController: viewController)
        super.start()
    }
}

extension FirstTabCoordinator: FirstTabViewControllerDelegate {
    func pushToSecondPage(_ viewController: FirstTabViewController) {
        startChild(coordinator: FirstTabSecondCoordinator(viewController: rootViewController))
    }
}
