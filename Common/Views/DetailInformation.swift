//
//  Detailnformation.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import SwiftUI

struct DetailInformation_Previews: PreviewProvider {
  static var previews: some View {
    DetailInformation(payload: .example, spacing: 10)
  }
}

struct DetailInformation: View {
  var payload: Payload
  var spacing: CGFloat

  var body: some View {
    VStack(spacing: spacing) {
      TextRow(leading: "Version", trailing: "\(payload.payloadVersion)")
      TextRow(leading: "Identifier", trailing: payload.payloadIdentifier)
      TextRow(leading: "UUID", trailing: payload.payloadUUID)
      TextRow(leading: "Display Name", trailing: payload.payloadDisplayName)
      TextRow(leading: "Description", trailing: payload.payloadDescription)
      TextRow(leading: "Organisation", trailing: payload.payloadOrganisation)
    }
    .padding()
  }
}
