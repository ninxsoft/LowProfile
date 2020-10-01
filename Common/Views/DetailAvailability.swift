//
//  DetailAvailability.swift
//  Low Profile
//
//  Created by Nindi Gill on 8/8/20.
//

import SwiftUI

struct DetailAvailability: View {
    var availability: Availability
    var spacing: CGFloat

    var body: some View {
        VStack(spacing: spacing) {
            TextRow(leading: "Device Channel", trailing: availability.device)
            TextRow(leading: "User Channel", trailing: availability.user)
            TextRow(leading: "Allow Manual Install", trailing: availability.manual)
            TextRow(leading: "Requires Supervision", trailing: availability.supervision)
            TextRow(leading: "Requires User Approved MDM", trailing: availability.userApproved)
            TextRow(leading: "Allowed in User Enrollment", trailing: availability.userEnrol)
            TextRow(leading: "Allow Multiple Payloads", trailing: availability.multiple)
        }
        .padding()
    }
}

struct DetailAvailability_Previews: PreviewProvider {
    static var previews: some View {
        DetailAvailability(availability: .example, spacing: 10)
    }
}
