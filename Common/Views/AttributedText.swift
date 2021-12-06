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
        var attributedText: Text = Text("")

        for string in strings {

            var formattedText: Text

            if string ~= "`.*`" {
                formattedText = Text(.init(string)).foregroundColor(.pink)
            } else if string ~= "\\*.*\\*" {
                formattedText = Text(.init(string)).foregroundColor(.green)
            } else {
                formattedText = Text(.init(string))
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
