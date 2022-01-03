//
//  RouteType.swift
//  TestFlowController
//
//  Created by Kyle on 2021/11/11.
//

import Foundation

enum NavigationStyle {
    case push
    case present
}

enum Direction {
    case home(NavigationStyle)
    case profile(_ style: NavigationStyle, _ userId: String)
}
