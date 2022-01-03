//
//  ToDoDetailViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/10.
//

import UIKit

protocol ToDoDetailViewControllerDelegate: AnyObject {
    func detailViewControllerEdit(_ viewController: ToDoDetailViewController)
}

class ToDoDetailViewController: LogViewController {
    weak var delegate: ToDoDetailViewControllerDelegate?
    init(navigationItem: UINavigationItem) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "ToDo Detail"

        let editItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItems = [editItem]
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    @objc private func edit() {
        delegate?.detailViewControllerEdit(self)
    }
}
