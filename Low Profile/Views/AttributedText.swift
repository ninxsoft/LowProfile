//
//  AttributedText.swift
//  Low Profile
//
//  Created by Nindi Gill on 14/8/20.
//

import SwiftUI

struct AttributedText: View {
    var string: String
    private var attributedText: Text {
        let strings: [String] = string.split(separator: "∙").map { String($0) }
        var attributedText: Text = .init("")

        for string in strings {
            var formattedText: Text = if string ~= "`.*`" {
                .init(.init(string)).foregroundColor(.pink)
            } else if string ~= "\\*.*\\*" {
                .init(.init(string)).foregroundColor(.green)
            } else {
                .init(.init(string)).foregroundColor(.secondary)
            }

            // swiftlint:disable:next shorthand_operator
            attributedText = attributedText + formattedText
        }

        return attributedText
    }

    var body: some View {
        attributedText
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText(string: "Example")
    }
}
