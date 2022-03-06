//
//  Detailnformation.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import SwiftUI

struct DetailInformation: View {
    var payload: Payload
    private let spacing: CGFloat = 10
    private let padding: CGFloat = 30

    var body: some View {
        ScrollView(.vertical) {
            if !payload.managed {
                VStack(spacing: spacing) {
                    TextRow(leading: "Description", trailing: payload.payloadDescription)
                    TextRow(leading: "Display Name", trailing: payload.payloadDisplayName)
                    TextRow(leading: "Identifier", trailing: payload.payloadIdentifier)
                    TextRow(leading: "Organisation", trailing: payload.payloadOrganisation)
                    TextRow(leading: "UUID", trailing: payload.payloadUUID)
                    TextRow(leading: "Version", trailing: "\(payload.payloadVersion)")
                }
            }
            if !payload.general && !payload.custom {
                VStack(spacing: spacing) {
                    TextRow(leading: "Device Channel", trailing: payload.availability.device)
                    TextRow(leading: "User Channel", trailing: payload.availability.user)
                    TextRow(leading: "Allow Manual Install", trailing: payload.availability.manual)
                    TextRow(leading: "Requires Supervision", trailing: payload.availability.supervision)
                    TextRow(leading: "Requires User Approved MDM", trailing: payload.availability.userApproved)
                    TextRow(leading: "Allowed in User Enrollment", trailing: payload.availability.userEnrol)
                    TextRow(leading: "Allow Multiple Payloads", trailing: payload.availability.multiple)
                }
                .padding(.top, padding)
            }
            Spacer()
        }
        .padding()
    }
}

struct DetailInformation_Previews: PreviewProvider {
    static var previews: some View {
        DetailInformation(payload: .example)
    }
}
