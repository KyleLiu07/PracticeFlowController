//
//  AddToDoFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/20.
//

import UIKit

protocol AddToDoFlowControllerDelegate: AnyObject {
    func addToDoDidDismiss(_ flowController: AddToDoFlowController)
}

class AddToDoFlowController: LogViewController {
    weak var delegate: AddToDoFlowControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let addToDoViewController = EditToDoViewController(type: .add)
        addToDoViewController.delegate = self
        add(addToDoViewController)
    }
}

extension AddToDoFlowController: EditToDoViewControllerDelegate {
    func addToDoViewControllerDidDismiss(_ viewController: EditToDoViewController) {
        delegate?.addToDoDidDismiss(self)
    }
}
