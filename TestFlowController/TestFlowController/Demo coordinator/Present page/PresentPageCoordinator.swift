//
//  PresentPageCoordinator.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

class PresentPageCoordinator: Coordinator<UIViewController> {
    override func start() {
        guard !started else { return }

        let viewController = PresentPageViewController()
        viewController.delegate = self
        present(viewController: viewController)
    }
}

extension PresentPageCoordinator: PresentPageViewControllerDelegate {
    func dismiss(_ viewController: PresentPageViewController) {
        dismiss()
    }
}
