//
//  DetailHeading.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import SwiftUI

struct DetailHeading: View {
    @Environment(\.openURL)
    var openURL: OpenURLAction
    var payload: Payload
    @State private var hovering: Bool = false
    private let length: CGFloat = 32
    private var systemName: String {
        hovering ? "link.circle.fill" : "link.circle"
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(payload.name)
                .font(.title)
            if payload.deprecated {
                TextTag(title: "Deprecated")
            }
            if payload.beta {
                TextTag(title: "Beta")
            }
            Spacer()
            if !payload.custom {
                Button(action: {
                    documentation()
                }, label: {
                    ScaledSystemImage(systemName: systemName, length: length)
                        .foregroundColor(.accentColor)
                })
                .buttonStyle(.plain)
                .onHover { hovering in
                    self.hovering = hovering
                }
                .help("View documentation")
            }
        }
    }

    private func documentation() {

        payload.paths.compactMap { URL(string: .documentationPrefix + $0) }.forEach { url in
            openURL(url)
        }
    }
}

struct DetailHeading_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeading(payload: .example)
    }
}
