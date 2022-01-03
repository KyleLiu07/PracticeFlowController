//
//  EditToDoFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2022/1/1.
//

import UIKit

class EditToDoFlowController: LogViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let editViewController = EditToDoViewController(navigationItem: navigationItem, type: .edit)
        add(editViewController)
    }
}
