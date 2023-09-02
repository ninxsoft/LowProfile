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
            ForEach(payloads) { payload in
                if let property: Property = payload.payloadProperties.first(where: { $0.name == propertyName }) {
                    Button {
                        selectedPayload = payload
                        selectedDetailTab = .payloadProperties
                        selectedProperty = property
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        VStack {
                            ResultsTitleView(title: "\(payload.name) (\(payload.payloadUUID))", image: payload.name)
                            ResultsKeyView(title: propertyName, bold: true, indentation: 1)
                            ResultsValueView(title: PayloadHelper.shared.string(for: property.value), indentation: 2)
                        }
                        .padding(padding)
                    }
                    .buttonStyle(.plain)

                    if payload != payloads.last {
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
