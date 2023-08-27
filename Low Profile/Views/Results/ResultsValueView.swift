//
//  ResultsValueView.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/6/2023.
//

import SwiftUI

struct ResultsValueView: View {
    var title: String
    var indentation: CGFloat = 0
    private let spacing: CGFloat = 5
    private let length: CGFloat = 16

    var body: some View {
        HStack(spacing: spacing) {
            ScaledSystemImage(systemName: "list.clipboard.fill", length: length)
                .foregroundColor(.accentColor)
                .padding(.leading, indentation / 2 * length)
            Text(title)
                .font(.system(.body, design: .monospaced))
                .foregroundStyle(.pink)
            Spacer()
        }
    }
}

struct ResultsValueView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsValueView(title: Property.example.name)
    }
}
