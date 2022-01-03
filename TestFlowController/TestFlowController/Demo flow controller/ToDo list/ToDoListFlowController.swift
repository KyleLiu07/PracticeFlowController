//
//  ToDoListFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/10.
//

import UIKit
import Combine

class ToDoListFlowController: UIViewController {
    private var subscriptions: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = ToDoListViewController(navigationItem: navigationItem)
        viewController.delegate = self
        add(viewController)
    }
}

extension ToDoListFlowController: ToDoListViewControllerDelegate {
    func listControllerPresentAddToDo(_ viewController: ToDoListViewController) {
        let flowController = AddToDoFlowController()
        flowController.delegate = self
        present(flowController, animated: true, completion: nil)
    }

    func listControllerPushToDetail(_ viewController: ToDoListViewController) {
        let flowController = ToDoDetailFlowController()
        navigationController?.pushViewController(flowController, animated: true)
    }
}

extension ToDoListFlowController: AddToDoFlowControllerDelegate {
    func addToDoDidDismiss(_ flowController: AddToDoFlowController) {
        flowController.dismiss(animated: true, completion: nil)
    }
}
