//
//  SignupViewController.swift
//  TestFlowController
//
//  Created by Kyle on 2022/1/3.
//

import UIKit

protocol SignupViewControllerDelegate: AnyObject {
    func signupViewControllerDidSignup(_ viewController: SignupViewController)
}

class SignupViewController: LogViewController {
    weak var delegate: SignupViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign up"
        view.backgroundColor = .white
        let signUpSuccessButton = UIButton(type: .custom)
        signUpSuccessButton.setTitle("Sign up success", for: .normal)
        signUpSuccessButton.setTitleColor(.black, for: .normal)
        signUpSuccessButton.addTarget(self, action: #selector(signUpSuccess), for: .touchUpInside)
        view.addSubview(signUpSuccessButton)
        signUpSuccessButton.frame = CGRect(x: 100, y: 100, width: 150, height: 44)
    }

    @objc private func signUpSuccess() {
        delegate?.signupViewControllerDidSignup(self)
    }
}
