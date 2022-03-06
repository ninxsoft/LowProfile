//
//  TextRow.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/8/20.
//

import SwiftUI

struct TextRow: View {
    var leading: String
    var trailing: String
    private var formattedTrailing: String {
        trailing.isEmpty ? "-" : trailing
    }

    var body: some View {
        HStack(alignment: .top) {
            Text(leading)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
            Spacer()
            Text(formattedTrailing)
                .foregroundColor(.secondary)
        }
    }
}

struct TextRow_Previews: PreviewProvider {
    static var previews: some View {
        TextRow(leading: "Leading", trailing: "Trailing")
    }
}
