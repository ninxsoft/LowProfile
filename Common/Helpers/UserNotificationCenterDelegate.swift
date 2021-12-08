//
//  UserNotificationCenterDelegate.swift
//  Low Profile
//
//  Created by Nindi Gill on 4/12/21.
//

import Cocoa
import UserNotifications

class UserNotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {

        switch response.actionIdentifier {
        case UNNotificationAction.Identifier.update:

            guard let url: URL = URL(string: .releasesURL) else {
                return
            }

            NSWorkspace.shared.open(url)
        default:
            break
        }
    }
}
