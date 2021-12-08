//
//  AppDelegate.swift
//  Low Profile
//
//  Created by Nindi Gill on 10/8/20.
//

import Cocoa
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate {

    // swiftlint:disable:next weak_delegate
    private let userNotificationCenterDelegate: UserNotificationCenterDelegate = UserNotificationCenterDelegate()

    func applicationDidFinishLaunching(_ notification: Notification) {
        UNUserNotificationCenter.current().delegate = userNotificationCenterDelegate

        let action: UNNotificationAction = UNNotificationAction(identifier: UNNotificationAction.Identifier.update, title: "Update", options: .foreground)
        let category: UNNotificationCategory = UNNotificationCategory(identifier: UNNotificationCategory.Identifier.update, actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])

        checkForUpdates()
    }

    private func checkForUpdates() {

        guard let url: URL = URL(string: .latestReleaseURL),
            let infoDictionary: [String: Any] = Bundle.main.infoDictionary,
            let version: String = infoDictionary["CFBundleShortVersionString"] as? String else {
            return
        }

        do {
            let string: String = try String(contentsOf: url, encoding: .utf8)

            guard let data: Data = string.data(using: .utf8),
                let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                let tag: String = dictionary["tag_name"] as? String else {
                return
            }

            let latestVersion: String = tag.replacingOccurrences(of: "v", with: "")

            guard version.compare(latestVersion, options: .numeric) == .orderedAscending else {
                return
            }

            if !UserDefaults.standard.bool(forKey: "RequestedAuthorizationForNotifications") {
                let notificationCenter: UNUserNotificationCenter = .current()
                notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in

                    if let error: Error = error {
                        print(error.localizedDescription)
                        return
                    }

                    UserDefaults.standard.set(true, forKey: "RequestedAuthorizationForNotifications")
                    self.sendUpdateNotification(for: latestVersion)
                }
            } else {
                sendUpdateNotification(for: latestVersion)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func sendUpdateNotification(for version: String) {

        let notificationCenter: UNUserNotificationCenter = .current()
        notificationCenter.getNotificationSettings { settings in

            guard [.authorized, .provisional].contains(settings.authorizationStatus) else {
                return
            }

            let identifier: String = UUID().uuidString

            let content: UNMutableNotificationContent = UNMutableNotificationContent()
            content.title = "Update Available"
            content.body = "Version \(version) is available to download."
            content.sound = .default
            content.categoryIdentifier = UNNotificationCategory.Identifier.update

            let trigger: UNTimeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request: UNNotificationRequest = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

            notificationCenter.add(request) { error in

                if let error: Error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
