//
//  DetailHeading.swift
//  Low Profile
//
//  Created by Nindi Gill on 8/8/20.
//

import SwiftUI

struct DetailHeading: View {
    @Environment(\.openURL) var openURL: OpenURLAction
    var payload: Payload
    @State private var visible: Bool = false
    @State private var background: Bool = false
    private let padding: CGFloat = 5
    private let spacing: CGFloat = 10
    private let buttonLength: CGFloat = 24
    private let imageLength: CGFloat = 72
    private let cornerRadius: CGFloat = 5

    var body: some View {
        GroupBox(label:
            HStack {
                Text(payload.name).font(.title)
                    .contextMenu {
                        CopyButton(string: payload.name)
                    }
                Spacer()
            }
            .padding(.bottom, padding)
        ) {
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
                    DetailHeadingPlatforms(platforms: payload.platforms)
                }
                Spacer()
                HStack {
                    if visible && !payload.custom {
                        Button(action: {
                            documentation()
                        }, label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.secondary)
                                .frame(width: buttonLength, height: buttonLength)
                                .background(
                                    Rectangle()
                                        .padding()
                                        .background(background ? Color(.gridColor) : Color.clear)
                                        .cornerRadius(cornerRadius)
                                )
                        })
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, padding)
                        .onHover { hovering in
                            background = hovering
                        }
                    }
                    Image(nsImage: payload.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageLength, height: imageLength)
                }
            }
            .padding()
            .onHover { hovering in
                withAnimation {
                    visible = hovering
                }
            }
        }
    }

    private func documentation() {

        let prefix: String = "https://developer.apple.com/documentation/devicemanagement/"

        for path in payload.paths {
            let string: String = prefix + path

            guard let url: URL = URL(string: string) else {
                continue
            }

            openURL(url)
        }
    }
}

struct DetailHeading_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeading(payload: .example)
    }
}
