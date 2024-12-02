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
    /// The array of Syntax Highlighting theme names.
    ///
    /// - Returns: An array of Syntax Highlighting theme names.
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

    /// Returns the Synxtax Highlighting theme name 'variant' based on the provided color scheme.
    ///
    /// - Parameters:
    ///   - theme:       The Syntax Highlighting theme.
    ///   - colorScheme: The Syntax Highlighting theme variant.
    ///
    /// - Returns: The Syntax Highlighting theme name (including the variant).
    func themeVariant(for theme: String, using colorScheme: ColorScheme) -> String {
        switch theme {
        case "kimbie":
            "\(theme).\(colorScheme)"
        case "qtcreator":
            "\(theme)_\(colorScheme)"
        default:
            "\(theme)-\(colorScheme)"
        }
    }

    /// Highlights a string with the current Syntax Highlighting theme.
    ///
    /// - Parameters:
    ///   - string: The string to syntax highlight.
    ///
    /// - Returns: A syntax highlighted `AttributedString`.
    func highlight(_ string: String) -> AttributedString {
        guard let attributedString: NSAttributedString = highlight(string) else {
            return AttributedString()
        }

        return AttributedString(attributedString)
    }
}
