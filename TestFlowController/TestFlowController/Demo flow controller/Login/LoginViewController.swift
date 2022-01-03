//
//  LoginViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2022/1/3.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewControllerDidLogin(_ viewController: LogViewController)
}

class LoginViewController: LogViewController {
    weak var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        let loginSuccessButton = UIButton(type: .custom)
        loginSuccessButton.setTitle("Login success", for: .normal)
        loginSuccessButton.setTitleColor(.black, for: .normal)
        loginSuccessButton.addTarget(self, action: #selector(loginSuccess), for: .touchUpInside)
        view.addSubview(loginSuccessButton)
        loginSuccessButton.frame = CGRect(x: 100, y: 100, width: 150, height: 44)
    }

    @objc private func loginSuccess() {
        delegate?.loginViewControllerDidLogin(self)
    }
}
