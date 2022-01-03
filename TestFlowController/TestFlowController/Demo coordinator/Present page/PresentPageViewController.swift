//
//  PresentPageViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

protocol PresentPageViewControllerDelegate: AnyObject {
    func dismiss(_ viewController: PresentPageViewController)
}

class PresentPageViewController: UIViewController {
    weak var delegate: PresentPageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        modalPresentationStyle = .fullScreen

        let button = UIButton.generateButton(title: "Close")
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func tap() {
        delegate?.dismiss(self)
    }
}
