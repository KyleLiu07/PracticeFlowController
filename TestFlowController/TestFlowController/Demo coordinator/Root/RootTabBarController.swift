//
//  RootTabBarController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/9.
//

import UIKit

protocol RootTabBarControllerDelegate: AnyObject {
    func tabBarController(_ controller: RootTabBarController, select tab: RootTabBarController.Tab)
    func tabBarController(_ controller: RootTabBarController, shouldSelected tab: RootTabBarController.Tab) -> Bool
}

class RootTabBarController: UITabBarController {
    private let tabBarDelegateProxy = RootTabBarDelegateProxy()
    weak var rootDelegate: RootTabBarControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .red
        tabBar.barTintColor = .white
        view.backgroundColor = .white
        delegate = tabBarDelegateProxy
        tabBarDelegateProxy.delegate = self
    }
}

extension RootTabBarController: RootTabBarDelegateProxyDelegate {
    func rootTabBarDelegateProxy(_ proxy: RootTabBarDelegateProxy, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController),
              let tab = Tab(rawValue: index),
              let rootDelegate = rootDelegate
        else { return false }

        if tab.requireSignup {
            return rootDelegate.tabBarController(self, shouldSelected: tab)
        }
        return true
    }

    func rootTabBarDelegateProxy( _ proxy: RootTabBarDelegateProxy, didSelect viewController: UIViewController) {
        guard let tab = Tab(rawValue: selectedIndex) else { return }
        rootDelegate?.tabBarController(self, select: tab)
    }
}

extension RootTabBarController {
    enum Tab: Int {
        case toDo, completion

        var title: String {
            switch self {
            case .toDo: return "ToDo"
            case .completion: return "Completed"
            }
        }

        var requireSignup: Bool {
            switch self {
            case .toDo:
                return false
            case .completion:
                return true
            }
        }
    }
}
