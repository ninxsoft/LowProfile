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

        var description: String {
            switch self {
            case .payload:
                return "The following properties are in the profile payload, and are supported:"
            case .available:
                return "The following properties are not in the profile payload, and are supported:"
            case .unknown:
                return "The following properties are in the profile payload, and are unknown:"
            }
        }
    }

    var type: PropertyType
    var properties: [Property]
    private let spacing: CGFloat = 0

    var body: some View {
        VStack(spacing: spacing) {
            Text(type.description)
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.bottom)
            ScrollView(.vertical) {
                ForEach(properties) { property in
                    HStack {
                        DetailPayloadPropertiesLeading(property: property)
                        DetailPayloadPropertiesTrailing(property: property, type: type)
                    }
                }
            }
        }
        .padding()
    }
}

struct DetailPayloadProperties_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(DetailPayloadProperties.PropertyType.allCases) { type in
                DetailPayloadProperties(type: type, properties: [.example])
            }
        }
    }
}
