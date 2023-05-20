//
//  CustomValue.swift
//  Low Profile
//
//  Created by Nindi Gill on 7/12/21.
//

import ASN1Decoder
import HighlightSwift
import SwiftUI

struct CustomValue: View {

    var value: Any
    private let length: CGFloat = 50
    private var string: String {

        if let boolean: Bool = value as? Bool {
            return boolean ? "True" : "False"
        }

        if let data: Data = value as? Data {
            return data.base64EncodedString(options: [.lineLength64Characters, .endLineWithCarriageReturn])
        }

        if let date: Date = value as? Date {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .long
            return dateFormatter.string(from: date)
        }

        if let number: NSNumber = value as? NSNumber {
            return number.stringValue
        }

        if let string: String = value as? String {
            return string
        }

        if let strings: [String] = value as? [String] {
            let string: String = strings.joined(separator: "\n")
            return string.description
        }

        if let data: Data = try? JSONSerialization.data(withJSONObject: value, options: [.prettyPrinted, .sortedKeys]),
            let string: String = String(data: data, encoding: .utf8) {
            return string
        }

        return "Unknown type"
    }

    var body: some View {
        if let data: Data = value as? Data,
            let certificate: X509Certificate = try? X509Certificate(data: data) {
            Certificate(certificate: certificate, certificateImageLength: length)
        } else if let array: [Any] = value as? [Any],
            let propertyListString: String = propertyListString(for: array) {
            CodeText(propertyListString, style: .github)
        } else if let dictionary: [String: Any] = value as? [String: Any],
            let propertyListString: String = propertyListString(for: dictionary) {
            CodeText(propertyListString, style: .github)
        } else {
            Text(string)
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
}

struct CustomValue_Previews: PreviewProvider {
    static var previews: some View {
        CustomValue(value: "Value")
    }
}
