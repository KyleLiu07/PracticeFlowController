//
//  EditToDoViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2022/1/1.
//

import UIKit

protocol EditToDoViewControllerDelegate: AnyObject {
    func addToDoViewControllerDidDismiss(_ viewController: EditToDoViewController)
}

class EditToDoViewController: LogViewController {
    enum `Type` {
        case add, edit
    }

    weak var delegate: EditToDoViewControllerDelegate?

    init(navigationItem: UINavigationItem? = nil, type: `Type`) {
        super.init(nibName: nil, bundle: nil)

        switch type {
        case .add:
            let closeButton = UIButton(type: .custom)
            closeButton.setTitle("Close", for: .normal)
            closeButton.setTitleColor(.black, for: .normal)
            closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
            view.addSubview(closeButton)
            closeButton.frame = CGRect(origin: CGPoint(x: 16, y: 16), size: CGSize(width: 80, height: 44))
        case .edit:
            guard let navigationItem = navigationItem else {
                assertionFailure("Need navigation item")
                return
            }
            navigationItem.title = "Edit ToDo"
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    @objc private func close() {
        delegate?.addToDoViewControllerDidDismiss(self)
    }
}
