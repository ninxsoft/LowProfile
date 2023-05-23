//
//  SettingsView.swift
//  Low Profile
//
//  Created by Nindi Gill on 25/12/2022.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var sparkleUpdater: SparkleUpdater
    private let width: CGFloat = 540

    var body: some View {
        TabView {
            SettingsGeneralView(sparkleUpdater: sparkleUpdater)
            .tabItem { Label("General", systemImage: "gear") }
            SettingsSyntaxHighlightingView()
            .tabItem { Label("Syntax Highlighting", systemImage: "highlighter") }
            SettingsAboutView()
            .tabItem { Label("About", systemImage: "info.circle") }
        }
        .textSelection(.enabled)
        .frame(width: width)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(sparkleUpdater: SparkleUpdater())
    }
}
