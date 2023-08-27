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
    var value: Any
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = .syntaxHighlightingThemeDefault
    private let length: CGFloat = 50

    var body: some View {
        if let data: Data = value as? Data,
            let certificate: X509Certificate = try? X509Certificate(data: data) {
            Certificate(certificate: certificate, certificateImageLength: length)
        } else if let array: [Any] = value as? [Any],
            let propertyListString: String = propertyListString(for: array) {
            Text(attributedString(propertyListString) ?? "")
        } else if let dictionary: [String: Any] = value as? [String: Any],
            let propertyListString: String = propertyListString(for: dictionary) {
            Text(attributedString(propertyListString) ?? "")
        } else {
            Text(PayloadHelper.shared.string(for: value))
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

    private func attributedString(_ string: String) -> AttributedString? {

        guard let highlightr: Highlightr = Highlightr() else {
            return nil
        }

        if !highlightr.setTheme(to: syntaxHighlightingTheme) {
            highlightr.setTheme(to: .syntaxHighlightingThemeDefault)
        }

        return highlightr.highlight(string)
    }
}

struct CustomValue_Previews: PreviewProvider {
    static var previews: some View {
        CustomValue(value: "Value")
    }
}
