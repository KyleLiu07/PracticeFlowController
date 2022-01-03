//
//  Coordinating.swift
//  Play-iOS
//
//  Created by Green on 2019/2/15.
//

import UIKit.UIViewController

protocol Coordinating : AnyObject {
    var started: Bool { get }
    var isActive: Bool { get }
    var parent: Coordinating? { get set }
    var childCoordinators: [Coordinating] { get }
    func start()
    func startChild(coordinator: Coordinating)
    func stop()
    func stopChild(coordinator: Coordinating)
    func stopChildren()
    func activate()
    func deactivate()
}

protocol CoordinatingVisibleViewController {
    var visibleViewController: UIViewController { get }
}

extension UIViewController {
    private struct CoordinatingAssociatedKeys {
        static var ownerKey: UInt = 0
    }
    weak var coordinator: Coordinating? {
        get { objc_getAssociatedObject(self, &CoordinatingAssociatedKeys.ownerKey) as? Coordinating }
        set { objc_setAssociatedObject(self, &CoordinatingAssociatedKeys.ownerKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
}
