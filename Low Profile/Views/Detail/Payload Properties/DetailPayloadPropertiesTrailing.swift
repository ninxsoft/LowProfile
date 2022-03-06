//
//  DetailPayloadPropertiesTrailing.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import ASN1Decoder
import SwiftUI

struct DetailPayloadPropertiesTrailing: View {
    var property: Property
    var type: DetailPayloadProperties.PropertyType
    private let spacing: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            if [.payload, .unknown].contains(type) {
                HStack {
                    CustomValue(value: property.value)
                    Spacer()
                }
            }
            if [.payload, .available].contains(type) {
                HStack {
                    AttributedText(string: property.descriptionString)
                    Spacer()
                }
            }
            if !property.defaultValue.isEmpty {
                DetailPayloadPropertiesMetadata(heading: "Default:", trailing: property.defaultValue)
            }
            if !property.possibleValues.isEmpty {
                DetailPayloadPropertiesMetadata(heading: "Possible Values:", trailing: property.possibleValues.joined(separator: ", "))
            }
            if !property.minimum.isEmpty {
                DetailPayloadPropertiesMetadata(heading: "Minimum:", trailing: property.minimum)
            }
            if !property.maximum.isEmpty {
                DetailPayloadPropertiesMetadata(heading: "Maximum:", trailing: property.maximum)
            }
            Spacer()
        }
    }
}

struct DetailPayloadPropertiesTrailing_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(DetailPayloadProperties.PropertyType.allCases) { type in
                DetailPayloadPropertiesTrailing(property: .example, type: type)
            }
        }
    }
}
