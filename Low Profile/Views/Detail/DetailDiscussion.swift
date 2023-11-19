//
//  DetailDiscussion.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import Highlightr
import SwiftUI

struct DetailDiscussion: View {
    @Environment(\.colorScheme)
    var colorScheme: ColorScheme
    var payload: Payload
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = .syntaxHighlightingThemeDefault
    private var discussionString: String {
        payload.discussion.joined(separator: "\n\n")
    }

    private var propertyList: AttributedString {
        guard let highlightr: Highlightr = Highlightr() else {
            return AttributedString()
        }

        if !highlightr.setTheme(to: highlightr.themeVariant(for: syntaxHighlightingTheme, using: colorScheme)) {
            highlightr.setTheme(to: highlightr.themeVariant(for: .syntaxHighlightingThemeDefault, using: colorScheme))
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
                        ScrollViewReader { value in
                            Text(propertyList)
                                .id(0)
                                .onAppear {
                                    value.scrollTo(0, anchor: .topLeading)
                                }
                        }
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
