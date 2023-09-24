//
//  InformationGridRow.swift
//  Low Profile
//
//  Created by Nindi Gill on 24/9/23.
//

import SwiftUI

struct InformationGridRow: View {
    var key: String
    var value: String
    private var formattedValue: String {
        value.isEmpty ? "-" : value
    }

    var body: some View {
        GridRow {
            Spacer()
            Text(key)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
                .gridColumnAlignment(.trailing)
            Text(formattedValue)
                .foregroundColor(.secondary)
                .gridColumnAlignment(.leading)
            Spacer()
        }
    }
}

struct InformationGridRow_Previews: PreviewProvider {
    static var previews: some View {
        InformationGridRow(key: "Key", value: "Value")
    }
}
