//
//  RefreshView.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/3/2022.
//

import SwiftUI

struct RefreshView: View {
    private let spacing: CGFloat = 10
    private let length: CGFloat = 48

    var body: some View {
        HStack(spacing: spacing) {
            ScaledImage(name: "Profile", length: length)
            Text("Retrieving Profiles...")
            ProgressView()
                .controlSize(.small)
        }
        .padding()
    }
}

struct RefreshView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshView()
    }
}
