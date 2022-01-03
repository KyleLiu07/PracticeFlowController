//
//  RootTabBarCoordinator.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/10.
//

import UIKit

class RootTabBarCoordinator: Coordinator<UITabBarController> {
    private let navigationDelegateProxy = NavigationDelegateProxy()
    private(set) var selectedCoordinator: Coordinator<UINavigationController>?

    override func start() {
        guard !started else { return }
        (rootViewController as? RootTabBarController)?.rootDelegate = self
        constructChildCoordinators()
        selectedCoordinator?.start()
        super.start()
    }
}

private extension RootTabBarCoordinator {
    func constructChildCoordinators() {
        let barItemFont: UIFont = .systemFont(ofSize: 12)
        let normalAttributes: [NSAttributedString.Key: Any] = [.font: barItemFont, .foregroundColor: UIColor.gray]
        let selectedAttributes: [NSAttributedString.Key: Any] = [.font: barItemFont, .foregroundColor: UIColor.purple, .strokeColor: UIColor.green]

        func getTabBarItem(type: RootTabBarController.Tab) -> UITabBarItem {
            let item = UITabBarItem(title: type.title, image: nil, selectedImage: nil)
            item.setTitleTextAttributes(normalAttributes, for: .normal)
            item.setTitleTextAttributes(selectedAttributes, for: .selected)
            return item
        }

        func generatedNavigationController(withTabBar item: UITabBarItem) -> UINavigationController {
            let navigationController = UINavigationController.getBlankBarController()
            navigationController.tabBarItem = item
            navigationController.interactivePopGestureRecognizer?.delegate = navigationDelegateProxy
            navigationController.delegate = navigationDelegateProxy
            return navigationController
        }

        let firstTabItem = getTabBarItem(type: .first)
        let firstNavigationController = generatedNavigationController(withTabBar: firstTabItem)
        let firstTabCoordinator = FirstTabCoordinator(viewController: firstNavigationController)

        let secondTabItem = getTabBarItem(type: .second)
        let secondNavigationController = generatedNavigationController(withTabBar: secondTabItem)
        let secondTabCoordinator = SecondTabCoordinator(viewController: secondNavigationController)

        rootViewController.viewControllers = [firstNavigationController,
                                              secondNavigationController]
        childCoordinators = [firstTabCoordinator,
                             secondTabCoordinator]
        childCoordinators.forEach { $0.parent = self }
        selectedCoordinator = firstTabCoordinator
    }

    func handleAuthorization(with notification: Notification) {

    }

    func popToRootAndRedirectToHome() {
        
    }

    func setSelectedCoordinator(with tab: RootTabBarController.Tab, needUpdateSelectedViewController: Bool = false) {
        let selectedIndex = tab.rawValue
        let newSelectedCoordinator = childCoordinators[selectedIndex]

        selectedCoordinator?.deactivate()
        newSelectedCoordinator.start()
        newSelectedCoordinator.activate()
        selectedCoordinator = newSelectedCoordinator as? Coordinator<UINavigationController>

        guard needUpdateSelectedViewController else { return }
        rootViewController.selectedIndex = selectedIndex
    }
}

extension RootTabBarCoordinator: RootTabBarControllerDelegate {
    func tabBarController(_ controller: RootTabBarController, shouldSelected tab: RootTabBarController.Tab) -> Bool {
        return true // user already login
        return false // user does not login
    }

    func tabBarController(_ controller: RootTabBarController, select tab: RootTabBarController.Tab) {
        setSelectedCoordinator(with: tab)
    }
}

extension UINavigationController {
    static func getBlankBarController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
}
