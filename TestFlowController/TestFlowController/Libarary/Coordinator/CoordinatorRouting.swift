//
//  Coordinator+Route.swift
//  Play-iOS
//
//  Created by Green on 2021/7/19.
//

import UIKit
import Foundation

protocol CoordinatorRouteController {
    var childCoordinatorRootViewController: UIViewController { get }
    var routeAvailable: Bool { get }
    func willApplyRouting(withCompletionHandler: () -> Void)
}

protocol CoordinatorRouting {
    associatedtype ChildRootViewController: UIViewController
    func build(_ rootController: UIViewController) -> Coordinator<ChildRootViewController>?
}

extension CoordinatorRouting {
    func toAnyRouting<T>() -> AnyCoordinatorRouting<T> where T == ChildRootViewController {
        AnyCoordinatorRouting(self)
    }
}

struct AnyCoordinatorRouting<T: UIViewController>: CoordinatorRouting {
    private let _build: (UIViewController) -> Coordinator<T>?
    init<R: CoordinatorRouting>(_ routing: R) where R.ChildRootViewController == T {
        _build = { viewController in
            routing.build(viewController)
        }
    }

    init(build: @escaping (UIViewController) -> Coordinator<T>?) {
        _build = build
    }

    func build(_ rootController: UIViewController) -> Coordinator<T>? {
        _build(rootController)
    }

    typealias ChildRootViewController = T
}
