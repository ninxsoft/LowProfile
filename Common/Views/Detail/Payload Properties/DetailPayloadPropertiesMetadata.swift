//
//  DetailPayloadPropertiesMetadata.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import SwiftUI

struct DetailPayloadPropertiesMetadata: View {
    var heading: String
    var trailing: String
    private let padding: CGFloat = 5

    var body: some View {
        HStack(spacing: 0) {
            Text(heading)
                .padding(.trailing, padding)
            Text(trailing)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.pink)
            Spacer()
        }
    }
}

struct DetailPayloadPropertiesMetadata_Previews: PreviewProvider {
    static var previews: some View {
        DetailPayloadPropertiesMetadata(heading: "Heading", trailing: "Trailing")
    }
}
