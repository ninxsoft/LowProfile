//
//  DetailPropertyList.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import HighlightSwift
import SwiftUI

struct DetailPropertyList: View {
    var string: String
    @State private var loading: Bool = true
    @State private var propertyList: AttributedString = ""

    var body: some View {
        VStack {
            if loading {
                ProgressView()
            } else {
                ScrollView(.vertical) {
                    HStack {
                        Text(propertyList)
                        Spacer()
                    }
                }
            }
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
            propertyList = try await Highlight.text(string, style: .dark(.github)).attributed
        } catch {
            propertyList = AttributedString(string)
        }

        loading = false
    }
}

struct DetailPropertyList_Previews: PreviewProvider {
    static var previews: some View {
        DetailPropertyList(string: "Example")
    }
}
