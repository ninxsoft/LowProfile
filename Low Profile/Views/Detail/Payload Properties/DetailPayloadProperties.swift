//
//  DetailPayloadProperties.swift
//  Low Profile
//
//  Created by Nindi Gill on 9/8/20.
//

import SwiftUI

struct DetailPayloadProperties: View {

    enum PropertyType: String, Identifiable, CaseIterable {
        case payload = "Payload"
        case available = "Available"
        case unknown = "Unknown"

        var id: String {
            self.rawValue
        }

        var propertiesDescription: String {
            switch self {
            case .payload:
                return "The following properties are in the profile payload, and are supported:"
            case .available:
                return "The following properties are not in the profile payload, and are supported:"
            case .unknown:
                return "The following properties are in the profile payload, and are unknown:"
            }
        }
        var managedPayloadsDescription: String {
            switch self {
            case .payload:
                return "The following managed preferences are in the profile payload, and are supported:"
            case .available:
                return "The following managed preferences are not in the profile payload, and are supported:"
            case .unknown:
                return "The following managed preferences are in the profile payload, and are unknown:"
            }
        }
    }

    var type: PropertyType
    var properties: [Property]
    var managedPayloads: [Payload]
    private let spacing: CGFloat = 0

    var body: some View {
        VStack(spacing: spacing) {
            if !properties.isEmpty {
                text(for: type.propertiesDescription)
                ScrollView(.vertical) {
                    ForEach(properties) { property in
                        HStack {
                            DetailPayloadPropertiesLeading(property: property)
                            DetailPayloadPropertiesTrailing(property: property, type: type)
                        }
                    }
                }
            }
            if type == .payload && !managedPayloads.flatMap({ $0.payloadProperties }).isEmpty || type == .unknown && !managedPayloads.flatMap({ $0.unknownProperties }).isEmpty {
                text(for: type.managedPayloadsDescription)
                ScrollView(.vertical) {
                    ForEach(managedPayloads) { payload in
                        Detail(payload: payload, certificates: [])
                    }
                }
            }
        }
        .padding()
    }

    func text(for string: String) -> some View {
        Text(string)
            .font(.title3)
            .foregroundColor(.secondary)
            .padding(.bottom)
    }

    func managedProperties(for payload: Payload) -> [Property] {

        switch type {
        case .payload:
            return payload.payloadProperties
        case .available:
            return payload.availableProperties
        case .unknown:
            return payload.unknownProperties
        }
    }
}

struct DetailPayloadProperties_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(DetailPayloadProperties.PropertyType.allCases) { type in
                DetailPayloadProperties(type: type, properties: [.example], managedPayloads: [.example])
            }
        }
    }
}
