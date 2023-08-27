//
//  IssuesDetailPayloadsView.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/6/2023.
//

import SwiftUI

struct IssuesDetailPayloadsView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    var propertyName: String
    var payloads: [Payload]
    @Binding var selectedPayload: Payload?
    @Binding var selectedDetailTab: DetailTab
    @Binding var selectedProperty: Property?
    private let padding: CGFloat = 5

    var body: some View {
        GroupBox {
            ForEach(payloads.indices, id: \.self) { index in
                if let property: Property = payloads[index].payloadProperties.first(where: { $0.name == propertyName }) {
                    Button {
                        selectedPayload = payloads[index]
                        selectedDetailTab = .payloadProperties
                        selectedProperty = property
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        VStack {
                            ResultsTitleView(title: "\(payloads[index].name) (\(payloads[index].payloadUUID))", image: payloads[index].name)
                            ResultsKeyView(title: propertyName, bold: true, indentation: 1)
                            ResultsValueView(title: PayloadHelper.shared.string(for: property.value), indentation: 2)
                        }
                        .padding(padding)
                    }
                    .buttonStyle(.plain)

                    if index < payloads.count - 1 {
                        Divider()
                    }
                }
            }
        }
        .listRowSeparator(.hidden)
        .padding(.bottom)
    }
}

struct IssuesDetailPayloadsView_Previews: PreviewProvider {
    static var previews: some View {
        IssuesDetailPayloadsView(
            propertyName: Property.example.name,
            payloads: [.example],
            selectedPayload: .constant(.example),
            selectedDetailTab: .constant(.payloadProperties),
            selectedProperty: .constant(.example)
        )
    }
}
