//
//  FirstTabSecondPageViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

protocol FirstTabSecondPageViewControllerDelegate: AnyObject {
    func pushToThirdPage(_ viewController: FirstTabSecondPageViewController)
}

class FirstTabSecondPageViewController: UIViewController {
    weak var delegate: FirstTabSecondPageViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "First tab second page"

        let button = UIButton.generateButton(title: "Push to third")
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func tap() {
        delegate?.pushToThirdPage(self)
    }
}
