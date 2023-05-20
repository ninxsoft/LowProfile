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
    @State private var loading: Bool = true
    @State private var propertyList: AttributedString = ""
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
                    if loading {
                        Spacer()
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        Spacer()
                    } else {
                        ScrollView(.vertical) {
                            HStack {
                                Text(propertyList)
                                Spacer()
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            Task {
                await getAttributedPropertyList()
            }
        }
    }

    private func getAttributedPropertyList() async {
        do {
            propertyList = try await Highlight.text(payload.example, style: .dark(.github)).attributed
        } catch {
            propertyList = AttributedString(payload.example)
        }

        loading = false
    }
}

struct DetailDiscussion_Previews: PreviewProvider {
    static var previews: some View {
        DetailDiscussion(payload: .example)
    }
}
