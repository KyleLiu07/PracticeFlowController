//
//  CompleteToDoListViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2022/1/2.
//

import UIKit

class CompleteToDoListViewController: LogViewController {

    init(navigationItem: UINavigationItem) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Completed List"
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let needLoginButton = UIButton(type: .custom)
        needLoginButton.setTitle("Need login", for: .normal)
        needLoginButton.setTitleColor(.black, for: .normal)
        needLoginButton.addTarget(self, action: #selector(needLogin), for: .touchUpInside)
        view.addSubview(needLoginButton)
        needLoginButton.frame = CGRect(x: 100, y: 100, width: 100, height: 44)
    }

    @objc private func needLogin() {
        let notification = Notification.routeSigninNotification(cancelAction: .none)
        NotificationCenter.default.post(notification)
    }
}
