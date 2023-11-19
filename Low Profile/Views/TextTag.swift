//
//  TextTag.swift
//  Low Profile
//
//  Created by Nindi Gill on 8/8/20.
//

import SwiftUI

struct TextTag: View {
    var title: String
    private let padding: CGFloat = 5
    private let cornerRadius: CGFloat = 5
    private var color: Color {
        switch title {
        case "Deprecated":
            .red
        case "Beta":
            .orange
        default:
            .primary
        }
    }

    var body: some View {
        Text(title)
            .bold()
            .foregroundColor(.white)
            .padding(padding)
            .background(color)
            .cornerRadius(cornerRadius)
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
