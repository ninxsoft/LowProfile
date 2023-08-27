//
//  DetailDiscussion.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import Highlightr
import SwiftUI

struct DetailDiscussion: View {
    var payload: Payload
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = .syntaxHighlightingThemeDefault
    private var discussionString: String {
        payload.discussion.joined(separator: "\n\n")
    }
    private var propertyList: AttributedString? {

        guard let highlightr: Highlightr = Highlightr() else {
            return nil
        }

        if !highlightr.setTheme(to: syntaxHighlightingTheme) {
            highlightr.setTheme(to: .syntaxHighlightingThemeDefault)
        }

        return highlightr.highlight(payload.example)
    }

    var body: some View {
        VStack {
            AttributedText(string: discussionString)
                .font(.title3)
                .padding(.bottom)
            if !payload.general {
                HStack {
                    Text("Example Property List")
                        .font(.title)
                    Spacer()
                }
                GroupBox {
                    ScrollView([.horizontal, .vertical]) {
                        Text(propertyList ?? "")
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct DetailDiscussion_Previews: PreviewProvider {
    static var previews: some View {
        DetailDiscussion(payload: .example)
    }
}
