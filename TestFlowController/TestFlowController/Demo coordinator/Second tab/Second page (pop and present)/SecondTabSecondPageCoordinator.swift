//
//  SecondTabSecondPageCoordinator.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

class SecondTabSecondPageCoordinator: Coordinator<UINavigationController> {
    override func start() {
        guard !started else { return }
        let viewController = SecondTabSecondPageViewController()
        viewController.delegate = self
        show(viewController: viewController)
        super.start()
    }
}

extension SecondTabSecondPageCoordinator: SecondTabSecondPageViewControllerDelegate {
    func presentPage(_ viewController: SecondTabSecondPageViewController) {
        pop()
        startChild(coordinator: PresentPageCoordinator(viewController: rootViewController))
    }
}
