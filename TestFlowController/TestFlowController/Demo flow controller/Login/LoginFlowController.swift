//
//  LoginFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2022/1/3.
//

import UIKit

protocol LoginFlowControllerDelegate: AnyObject {
    func loginFlowControllerDidDismiss(_ flowController: LoginFlowController)
}

enum LoginCancelAction {
    case none, backToHome
}

class LoginFlowController: LogViewController {
    private let navigation = UINavigationController()
    weak var delegate: LoginFlowControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let optionViewController = LoginOptionViewController()
        optionViewController.delegate = self
        navigation.viewControllers = [optionViewController]
        add(navigation)
    }
}

private extension LoginFlowController {
    func dismissLoginFlowController() {
        delegate?.loginFlowControllerDidDismiss(self)
    }
}

extension LoginFlowController: LoginOptionViewControllerDelegate {
    func optionViewControllerRedirectToLogin(_ viewController: LoginOptionViewController) {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        navigation.pushViewController(loginViewController, animated: true)
    }

    func optionViewControllerRedirectToSignup(_ viewController: LoginOptionViewController) {
        let signupViewController = SignupViewController()
        signupViewController.delegate = self
        navigation.pushViewController(signupViewController, animated: true)
    }

    func optionViewControllerDidDismiss(_ flowController: LoginOptionViewController) {
        dismissLoginFlowController()
    }
}

extension LoginFlowController: LoginViewControllerDelegate {
    func loginViewControllerDidLogin(_ viewController: LogViewController) {
        dismissLoginFlowController()
    }
}

extension LoginFlowController: SignupViewControllerDelegate {
    func signupViewControllerDidSignup(_ viewController: SignupViewController) {
        dismissLoginFlowController()
    }
}
