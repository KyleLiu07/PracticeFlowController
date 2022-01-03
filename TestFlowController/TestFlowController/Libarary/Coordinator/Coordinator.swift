//
//  Coordinator.swift
//  Play-iOS
//
//  Created by Green on 2019/2/15.
//

import UIKit

class Coordinator<T: UIViewController> : Coordinating, CoordinatorRouteController {
    private(set) var started = false
    private(set) var isActive = false
    let rootViewController: T
    weak final var parent: Coordinating?

    var childCoordinators: [Coordinating] = []
    var routeAvailable: Bool { true }
    var childCoordinatorRootViewController: UIViewController {
        rootViewController
    }

    required init(viewController: T) {
        rootViewController = viewController
    }

    func start() {
        // Do your action before call super.start()
        started = true
        isActive = true
    }

    func stop() {
        // Do your action before call super.stop()
        started = false
        isActive = false
        stopChildren()
    }

    final func startChild(coordinator : Coordinating) {
        guard !childCoordinators.contains(where: {$0 === coordinator}) else {
            return
        }
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    final func stopChild(coordinator: Coordinating) {
        coordinator.stop()
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }

    final func stopChildren() {
        childCoordinators.forEach {
            $0.stop()
        }
        childCoordinators.removeAll()
    }

    func activate() {
        isActive = true
        childCoordinators.forEach {
            $0.activate()
        }
    }

    func deactivate() {
        isActive = false
        childCoordinators.forEach {
            $0.deactivate()
        }
    }

    final func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.coordinator = self
        rootViewController.present(viewController, animated: animated, completion: completion)
    }

    func willApplyRouting(withCompletionHandler: () -> Void) {
        withCompletionHandler()
    }

    func apply<V: UIViewController>(_ routing: AnyCoordinatorRouting<V>) {
        guard let targetCoordinator = topCoordinator as? Coordinator,
              targetCoordinator.routeAvailable,
              let coordinator = routing.build(targetCoordinator.childCoordinatorRootViewController) else {
            return
        }

        willApplyRouting {
            targetCoordinator.startChild(coordinator: coordinator)
        }
    }
}

extension Coordinator {
    final func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        let target: Coordinating?
        if let navigationController = rootViewController.presentedViewController as? UINavigationController {
            target = navigationController.viewControllers.first?.coordinator
        } else {
            target = self
        }
        rootViewController.dismiss(animated: animated, completion: {
            if let target = target {
                target.parent?.stopChild(coordinator: target)
            }
            completion?()
        })
    }
}

extension Coordinator where T: UINavigationController {
    final func show(viewController: UIViewController,
                    animated: Bool = true,
                    configurator: ViewControllerConfigurator = CoordinatorConfigurator.navigationConfigurator) {
        viewController.coordinator = self
        configurator(viewController)
        guard !rootViewController.viewControllers.contains(viewController) else { return }
        rootViewController.pushViewController(viewController, animated: animated)
    }

    final func replaceViewController(from: UIViewController,
                                     to: UIViewController,
                                     configurator: ViewControllerConfigurator = CoordinatorConfigurator.navigationConfigurator) {
        guard from !== to,
              let index = rootViewController.viewControllers.firstIndex(where: { $0 === from })
        else { return }

        to.coordinator = self
        configurator(to)
        var viewControllers = rootViewController.viewControllers
        viewControllers[index] = to
        rootViewController.setViewControllers(viewControllers, animated: false)
    }

    final func pop(animated: Bool = true) {
        // If animated is false, there is no transitionCoordinator for the NavigationController
        // So we need this handler to stopChildren manually.
        if !animated {
            parent?.stopChild(coordinator: self)
        }
        rootViewController.popViewController(animated: animated)
    }

    final func popToRootCoordinator(animated: Bool = true) {
        if !animated, let firstCoordinator = rootViewController.viewControllers.first?.coordinator {
            firstCoordinator.stopChildren()
        }
        rootViewController.popToRootViewController(animated: animated)
    }

    typealias ClusterPushableCoordinating = Coordinating & CoordinatingVisibleViewController
    final func push<Element: ClusterPushableCoordinating>( coordinators: [Element]) where T: UINavigationController {
        let newViewControllers = coordinators.map { $0.visibleViewController }
        var currentViewControllers = rootViewController.viewControllers
        currentViewControllers += newViewControllers
        rootViewController.setViewControllers(currentViewControllers, animated: true)

        var previousCoordinator: Element?
        coordinators.forEach {
            $0.start()
            if let previousCoordinator = previousCoordinator {
                $0.parent = previousCoordinator
            } else {
                $0.parent = self
            }

            switch $0.parent {
            case let coordinator as Coordinator<UINavigationController>:
                coordinator.childCoordinators.append($0)
            case let coordinator as Coordinator<UIViewController>:
                coordinator.childCoordinators.append($0)
            default:
                break
            }

            previousCoordinator = $0
        }
    }

    final var coordinatorsAtNavigationController: [Coordinating] {
        rootViewController.viewControllers.compactMap { $0.coordinator }
    }

    final func pop(to coordinator: Coordinating) {
        guard let index = coordinatorsAtNavigationController.firstIndex(where: { coordinator === $0 }) else {
            return
        }
        let destinationVC = rootViewController.viewControllers[index]
        _ = rootViewController.popToViewController(destinationVC, animated: true)
    }

    final func replace(children coordinators: [ClusterPushableCoordinating], for coordinator: Coordinating) {
        guard let index = coordinatorsAtNavigationController.firstIndex(where: { coordinator === $0 }) else {
            return
        }
        coordinator.stopChildren()
        var previousCoordinator: ClusterPushableCoordinating?
        coordinators.forEach {
            if let previousCoordinator = previousCoordinator {
                $0.parent = previousCoordinator
            } else {
                $0.parent = coordinator
            }

            $0.visibleViewController.coordinator = $0

            switch $0.parent {
            case let parent as Coordinator<UINavigationController>:
                parent.childCoordinators.append($0)
            case let parent as Coordinator<UIViewController>:
                parent.childCoordinators.append($0)
            default:
                break
            }
            previousCoordinator = $0
        }

        var controllers = Array(rootViewController.viewControllers[...index])
        controllers += coordinators.map { $0.visibleViewController }
        rootViewController.setViewControllers(controllers, animated: true)
        coordinators.forEach { $0.start() }
    }
}

extension Coordinator {
    var topCoordinator: Coordinating {
        var topCoordinator: Coordinating = self
        while true {
            let activedChildren = topCoordinator.childCoordinators.filter { $0.isActive }
            if activedChildren.isEmpty { break }

            topCoordinator = activedChildren.first! // swiftlint:disable:this force_unwrapping

            if topCoordinator.childCoordinators.isEmpty { break }
        }
        return topCoordinator
    }

    var appearingCoordinator: Coordinating {
        var appearingCoordinator: Coordinating = self
        while true {
            let activedChildren = appearingCoordinator.childCoordinators.filter { $0.isActive }
            if activedChildren.isEmpty { break }

            appearingCoordinator = activedChildren.last! // swiftlint:disable:this force_unwrapping

            if appearingCoordinator.childCoordinators.isEmpty { break }
        }
        return appearingCoordinator
    }
}
