//
//  AppCoordinator.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/8.
//

import UIKit

class AppCoordinator: Coordinator<UITabBarController> {
    private var rootTabBarCoordinator: RootTabBarCoordinator!

    override func start() {
        super.start()

        rootViewController.view.backgroundColor = .white
        rootTabBarCoordinator = RootTabBarCoordinator(viewController: rootViewController)
        finishSplash()
    }
}

private extension AppCoordinator {
    func startSplash() {
        
    }

    func finishSplash() {
        sleep(1)
        startChild(coordinator: rootTabBarCoordinator)
    }
}

extension AppCoordinator {
    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {

    }
}

