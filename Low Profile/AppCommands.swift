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
            Button("Low Profile Help") {
                help()
            }
        }
        CommandGroup(replacing: .saveItem) {
            Button("Close") {
                close()
            }
            .keyboardShortcut("w")
        }
        CommandGroup(replacing: .systemServices) {
            // do nothing ?
        }
    }

    func help() {

        guard let url: URL = URL(string: .homepage) else {
            return
        }

        openURL(url)
    }

    func close() {
        NSApplication.shared.keyWindow?.close()
    }
}
