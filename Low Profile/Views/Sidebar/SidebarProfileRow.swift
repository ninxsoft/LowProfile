//
//  SidebarProfileRow.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/3/2022.
//

import SwiftUI

struct SidebarProfileRow: View {
    var profile: Profile
    private let length: CGFloat = 48
    private let padding: CGFloat = 5
    private var payloadsString: String {
        "\(profile.payloads.count - 1) payload\(profile.payloads.count - 1 == 1 ? "" : "s")"
    }

    var body: some View {
        HStack {
            ScaledImage(name: "Profile", length: length)
            VStack(alignment: .leading) {
                Text(profile.name)
                    .bold()
                    .lineLimit(nil)
                Text(payloadsString)
            }
        }
        .padding(.vertical, padding)
    }
}

struct SidebarProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        SidebarProfileRow(profile: .example)
    }
}
