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
    @State private var propertyList: AttributedString = AttributedString()
    private let length: CGFloat = 50

    var body: some View {
        Group {
            if let data: Data = value as? Data,
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
        .onAppear {
            updatePropertyList(using: colorScheme)
        }
        .onChange(of: syntaxHighlightingTheme) { _ in
            updatePropertyList(using: colorScheme)
        }
        .onChange(of: colorScheme) { colorScheme in
            updatePropertyList(using: colorScheme)
        }
    }

    private func propertyListString(for value: Any) -> String? {

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: value, format: .xml, options: 0)

            guard let string: String = String(data: data, encoding: .utf8) else {
                return nil
            }

            return string.strippingPropertyListWrapper()
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    private func updatePropertyList(using colorScheme: ColorScheme) {

        guard let highlightr: Highlightr = Highlightr() else {
            return
        }

        if !highlightr.setTheme(to: highlightr.themeVariant(for: syntaxHighlightingTheme, using: colorScheme)) {
            highlightr.setTheme(to: highlightr.themeVariant(for: .syntaxHighlightingThemeDefault, using: colorScheme))
        }

        if let array: [Any] = value as? [Any],
            let string: String = propertyListString(for: array) {
            propertyList = highlightr.highlight(string)
        } else if let dictionary: [String: Any] = value as? [String: Any],
            let string: String = propertyListString(for: dictionary) {
            propertyList = highlightr.highlight(string)
        }
    }
}

struct CustomValue_Previews: PreviewProvider {
    static var previews: some View {
        CustomValue(value: "Value")
    }
}
