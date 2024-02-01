//
//  String+Extension.swift
//  Low Profile
//
//  Created by Nindi Gill on 8/8/20.
//

import Foundation
import RegexBuilder

extension String {
    static let repositoryURL: String = "https://github.com/ninxsoft/LowProfile"
    static let payloadsURL: String = "https://raw.githubusercontent.com/ninxsoft/LowProfile/main/Low%20Profile/Payloads.yaml"
    static let documentationPrefix: String = "https://developer.apple.com/documentation/devicemanagement/"
    static let syntaxHighlightingThemeDefault: String = "solarized"

    static func ~= (lhs: String, rhs: String) -> Bool {
        lhs.range(of: rhs, options: .regularExpression) != nil
    }

    func strippingPropertyListWrapper() -> String {
        let xml: String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
        let doctype: String = "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">"
        let plist: String = "<plist version=\"1.0\">"

        return replacingOccurrences(of: xml, with: "")
            .replacingOccurrences(of: doctype, with: "")
            .replacingOccurrences(of: plist, with: "")
            .replacingOccurrences(of: "</plist>", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func replacingUnicode() -> String {
        let regex: Regex = Regex {
            "\\U"
            Capture {
                One(.hexDigit)
                One(.hexDigit)
                One(.hexDigit)
                One(.hexDigit)
            }
        }

        let matches: [Regex<Regex<Regex<(Substring, Regex<Substring>.RegexOutput)>.RegexOutput>.RegexOutput>.Match] = matches(of: regex)
        var string: String = self

        for match in matches {
            guard
                let hexadecimal: Int = Int(String(match.output.1), radix: 16),
                let scalar: UnicodeScalar = UnicodeScalar(hexadecimal) else {
                continue
            }

            string = string.replacingOccurrences(of: match.output.0, with: String(scalar))
        }

        return string
    }

    // swiftlint:disable:next function_body_length
    func toJSONString() -> String? {
        guard !isEmpty else {
            return "{}"
        }

        let identifier: String = UUID().uuidString
        var string: String = self
        string = string.replacingOccurrences(of: "(\n", with: "[\n")
        string = string.replacingOccurrences(of: ");\n", with: "],\n")
        string = string.replacingOccurrences(of: "};\n", with: "},\n")
        string = string.replacingOccurrences(of: ";\n", with: ",\n")

        if contains("-----BEGIN PUBLIC KEY-----"), contains("-----END PUBLIC KEY-----") {
            string = string.replacingOccurrences(of: "\r", with: "")
        }

        string.enumerateLines { line, _ in

            var components: [String] = line.lowercased().contains("authorization: basic") ? [line] : line.components(separatedBy: "=")

            if components.count > 1 {
                components.insert(identifier, at: 1)
            }

            components = components.joined().components(separatedBy: identifier)

            if components.count > 1 {
                components.insert(identifier, at: 1)
            }

            for (index, component) in components.enumerated() {
                if index == 0, component ~= "^ *[a-zA-Z0-9]+ $", !(component ~= "^ *\\d+$") {
                    let firstIndex: String.Index = component.firstIndex { $0 != " " } ?? component.startIndex
                    let lastIndex: String.Index = component.lastIndex { $0 != " " } ?? component.endIndex
                    let range: Range<String.Index> = firstIndex ..< component.index(after: lastIndex)
                    components[index] = "\(component[component.startIndex ..< firstIndex])\"\(component[range])\"\(component[component.index(after: lastIndex) ..< component.endIndex])"
                } else if index == components.count - 1, component ~= "^ *.*,?$", !(component ~= "^ *(\\d+|\\{|\\}|\\[|\\]),?$"), !(component ~= "^ *\".*\",?$") {
                    let firstIndex: String.Index = component.firstIndex { $0 != " " } ?? component.startIndex
                    let lastIndex: String.Index = component.lastIndex { $0 != "," } ?? component.endIndex
                    let range: Range<String.Index> = firstIndex ..< component.index(after: lastIndex)
                    components[index] = "\(component[component.startIndex ..< firstIndex])\"\(component[range])\"\(component[component.index(after: lastIndex) ..< component.endIndex])"
                }
            }

            string = string.replacingOccurrences(of: line, with: components.joined())
        }

        string = string.replacingOccurrences(of: identifier, with: ":").replacing(/\: ""[^,]/, with: ": \"").replacing(/"?(\s""""\\n"""")+/, with: "\\n\\n").replacingUnicode()

        guard let data: Data = string.data(using: .utf8) else {
            return nil
        }

        do {
            guard let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return nil
            }

            let data: Data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)

            guard let string: String = String(data: data, encoding: .utf8) else {
                return nil
            }

            return string
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
