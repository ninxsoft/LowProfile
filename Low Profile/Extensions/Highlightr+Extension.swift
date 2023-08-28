//
//  Highlightr+Extension.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/8/2023.
//

import Foundation
import Highlightr
import SwiftUI

extension Highlightr {

    static func propertyListThemes() -> [String] {
        [
            "a11y",
            "atelier-cave",
            "atelier-dune",
            "atelier-estuary",
            "atelier-forest",
            "atelier-heath",
            "atelier-lakeside",
            "atelier-plateau",
            "atelier-savanna",
            "atelier-seaside",
            "atelier-sulphurpool",
            "atom-one",
            "gruvbox",
            "isbl-editor",
            "kimbie",
            "paraiso",
            "qtcreator",
            "solarized"
        ]
    }

    func themeVariant(for theme: String, using colorScheme: ColorScheme) -> String {

        switch theme {
        case "kimbie":
            return "\(theme).\(colorScheme)"
        case "qtcreator":
            return "\(theme)_\(colorScheme)"
        default:
            return "\(theme)-\(colorScheme)"
        }
    }

    func highlight(_ string: String) -> AttributedString {

        guard let attributedString: NSAttributedString = self.highlight(string) else {
            return AttributedString()
        }

        return AttributedString(attributedString)
    }
}
