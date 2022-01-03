//
//  FirstTabSecondCoordinator.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/8.
//

import UIKit

class FirstTabSecondCoordinator: Coordinator<UINavigationController> {
    override func start() {
        guard !started else { return }

        let viewController = FirstTabSecondPageViewController()
        viewController.delegate = self
        viewController.hidesBottomBarWhenPushed = true
        show(viewController: viewController)
        super.start()
    }
}

extension FirstTabSecondCoordinator: FirstTabSecondPageViewControllerDelegate {
    func pushToThirdPage(_ viewController: FirstTabSecondPageViewController) {
        let coordinator = FirstTabThirdPageCoordinator(viewController: rootViewController)
        replace(children: [coordinator], for: parent!)
    }
}
