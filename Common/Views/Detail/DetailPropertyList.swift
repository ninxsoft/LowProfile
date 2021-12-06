//
//  DetailPropertyList.swift
//  Low Profile
//
//  Created by Nindi Gill on 15/8/20.
//

import SwiftUI

struct DetailPropertyList: View {
    var string: String

    var body: some View {
        ScrollView(.vertical) {
            HStack {
                PropertyListText(string: string)
                Spacer()
            }
        }
        .padding()
    }
}

struct DetailPropertyList_Previews: PreviewProvider {
    static var previews: some View {
        DetailPropertyList(string: "Example")
    }
}
