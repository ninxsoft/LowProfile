//
//  Detail.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/8/20.
//

import ASN1Decoder
import SwiftUI

struct Detail: View {
    var payload: Payload
    var certificate: X509Certificate?

    var body: some View {
        VStack {
            DetailHeading(payload: payload)
            DetailHighLevel(payload: payload)
            TabView {
                DetailInformation(payload: payload)
                    .tabItem { Text("Information") }
                if !payload.custom {
                    DetailDiscussion(discussion: payload.discussion)
                        .tabItem { Text("Discussion") }
                }
                if payload.general && certificate != nil {
                    DetailCertificate(certificate: certificate)
                        .tabItem { Text("Certificate") }
                }
                if !payload.payloadProperties.isEmpty {
                    DetailPayloadProperties(type: .payload, properties: payload.payloadProperties)
                        .tabItem { Text("Payload Properties") }
                }
                if !payload.availableProperties.isEmpty {
                    DetailPayloadProperties(type: .available, properties: payload.availableProperties)
                        .tabItem { Text("Available Properties") }
                }
                if !payload.unknownProperties.isEmpty {
                    DetailPayloadProperties(type: .unknown, properties: payload.unknownProperties)
                        .tabItem { Text("Unknown Properties") }
                }
                if !payload.general, let propertyList: String = payload.propertyList {
                    DetailPropertyList(string: propertyList)
                        .tabItem { Text("Property List") }
                }
            }
        }
        .textSelection(.enabled)
        .padding()
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(payload: .example, certificate: nil)
    }
}
