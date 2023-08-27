//
//  SidebarPayloadRow.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import SwiftUI

struct SidebarPayloadRow: View {
    var payload: Payload
    private let length: CGFloat = 48
    private let spacing: CGFloat = 5
    private let padding: CGFloat = 5

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                ScaledImage(name: payload.name, length: length)
                    .padding(.trailing)
                VStack(alignment: .leading, spacing: spacing) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(payload.name)
                            .bold()
                            .lineLimit(nil)
                        if payload.deprecated {
                            TextTag(title: "Deprecated")
                        }
                        if payload.beta {
                            TextTag(title: "Beta")
                                .padding(.bottom, padding)
                        }
                    }
                    HStack {
                        ForEach(payload.platforms) { platform in
                            PlatformImage(title: platform.name)
                        }
                    }
                }
                Spacer()
            }
            .padding(.vertical, padding)
        }
    }
}

struct SidebarPayloadRow_Previews: PreviewProvider {
    static var previews: some View {
        SidebarPayloadRow(payload: .example)
    }
}
