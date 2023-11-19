//
//  CustomValue.swift
//  Low Profile
//
//  Created by Nindi Gill on 7/12/21.
//

import ASN1Decoder
import Highlightr
import SwiftUI

struct CustomValue: View {
    @Environment(\.colorScheme)
    var colorScheme: ColorScheme
    var value: Any
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = .syntaxHighlightingThemeDefault
    private var propertyList: AttributedString {
        guard let highlightr: Highlightr = Highlightr() else {
            return AttributedString()
        }

        if !highlightr.setTheme(to: highlightr.themeVariant(for: syntaxHighlightingTheme, using: colorScheme)) {
            highlightr.setTheme(to: highlightr.themeVariant(for: .syntaxHighlightingThemeDefault, using: colorScheme))
        }

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: value, format: .xml, options: 0)

            guard let string: String = String(data: data, encoding: .utf8) else {
                return AttributedString()
            }

            return highlightr.highlight(string.strippingPropertyListWrapper())
        } catch {
            print(error.localizedDescription)
            return AttributedString()
        }
    }

    private let length: CGFloat = 50

    var body: some View {
        Group {
            if
                let data: Data = value as? Data,
                let certificate: X509Certificate = try? X509Certificate(data: data) {
                Certificate(certificate: certificate, certificateImageLength: length)
            } else if (value as? [Any]) != nil {
                Text(propertyList)
            } else if (value as? [String: Any]) != nil {
                Text(propertyList)
            } else {
                Text(PayloadHelper.shared.string(for: value))
            }
        }
    }
}

struct CustomValue_Previews: PreviewProvider {
    static var previews: some View {
        CustomValue(value: "Value")
    }
}
