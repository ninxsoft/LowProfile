//
//  DetailPayloadPropertiesLeading.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import SwiftUI

struct DetailPayloadPropertiesLeading: View {
    var property: Property
    private let spacing: CGFloat = 0
    private let padding: CGFloat = 5

    var body: some View {
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
            if property.deprecated {
                HStack {
                    Spacer()
                    TextTag(title: "Deprecated")
                        .padding(.top, padding)
                }
            }
            Spacer()
        }
    }
}

struct DetailPayloadPropertiesLeading_Previews: PreviewProvider {
    static var previews: some View {
        DetailPayloadPropertiesLeading(property: .example)
    }
}
