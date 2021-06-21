//
//  DetailOverview.swift
//  Low Profile
//
//  Created by Nindi Gill on 8/8/20.
//

import SwiftUI

struct DetailOverview: View {
    var payload: Payload
    private let spacing: CGFloat = 10

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: spacing) {
                Text(payload.description)
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .contextMenu {
                        CopyButton(string: payload.description)
                    }
                HStack {
                    Text(payload.type)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .contextMenu {
                            CopyButton(string: payload.type)
                        }
                    if payload.deprecated {
                        TextTag(title: "Deprecated")
                    }
                    if payload.beta {
                        TextTag(title: "Beta")
                    }
                }
                DetailOverviewPlatforms(platforms: payload.platforms)
            }
        }
        .padding()
    }
}

struct DetailOverview_Previews: PreviewProvider {
    static var previews: some View {
        DetailOverview(payload: .example)
    }
}
