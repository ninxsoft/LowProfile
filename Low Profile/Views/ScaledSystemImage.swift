//
//  ScaledSystemImage.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import SwiftUI

struct ScaledSystemImage: View {
    var systemName: String
    var length: CGFloat

    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: length, height: length)
    }
}

struct ScaledSystemImage_Previews: PreviewProvider {
    static var previews: some View {
        ScaledSystemImage(systemName: "applelogo", length: 32)
    }
}
