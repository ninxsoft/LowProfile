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
    var certificates: [X509Certificate]
    @Binding var selectedDetailTab: DetailTab
    @Binding var selectedProperty: Property?

    var body: some View {
        VStack {
            DetailHeading(payload: payload)
            DetailHighLevel(payload: payload)
            TabView(selection: $selectedDetailTab) {
                if !(payload.managed && payload.custom) {
                    DetailInformation(payload: payload).tabItem { Text(DetailTab.information.description) }.tag(DetailTab.information)
                }
                if !payload.custom && !payload.discussion.isEmpty {
                    DetailDiscussion(payload: payload).tabItem { Text(DetailTab.discussion.description) }.tag(DetailTab.discussion)
                }
                if payload.general && !certificates.isEmpty {
                    DetailCertificates(certificates: certificates)
                        .tabItem { Text(DetailTab.certificates.description) }.tag(DetailTab.certificates)
                }
                if !payload.payloadProperties.isEmpty || !payload.managedPayloads.flatMap(\.payloadProperties).isEmpty {
                    DetailPayloadProperties(type: .payload, properties: payload.payloadProperties, managedPayloads: payload.managedPayloads, selectedProperty: $selectedProperty)
                        .tabItem { Text(DetailTab.payloadProperties.description) }.tag(DetailTab.payloadProperties)
                }
                if !payload.availableProperties.isEmpty {
                    DetailPayloadProperties(type: .available, properties: payload.availableProperties, managedPayloads: [], selectedProperty: $selectedProperty)
                        .tabItem { Text(DetailTab.availableProperties.description) }.tag(DetailTab.availableProperties)
                }
                if !payload.unknownProperties.isEmpty || !payload.managedPayloads.flatMap(\.unknownProperties).isEmpty {
                    DetailPayloadProperties(type: .unknown, properties: payload.unknownProperties, managedPayloads: payload.managedPayloads, selectedProperty: $selectedProperty)
                        .tabItem { Text(DetailTab.unknownProperties.description) }.tag(DetailTab.unknownProperties)
                }
                if !payload.general, let propertyList: String = payload.propertyList {
                    DetailPropertyList(string: propertyList)
                        .tabItem { Text(DetailTab.propertyList.description) }.tag(DetailTab.propertyList)
                }
            }
        }
        .textSelection(.enabled)
        .padding()
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(payload: .example, certificates: [], selectedDetailTab: .constant(.information), selectedProperty: .constant(.example))
    }
}
