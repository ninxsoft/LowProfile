//
//  TextTag.swift
//  Low Profile
//
//  Created by Nindi Gill on 8/8/20.
//

import SwiftUI

struct TextTag: View {
    var title: String
    var color: Color {
        switch title {
        case "Deprecated":
            return .red
        case "Beta":
            return .orange
        default:
            return .primary
        }
    }
    private let padding: CGFloat = 3
    private let cornerRadius: CGFloat = 5
    private let lineWidth: CGFloat = 1

    var body: some View {
        Text(title)
            .foregroundColor(color)
            .padding(padding)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: lineWidth))
    }
}

struct TextTag_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextTag(title: "Deprecated")
            TextTag(title: "Beta")
            TextTag(title: "Example")
        }
    }
}
