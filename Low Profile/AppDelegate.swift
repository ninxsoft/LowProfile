//
//  AppDelegate.swift
//  Low Profile
//
//  Created by Nindi Gill on 10/8/20.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSPasteboard.general.declareTypes([.string], owner: nil)
    }
}
