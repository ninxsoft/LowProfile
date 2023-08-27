//
//  ResultsKeyView.swift
//  Low Profile
//
//  Created by Nindi Gill on 26/6/2023.
//

import SwiftUI

struct ResultsKeyView: View {
    var title: String
    var bold: Bool
    var indentation: CGFloat = 0
    private let spacing: CGFloat = 5
    private let length: CGFloat = 16

    var body: some View {
        HStack(spacing: spacing) {
            ScaledSystemImage(systemName: "key.horizontal.fill", length: length)
                .foregroundColor(.accentColor)
                .scaleEffect(x: -1)
                .padding(.leading, indentation / 2 * length)
            if bold {
                Text(title)
                    .font(.system(.body, design: .monospaced))
                    .bold()
            } else {
                Text(title)
                    .font(.system(.body, design: .monospaced))
            }
            Spacer()
        }
    }
}

struct ResultsKeyView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsKeyView(title: Property.example.name, bold: false)
    }
}
