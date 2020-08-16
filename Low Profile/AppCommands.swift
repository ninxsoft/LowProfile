//
//  AppCommands.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import SwiftUI

struct AppCommands: Commands {
  @Environment(\.openURL) var openURL: OpenURLAction

  @CommandsBuilder var body: some Commands {
    CommandGroup(replacing: .help) {
      Button("Low Profile Help", action: {
        help()
      })
    }
    CommandGroup(replacing: .saveItem) {
      Button("Close", action: {
        close()
      })
      .keyboardShortcut("w", modifiers: .command)
    }
    CommandGroup(replacing: .systemServices) {

    }
  }

  func help() {

    let string: String = "https://github.com/ninxsoft/LowProfile"

    guard let url: URL = URL(string: string) else {
      return
    }

    openURL(url)
  }

  func close() {
    NSApplication.shared.keyWindow?.close()
  }
}
