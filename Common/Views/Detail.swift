//
//  Detail.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import ASN1Decoder
import SwiftUI

struct Detail: View {
    @Environment(\.openURL) var openURL: OpenURLAction
    @State private var background: Bool = false
    var payload: Payload
    var certificate: X509Certificate?
    private let spacing: CGFloat = 10
    private let padding: CGFloat = 10
    private let buttonLength: CGFloat = 24
    private let imageLength: CGFloat = 64
    private let cornerRadius: CGFloat = 5
    private let height: CGFloat = 235

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: spacing) {
                    HStack(alignment: .lastTextBaseline) {
                        Text(payload.name).font(.title)
                            .contextMenu {
                                CopyButton(string: payload.name)
                            }
                        Text("-")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        Text(payload.type)
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .contextMenu {
                                CopyButton(string: payload.type)
                            }
                    }
                    Text(payload.description)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .contextMenu {
                            CopyButton(string: payload.description)
                        }
                    HStack {
                        DetailPlatforms(platforms: payload.platforms)
                        if payload.deprecated {
                            TextTag(title: "Deprecated")
                        }
                        if payload.beta {
                            TextTag(title: "Beta")
                        }
                    }
                }
                Spacer()
                HStack {
                    if !payload.custom {
                        Button(action: {
                            documentation()
                        }, label: {
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFit()
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
            TabView {
                DetailInformation(payload: payload, spacing: spacing)
                    .tabItem {
                        Text("Information")
                    }
                if !payload.general && !payload.custom {
                    DetailAvailability(availability: payload.availability, spacing: spacing)
                        .tabItem {
                            Text("Availability")
                        }
                }
                if !payload.custom {
                    DetailDiscussion(discussion: payload.completeDiscussion)
                        .tabItem {
                            Text("Discussion")
                        }
                }
                if payload.general && certificate != nil {
                    DetailCertificate(certificate: certificate)
                        .tabItem {
                            Text("Certificate")
                        }
                }
            }
            .frame(height: height)
            .padding(.vertical)
            TabView {
                if !payload.payloadProperties.isEmpty {
                    PayloadProperties(type: .payload, properties: payload.payloadProperties, spacing: spacing)
                        .tabItem {
                            Text("Payload Properties")
                        }
                }
                if !payload.availableProperties.isEmpty {
                    PayloadProperties(type: .available, properties: payload.availableProperties, spacing: spacing)
                        .tabItem {
                            Text("Available Properties")
                        }
                }
                if !payload.unknownProperties.isEmpty {
                    PayloadProperties(type: .unknown, properties: payload.unknownProperties, spacing: spacing)
                        .tabItem {
                            Text("Unknown Properties")
                        }
                }
                if !payload.general {
                    DetailPropertyList(string: payload.propertyListString)
                        .tabItem {
                            Text("Property List")
                        }
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(payload: .example, certificate: nil)
    }
}
