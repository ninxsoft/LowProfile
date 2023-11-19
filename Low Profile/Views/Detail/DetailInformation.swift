//
//  DetailInformation.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import SwiftUI

struct DetailInformation: View {
    var payload: Payload
    private let spacing: CGFloat = 10
    private var information: [(key: String, value: String)] {
        [
            (key: "Description", value: payload.payloadDescription),
            (key: "Display Name", value: payload.payloadDisplayName),
            (key: "Identifier", value: payload.payloadIdentifier),
            (key: "Organisation", value: payload.payloadOrganisation),
            (key: "UUID", value: payload.payloadUUID),
            (key: "Version", value: "\(payload.payloadVersion)"),
        ]
    }

    private var availability: [(key: String, value: String)] {
        [
            (key: "Device Channel", value: payload.availability.device),
            (key: "User Channel", value: payload.availability.user),
            (key: "Allow Manual Install", value: payload.availability.manual),
            (key: "Requires Supervision", value: payload.availability.supervision),
            (key: "Requires User Approved MDM", value: payload.availability.userApproved),
            (key: "Allowed in User Enrollment", value: payload.availability.userEnrol),
            (key: "Allow Multiple Payloads", value: payload.availability.multiple),
        ]
    }

    var body: some View {
        ScrollView(.vertical) {
            Grid(alignment: .centerFirstTextBaseline, horizontalSpacing: spacing, verticalSpacing: spacing) {
                if !payload.managed {
                    ForEach(information, id: \.key) { item in
                        InformationGridRow(key: item.key, value: item.value)
                    }
                }
                if !payload.general, !payload.custom {
                    if !payload.managed {
                        Divider()
                    }
                    ForEach(availability, id: \.key) { item in
                        InformationGridRow(key: item.key, value: item.value)
                    }
                }
            }
        }
        .padding()
    }
}

struct DetailInformation_Previews: PreviewProvider {
    static var previews: some View {
        DetailInformation(payload: .example)
    }
}
