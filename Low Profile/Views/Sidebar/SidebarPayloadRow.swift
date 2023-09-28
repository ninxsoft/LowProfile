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
    private let cornerRadius: CGFloat = 5

    var body: some View {
        HStack(spacing: 0) {
            ScaledImage(name: payload.name, length: length)
                .padding(.trailing)
            VStack(alignment: .leading, spacing: spacing) {
                HStack(alignment: .firstTextBaseline) {
                    Text(payload.name)
                        .bold()
                        .lineLimit(nil)
                        .foregroundColor(payload.deprecated ? .red : payload.beta ? .orange : .primary)
                }
                HStack {
                    ForEach(payload.platforms) { platform in
                        PlatformImage(title: platform.name)
                    }
                }
            }
            Spacer()
        }
        .padding(padding)
        .cornerRadius(cornerRadius)
    }
}

struct SidebarPayloadRow_Previews: PreviewProvider {
    static var previews: some View {
        SidebarPayloadRow(payload: .example)
    }
}
