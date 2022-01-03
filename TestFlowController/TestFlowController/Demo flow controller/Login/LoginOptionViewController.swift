//
//  LoginOptionViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2022/1/3.
//

import UIKit

protocol LoginOptionViewControllerDelegate: AnyObject {
    func optionViewControllerDidDismiss(_ flowController: LoginOptionViewController)
    func optionViewControllerRedirectToLogin(_ viewController: LoginOptionViewController)
    func optionViewControllerRedirectToSignup(_ viewController: LoginOptionViewController)
}

class LoginOptionViewController: LogViewController {
    weak var delegate: LoginOptionViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let closeItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        navigationItem.leftBarButtonItems = [closeItem]

        let loginButton = UIButton(type: .custom)
        loginButton.layer.borderColor = UIColor.red.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 100, y: 100, width: 80, height: 44)

        let signupButton = UIButton(type: .custom)
        signupButton.layer.borderColor = UIColor.green.cgColor
        signupButton.layer.borderWidth = 1
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
        view.addSubview(signupButton)
        signupButton.frame = CGRect(x: 100, y: 200, width: 80, height: 44)
    }
}

private extension LoginOptionViewController {
    @objc func login() {
        delegate?.optionViewControllerRedirectToLogin(self)
    }

    @objc func signup() {
        delegate?.optionViewControllerRedirectToSignup(self)
    }

    @objc func close() {
        delegate?.optionViewControllerDidDismiss(self)
    }
}
