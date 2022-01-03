//
//  AppDelegate.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/8.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow()
        let appFlowController = AppFlowController()
        window.rootViewController = appFlowController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

