//
//  LowProfileApp.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/8/20.
//

import SwiftUI

@main
struct LowProfileApp: App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate
    @StateObject var sparkleUpdater: SparkleUpdater = SparkleUpdater()

    var body: some Scene {
        Group {
            WindowGroup {
                ContentView()
            }
            DocumentGroup(viewing: Document.self) { file in
                DocumentView(profile: file.document.profile)
            }
        }
        .commands {
            AppCommands(sparkleUpdater: sparkleUpdater)
        }
        Settings {
            SettingsView(sparkleUpdater: sparkleUpdater)
        }
    }
}
