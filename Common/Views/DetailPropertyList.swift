//
//  DetailPropertyList.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import SwiftUI

struct DetailPropertyList: View {
    var string: String
    @State private var visible: Bool = false
    @State private var background: Bool = false
    private let length: CGFloat = 24
    private let cornerRadius: CGFloat = 5

    var body: some View {
        VStack {
            ZStack {
                ScrollView(.vertical) {
                    HStack {
                        PropertyListText(string: string)
                        Spacer()
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if visible {
                            Button(action: {
                                copyToPasteboard()
                            }, label: {
                                Image(systemName: "doc.on.doc")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.secondary)
                                    .frame(width: length, height: length)
                                    .background(
                                        Rectangle()
                                            .padding()
                                            .background(background ? Color(.gridColor) : Color.clear)
                                            .cornerRadius(cornerRadius)
                                    )
                            })
                            .buttonStyle(PlainButtonStyle())
                            .onHover { hovering in
                                background = hovering
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .onHover { hovering in
            withAnimation {
                visible = hovering
            }
        }
    }

    private func copyToPasteboard() {
        let pasteboard: NSPasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.setString(string, forType: .string)
    }
}

struct DetailPropertyList_Previews: PreviewProvider {
    static var previews: some View {
        DetailPropertyList(string: "Example")
    }
}
