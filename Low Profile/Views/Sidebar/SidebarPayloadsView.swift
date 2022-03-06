//
//  SidebarPayloadsView.swift
//  Low Profile
//
//  Created by Nindi Gill on 3/3/2022.
//

import SwiftUI

struct SidebarPayloadsView: View {
    var profile: Profile
    @State private var selectedPayload: Payload?

    var body: some View {
        List(profile.payloads, selection: $selectedPayload) { payload in
            NavigationLink(destination: Detail(payload: payload, certificates: profile.certificates), tag: payload, selection: $selectedPayload) {
                SidebarPayloadRow(payload: payload)
            }
        }
        .navigationTitle(profile.name)
        .onAppear {
            selectedPayload = profile.payloads.first
        }
    }
}

struct SidebarPayloadsView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarPayloadsView(profile: .example)
    }
}
