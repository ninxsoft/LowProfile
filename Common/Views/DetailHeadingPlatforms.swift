//
//  DetailHeadingPlatforms.swift
//  Low Profile
//
//  Created by Nindi Gill on 8/8/20.
//

import SwiftUI

struct DetailHeadingPlatforms: View {
    var platforms: [Platform]

    var body: some View {
        HStack {
            ForEach(platforms) { platform in
                HStack {
                    PlatformTag(title: platform.name)
                    Text(platform.description)
                        .foregroundColor(.secondary)
                }
                .padding(.trailing)
            }
        }
    }
}

struct DetailHeadingPlatforms_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeadingPlatforms(platforms: [.example])
    }
}
