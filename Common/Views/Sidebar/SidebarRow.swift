//
//  SidebarRow.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import SwiftUI

struct SidebarRow: View {
    var payload: Payload
    private let length: CGFloat = 48
    private let spacing: CGFloat = 5
    private let padding: CGFloat = 5

    var body: some View {
        HStack(spacing: 0) {
            ScaledImage(name: payload.name, length: length)
                .padding(.trailing)
            VStack(alignment: .leading, spacing: spacing) {
                Text(payload.name)
                    .bold()
                    .lineLimit(nil)
                HStack {
                    ForEach(payload.platforms) { platform in
                        PlatformTag(title: platform.name)
                    }
                    if payload.deprecated {
                        TextTag(title: "Deprecated")
                    }
                    if payload.beta {
                        TextTag(title: "Beta")
                    }
                }
            }
        }
        .padding(.vertical, padding)
    }
}

struct SidebarRow_Previews: PreviewProvider {
    static var previews: some View {
        SidebarRow(payload: .example)
    }
}
