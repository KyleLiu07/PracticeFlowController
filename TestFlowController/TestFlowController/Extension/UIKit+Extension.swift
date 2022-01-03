//
//  UIKit+Extension.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/10.
//

import UIKit


extension UIButton {
    static func generateButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 2
        return button
    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove(child: UIViewController) {
        guard child.parent != nil else { return }

        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
