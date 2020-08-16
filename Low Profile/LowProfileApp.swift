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

  var body: some Scene {
    DocumentGroup(viewing: Document.self) { file in
      ContentView(profile: file.document.profile)
    }
    .commands {
      AppCommands()
    }
  }
}
