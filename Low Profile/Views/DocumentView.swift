//
//  DocumentView.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/8/20.
//

import SwiftUI

struct DocumentView: View {
    @Environment(\.openURL)
    var openURL: OpenURLAction
    var profile: Profile
    @State private var selectedPayload: Payload?
    private let sidebarWidth: CGFloat = 250
    private let width: CGFloat = 1_080
    private let height: CGFloat = 720

    var body: some View {
        NavigationSplitView {
            List(profile.payloads, id: \.id, selection: $selectedPayload) { payload in
                NavigationLink(value: payload) {
                    SidebarPayloadRow(payload: payload)
                }
            }
            .frame(minWidth: sidebarWidth)
        } detail: {
            if let payload: Payload = selectedPayload {
                Detail(payload: payload, certificates: profile.certificates)
            } else {
                Text("Select a Payload to view its contents 🙂")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    homepage()
                }, label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.accentColor)
                })
                    .help("Visit Website")
            }
        }
        .frame(minWidth: width, minHeight: height)
        .onAppear {
            selectedPayload = profile.payloads.first
        }
    }

    private func homepage() {

        guard let url: URL = URL(string: .repositoryURL) else {
            return
        }

        openURL(url)
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(profile: .example)
    }
}
