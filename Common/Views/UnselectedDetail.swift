//
//  Detail.swift
//  Low Profile
//
//  Created by Nindi Gill on 5/8/20.
//

import SwiftUI

struct UnselectedDetail: View {
    var profile: Profile
    var title: String {
        "Select a payload"
    }

    var body: some View {
        Text(title)
            .font(.title)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct UnselectedDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnselectedDetail(profile: .example)
    }
}
