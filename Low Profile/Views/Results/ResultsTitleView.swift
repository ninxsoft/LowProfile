//
//  ResultsTitleView.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/6/2023.
//

import SwiftUI

struct ResultsTitleView: View {
    var title: String
    var image: String
    var indentation: CGFloat = 0
    private let spacing: CGFloat = 5
    private let length: CGFloat = 16

    var body: some View {
        HStack(spacing: spacing) {
            ScaledImage(name: image, length: length)
                .padding(.leading, indentation / 2 * length)
            Text(title)
                .bold()
            Spacer()
        }
    }
}

struct ResultsTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsTitleView(title: Payload.example.name, image: Payload.example.name)
    }
}
