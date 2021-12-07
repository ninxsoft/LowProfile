//
//  DetailHighLevel.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import SwiftUI

struct DetailHighLevel: View {
    var payload: Payload
    private let spacing: CGFloat = 10
    private let length: CGFloat = 80
    private let padding: CGFloat = 5

    var body: some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading, spacing: spacing) {
                    Text(payload.description)
                        .font(.title3)
                    Text(payload.type)
                        .font(.title3)
                    HStack(spacing: spacing + padding) {
                        ForEach(payload.platforms) { platform in
                            HStack {
                                PlatformImage(title: platform.name)
                                VStack(alignment: .leading) {
                                    Text(platform.name)
                                    Text(platform.supportedVersions)
                                }
                            }
                            .padding(.trailing, padding)
                        }
                    }
                }
                .foregroundColor(.secondary)
                Spacer()
                ScaledImage(name: payload.name, length: length)
            }
            .padding()
        }
    }
}

struct DetailHighLevel_Previews: PreviewProvider {
    static var previews: some View {
        DetailHighLevel(payload: .example)
    }
}
