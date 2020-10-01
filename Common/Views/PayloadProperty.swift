//
//  PayloadProperty.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import SwiftUI

struct PayloadProperty: View {
    var property: Property
    var type: PayloadProperties.PropertyType
    private let spacing: CGFloat = 0
    private let padding: CGFloat = 5

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .trailing, spacing: spacing) {
                HStack {
                    Spacer()
                    Text(property.name)
                        .font(.system(.body, design: .monospaced))
                        .bold()
                        .foregroundColor(.primary)
                }
                HStack {
                    Spacer()
                    Text(property.type)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.pink)
                }
                if property.required {
                    HStack {
                        Spacer()
                        Text("Required")
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
            }
            VStack(alignment: .leading, spacing: spacing) {
                if [.payload, .unknown].contains(type) {
                    HStack {
                        Text(property.valueString)
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
                    HStack(spacing: spacing) {
                        Text("Default:")
                            .padding(.trailing, padding)
                        Text(property.defaultValue)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.pink)
                        Spacer()
                    }
                }
                if !property.possibleValues.isEmpty {
                    HStack(spacing: spacing) {
                        Text("Possible Values:")
                            .padding(.trailing, padding)
                        ForEach(0..<property.possibleValues.count, id: \.self) { index in
                            Text(property.possibleValues[index])
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.pink)
                            if index < property.possibleValues.count - 1 {
                                Text(", ")
                            }
                        }
                        Spacer()
                    }
                }
                if !property.minimum.isEmpty {
                    HStack(spacing: spacing) {
                        Text("Minimum:")
                            .padding(.trailing, padding)
                        Text(property.minimum)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.pink)
                        Spacer()
                    }
                }
                if !property.maximum.isEmpty {
                    HStack(spacing: spacing) {
                        Text("Maximum:")
                            .padding(.trailing, padding)
                        Text(property.maximum)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.pink)
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
}

struct PayloadProperty_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PayloadProperties.PropertyType.allCases) { type in
                PayloadProperty(property: .example, type: type)
            }
        }
    }
}
