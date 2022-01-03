//
//  ToDoListViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2022/1/1.
//

import UIKit

protocol ToDoListViewControllerDelegate: AnyObject {
    func listControllerPresentAddToDo(_ viewController: ToDoListViewController)
    func listControllerPushToDetail(_ viewController: ToDoListViewController)
}

class ToDoListViewController: UIViewController {
    weak var delegate: ToDoListViewControllerDelegate?

    init(navigationItem: UINavigationItem) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "ToDo List"
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        navigationItem.rightBarButtonItems = [addItem]
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Simulate tap one todo and push to todo detail
        let detailButton = UIButton(type: .custom)
        detailButton.setTitle("Detail", for: .normal)
        detailButton.setTitleColor(.black, for: .normal)
        detailButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
        view.addSubview(detailButton)
        detailButton.frame = CGRect(x: 100, y: 100, width: 80, height: 44)
    }

    @objc private func addToDo() {
        delegate?.listControllerPresentAddToDo(self)
    }

    @objc private func goToDetail() {
        delegate?.listControllerPushToDetail(self)
    }
}
