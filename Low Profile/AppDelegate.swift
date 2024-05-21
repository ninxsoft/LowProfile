//
//  AppDelegate.swift
//  Low Profile
//
//  Created by Nindi Gill on 10/8/20.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false

        for argument in ["-e", "--export"] {
            guard
                let exportIndex: Int = CommandLine.arguments.firstIndex(of: argument),
                CommandLine.arguments.count > exportIndex + 1 else {
                continue
            }

            let path: String = CommandLine.arguments[exportIndex + 1].replacingOccurrences(of: "~", with: NSHomeDirectory())
            let url: URL = .init(fileURLWithPath: path)

            Task {
                await export(to: url)
                exit(0)
            }
        }
    }

    private func export(to url: URL) async {
        let array: [[String: Any]] = ProfileHelper.shared.getProfiles().map(\.dictionary)

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: array, format: .xml, options: .bitWidth)
            let string: String = .init(decoding: data, as: UTF8.self)
            try string.write(to: url, atomically: true, encoding: .utf8)
            print("Exported Low Profile report: '\(url.path())'")
        } catch {
            print(error.localizedDescription)
        }
    }
}
