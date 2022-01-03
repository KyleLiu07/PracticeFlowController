//
//  FirstTabThirdPageCoordinator.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

class FirstTabThirdPageCoordinator: Coordinator<UINavigationController>, CoordinatingVisibleViewController {
    private let viewController = FirstTabThirdPageViewController()
    var visibleViewController: UIViewController { viewController }

    override func start() {
        guard !started else { return }
        show(viewController: viewController)
        super.start()
    }
}
