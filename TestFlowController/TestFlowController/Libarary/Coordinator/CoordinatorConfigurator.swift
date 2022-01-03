//
//  CoordinatorConfigurator.swift
//  Play-iOS
//
//  Created by Green on 2020/11/19.
//

import UIKit

typealias ViewControllerConfigurator = (UIViewController) -> Void

enum CoordinatorConfigurator {
    static let navigationConfigurator: ViewControllerConfigurator = Configurator.navigationConfigure
}

private enum Configurator {
    /// This is default configurator, if you have other require and need to setup the viewController during the navigation action.
    /// Please composition the configurator by yourself, then pass it with `show(_:animation:configurator:)`
    ///
    /// I will add operator for the composition later, let's start with `Functional Programming` :)
    static func navigationConfigure(_ viewController: UIViewController) {
        viewController.extendedLayoutIncludesOpaqueBars = true
        viewController.navigationItem.backButtonTitle = ""
    }
}
