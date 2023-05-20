//
//  DetailDiscussion.swift
//  Low Profile
//
//  Created by Nindi Gill on 6/12/21.
//

import HighlightSwift
import SwiftUI

struct DetailDiscussion: View {
    var payload: Payload
    @AppStorage("SyntaxHighlightingTheme")
    private var syntaxHighlightingTheme: String = "GitHub"
    private var highlightStyleName: HighlightStyle.Name {
        HighlightStyle.Name(rawValue: syntaxHighlightingTheme) ?? .github
    }
    private var discussionString: String {
        payload.discussion.joined(separator: "\n\n")
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
                    ScrollView(.vertical) {
                        HStack {
                            CodeText(payload.example, style: highlightStyleName)
                            Spacer()
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
