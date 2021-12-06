//
//  ContentView.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/8/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL: OpenURLAction
    var profile: Profile
    private let sidebarWidth: CGFloat = 250
    private let width: CGFloat = 1_080
    private let height: CGFloat = 720

    var body: some View {
        NavigationView {
            List(profile.payloads) { payload in
                NavigationLink(destination: Detail(payload: payload, certificate: profile.certificate)) {
                    SidebarRow(payload: payload)
                }
            }
            .frame(width: sidebarWidth)
            Text("Select a Payload to view its contents 🙂")
                .font(.title)
                .foregroundColor(.secondary)
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    homepage()
                }, label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.accentColor)
                })
            }
        }
        .frame(minWidth: width, minHeight: height)
    }

    private func homepage() {

        guard let url: URL = URL(string: .homepage) else {
            return
        }

        openURL(url)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(profile: .example)
    }
}
