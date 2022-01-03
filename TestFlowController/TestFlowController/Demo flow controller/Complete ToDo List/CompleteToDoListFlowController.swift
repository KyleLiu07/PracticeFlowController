//
//  CompleteToDoListFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/10.
//

import UIKit

class CompleteToDoListFlowController: LogViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = CompleteToDoListViewController(navigationItem: navigationItem)
        add(viewController)
    }
}
