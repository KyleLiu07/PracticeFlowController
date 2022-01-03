//
//  ToDoDetailFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/10.
//

import UIKit

class ToDoDetailFlowController: LogViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = ToDoDetailViewController(navigationItem: navigationItem)
        viewController.delegate = self
        add(viewController)
    }
}

extension ToDoDetailFlowController: ToDoDetailViewControllerDelegate {
    func detailViewControllerEdit(_ viewController: ToDoDetailViewController) {
        let flowController = EditToDoFlowController()
        navigationController?.pushViewController(flowController, animated: true)
    }
}
