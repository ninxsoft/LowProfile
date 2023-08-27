//
//  Highlightr+Extension.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/8/2023.
//

import Foundation
import Highlightr

extension Highlightr {

    func highlight(_ string: String) -> AttributedString {

        guard let attributedString: NSAttributedString = self.highlight(string) else {
            return AttributedString()
        }

        return AttributedString(attributedString)
    }
}
