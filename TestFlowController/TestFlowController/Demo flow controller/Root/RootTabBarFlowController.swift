//
//  RootTabBarFlowController.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/10.
//

import UIKit
import Combine

class RootTabBarFlowController: LogViewController {
    private let tabController = RootTabBarController()
    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        constructChildFlowController()
        tabController.rootDelegate = self
        add(tabController)

        NotificationCenter.default.publisher(for: .routeToSignin, object: nil)
            .sink(receiveValue: { [weak self] _ in
                self?.presentLoginOption(with: true)
            })
            .store(in: &subscriptions)
    }

    func presentLoginOption(with animated: Bool = true) {
        let loginFlowController = LoginFlowController()
        loginFlowController.modalPresentationStyle = .fullScreen
        loginFlowController.delegate = self
        tabController.present(loginFlowController, animated: animated, completion: nil)
    }
}

private extension RootTabBarFlowController {
    func constructChildFlowController() {
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
            return navigationController
        }

        let toDoTabItem = getTabBarItem(type: .toDo)
        let toDoNavigationController = generatedNavigationController(withTabBar: toDoTabItem)
        let toDoFlowController = ToDoListFlowController()
        toDoNavigationController.viewControllers = [toDoFlowController]

        let completedTabItem = getTabBarItem(type: .completion)
        let completedNavigationController = generatedNavigationController(withTabBar: completedTabItem)
        let completedFlowController = CompleteToDoListFlowController()
        completedNavigationController.viewControllers = [completedFlowController]
        tabController.viewControllers = [toDoNavigationController, completedNavigationController]
        tabController.selectedViewController = toDoNavigationController
    }
}

extension RootTabBarFlowController: RootTabBarControllerDelegate {

    func tabBarController(_ controller: RootTabBarController, select tab: RootTabBarController.Tab) {

    }

    func tabBarController(_ controller: RootTabBarController, shouldSelected tab: RootTabBarController.Tab) -> Bool {
        true
    }
}

extension RootTabBarFlowController: LoginFlowControllerDelegate {
    func loginFlowControllerDidDismiss(_ flowController: LoginFlowController) {
        flowController.dismiss(animated: true, completion: nil)
    }
}

extension UINavigationController {
    static func getBlankBarController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.backgroundColor = .white
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
}
