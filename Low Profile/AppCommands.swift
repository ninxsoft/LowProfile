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
        CommandGroup(replacing: .newItem) {
            Button("Open") {
                open()
            }
            .keyboardShortcut("o")
        }
        CommandGroup(replacing: .saveItem) {
            Button("Close") {
                close()
            }
            .keyboardShortcut("w")
        }
        CommandGroup(replacing: .systemServices) { }
        CommandGroup(replacing: .help) {
            Button("Low Profile Help") {
                help()
            }
        }
    }

    private func open() {
        NSDocumentController.shared.openDocument(nil)
    }

    private func close() {
        NSApplication.shared.keyWindow?.close()
    }

    private func help() {

        guard let url: URL = URL(string: .homepage) else {
            return
        }

        openURL(url)
    }
}
