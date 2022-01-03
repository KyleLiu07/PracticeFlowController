//
//  Notifications+Handlings.swift
//  Play-iOS
//
//  Created by Green on 2020/12/3.
//

import Foundation

// MARK: - Re-Authorization
extension Notification {
    static func routeSigninNotification(cancelAction: LoginCancelAction = .backToHome) -> Notification {
        let userInfo: [String: Any] = ["cancelAction": cancelAction]
        return Notification(name: .routeToSignin, object: nil, userInfo: userInfo)
    }

    func getCancelAction() -> LoginCancelAction? {
        userInfo?["cancelAction"] as? LoginCancelAction
    }
}
