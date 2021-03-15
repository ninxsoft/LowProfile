//
//  AttributedText.swift
//  Low Profile
//
//  Created by Nindi Gill on 14/8/20.
//

import SwiftUI

struct AttributedText: View {
    var string: String
    var attributedText: Text {
        let seperator: String = "<>"
        let unformattedString: String = string.isEmpty ? "-" : string
        let unformattedStrings: [String] = unformattedString.components(separatedBy: seperator)
        var attributedText: Text = Text("")

        for unformattedString in unformattedStrings {

            var formattedText: Text

            if unformattedString ~= "<code>.*?<\\/code>" {
                formattedText = code(for: unformattedString)
            } else if unformattedString ~= "<emphasis>.*?<\\/emphasis>" {
                formattedText = emphasis(for: unformattedString)
            } else if unformattedString ~= "\\[.*?\\]\\(.*?\\)" {
                formattedText = link(for: unformattedString)
            } else {
                formattedText = text(for: unformattedString)
            }

            // swiftlint:disable:next shorthand_operator
            attributedText = attributedText + formattedText
        }

        return attributedText
    }

    var body: some View {
        attributedText
    }

    private func code(for string: String) -> Text {
        let string: String = string.replacingOccurrences(of: "<code>", with: "")
            .replacingOccurrences(of: "</code>", with: "")
        return Text(string)
            .foregroundColor(.pink)
            .font(.system(.body, design: .monospaced))
    }

    private func emphasis(for string: String) -> Text {
        let string: String = string.replacingOccurrences(of: "<emphasis>", with: "")
            .replacingOccurrences(of: "</emphasis>", with: "")
        return Text(string)
            .foregroundColor(.green)
            .bold()
            .italic()
    }

    private func link(for string: String) -> Text {
        var string: String = string.replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: ")", with: "")

        if let first: String = string.components(separatedBy: "](").first {
            string = first
        } else {
            string = "Link"
        }

        return Text(string)
            .foregroundColor(.blue)
            .underline()
    }

    private func text(for string: String) -> Text {
        Text(string)
            .foregroundColor(.gray)
    }

    private func linkURL(for link: String) -> URL {

        var string: String = link.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: ")", with: "")

        if let last: String = string.components(separatedBy: "](").last {
            string = last
        } else {
            string = "https://developer.apple.com/documentation/devicemanagement"
        }

        guard let url: URL = URL(string: string) else {
            // swiftlint:disable:next force_unwrapping
            return URL(string: "https://developer.apple.com/documentation/devicemanagement")!
        }

        return url
    }
}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText(string: "Example")
    }
}
