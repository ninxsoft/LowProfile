//
//  ScaledImage.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import SwiftUI

struct ScaledImage: View {
    var name: String
    var length: CGFloat

    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: length, height: length)
    }
}

struct ScaledImage_Previews: PreviewProvider {
    static var previews: some View {
        ScaledImage(name: "Certificate", length: 32)
    }
}
