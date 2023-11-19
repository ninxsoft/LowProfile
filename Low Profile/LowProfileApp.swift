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
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate: AppDelegate
    @StateObject var sparkleUpdater: SparkleUpdater = .init()

    var body: some Scene {
        Group {
            WindowGroup {
                ContentView()
            }
            DocumentGroup(viewing: ProfileDocument.self) { file in
                ProfileDocumentView(profile: file.document.profile)
            }
            DocumentGroup(viewing: ReportDocument.self) { file in
                ReportDocumentView(profiles: file.document.profiles)
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
