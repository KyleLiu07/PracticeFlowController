//
//  SecondTabViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

protocol SecondTabViewControllerDelegate: AnyObject {
    func pushToSecondPage(_ viewController: SecondTabViewController)
}

class SecondTabViewController: UIViewController {
    weak var delegate: SecondTabViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Second tab view"

        let button = UIButton.generateButton(title: "Push to second")
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func tap() {
        delegate?.pushToSecondPage(self)
    }
}
