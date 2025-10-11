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
