//
//  RootTabBarDelegateProxy.swift
//  Play-iOS
//
//  Created by Green on 2020/10/26.
//

import UIKit

protocol RootTabBarDelegateProxyDelegate : AnyObject {
    func rootTabBarDelegateProxy( _ proxy: RootTabBarDelegateProxy, didSelect viewController: UIViewController)
    func rootTabBarDelegateProxy( _ proxy: RootTabBarDelegateProxy, shouldSelect viewController: UIViewController) -> Bool
}

class RootTabBarDelegateProxy: NSObject, UITabBarControllerDelegate {
    weak var delegate: RootTabBarDelegateProxyDelegate?

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let delegate = delegate else { return true }
        return delegate.rootTabBarDelegateProxy(self, shouldSelect: viewController)
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        delegate?.rootTabBarDelegateProxy(self, didSelect: viewController)
    }
}
