//
//  SecondTabSecondPageViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

protocol SecondTabSecondPageViewControllerDelegate: AnyObject {
    func presentPage(_ viewController: SecondTabSecondPageViewController)
}

class SecondTabSecondPageViewController: UIViewController {
    weak var delegate: SecondTabSecondPageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Second tab second page"

        let button = UIButton.generateButton(title: "Present page")
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func tap() {
        delegate?.presentPage(self)
    }
}
