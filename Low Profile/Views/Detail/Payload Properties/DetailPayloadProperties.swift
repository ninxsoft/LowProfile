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
    @Binding var selectedProperty: Property?
    @State private var selectedDetailTab: DetailTab = .information
    private let spacing: CGFloat = 0

    var body: some View {
        VStack(spacing: spacing) {
            if !properties.isEmpty {
                text(for: type.propertiesDescription)
                ScrollViewReader { proxy in
                    ScrollView(.vertical) {
                        ForEach(properties) { property in
                            HStack {
                                DetailPayloadPropertiesLeading(property: property)
                                DetailPayloadPropertiesTrailing(property: property, type: type)
                            }
                            .tag(property)
                        }
                    }
                    .onChange(of: selectedProperty) { property in

                        guard let property: Property = property, properties.contains(property) else {
                            return
                        }

                        withAnimation(.easeOut(duration: 1)) {
                            proxy.scrollTo(property, anchor: .center)
                        }
                    }
                }
            }
            if type == .payload && !managedPayloads.flatMap(\.payloadProperties).isEmpty || type == .unknown && !managedPayloads.flatMap(\.unknownProperties).isEmpty {
                text(for: type.managedPayloadsDescription)
                ScrollView(.vertical) {
                    ForEach(managedPayloads) { payload in
                        Detail(payload: payload, certificates: [], selectedDetailTab: $selectedDetailTab, selectedProperty: .constant(nil))
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
}

struct DetailPayloadProperties_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(DetailPayloadProperties.PropertyType.allCases) { type in
                DetailPayloadProperties(type: type, properties: [.example], managedPayloads: [.example], selectedProperty: .constant(.example))
            }
        }
    }
}
