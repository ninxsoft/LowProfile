//
//  AppCommands.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import SwiftUI

struct AppCommands: Commands {
    @Environment(\.openURL)
    var openURL: OpenURLAction
    @ObservedObject var sparkleUpdater: SparkleUpdater

    @CommandsBuilder var body: some Commands {
        CommandGroup(after: .appInfo) {
            Button("Check for Updates...") {
                sparkleUpdater.checkForUpdates()
            }
            .disabled(!sparkleUpdater.canCheckForUpdates)
        }
        CommandGroup(replacing: .newItem) {
            Button("Open") {
                open()
            }
            .keyboardShortcut("o")
        }
        CommandGroup(after: .newItem) {
            Divider()
            Button("Export Report...") {
                export()
            }
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

    private func export() {

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date: String = dateFormatter.string(from: Date())

        let savePanel: NSSavePanel = NSSavePanel()
        savePanel.title = "Export Low Profile Report"
        savePanel.prompt = "Export"
        savePanel.nameFieldStringValue = "Low Profile Report \(date)"
        savePanel.canCreateDirectories = true
        savePanel.canSelectHiddenExtension = true
        savePanel.isExtensionHidden = false
        savePanel.allowedContentTypes = [.lowprofilereport]

        let response: NSApplication.ModalResponse = savePanel.runModal()

        guard response == .OK,
            let url: URL = savePanel.url else {
            return
        }

        let array: [[String: Any]] = ProfileHelper.shared.getProfiles().map { $0.dictionary }

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: array, format: .xml, options: .bitWidth)

            guard let string: String = String(data: data, encoding: .utf8) else {
                return
            }

            try string.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func close() {
        NSApplication.shared.keyWindow?.close()
    }

    private func help() {

        guard let url: URL = URL(string: .repositoryURL) else {
            return
        }

        openURL(url)
    }
}
