//
//  IssuesDetailProfilesView.swift
//  Low Profile
//
//  Created by Nindi Gill on 27/6/2023.
//

import SwiftUI

struct IssuesDetailProfilesView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    var propertyName: String
    var profiles: [Profile]
    @Binding var selectedProfile: Profile?
    @Binding var selectedPayload: Payload?
    @Binding var selectedDetailTab: DetailTab
    @Binding var selectedProperty: Property?
    private let padding: CGFloat = 5

    var body: some View {
        GroupBox {
            ForEach(profiles) { profile in
                ForEach(profile.payloads.filter { $0.payloadProperties.map { $0.name }.contains(propertyName) }) { payload in
                    if let property: Property = payload.payloadProperties.first(where: { $0.name == propertyName }) {
                        Button {
                            selectedProfile = profile
                            selectedPayload = payload
                            selectedDetailTab = .payloadProperties
                            selectedProperty = property
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            VStack {
                                ResultsTitleView(title: profile.name, image: "Profile")
                                ResultsTitleView(
                                    title: "\(payload.name) (\(payload.payloadUUID))",
                                    image: payload.name,
                                    indentation: 1
                                )
                                ResultsKeyView(title: propertyName, bold: true, indentation: 2)
                                ResultsValueView(title: PayloadHelper.shared.string(for: property.value), indentation: 3)
                            }
                            .padding(padding)
                        }
                        .buttonStyle(.plain)

                        if profile != profiles.last || payload != profile.payloads.last(where: { $0.payloadProperties.map { $0.name }.contains(propertyName) }) {
                            Divider()
                        }
                    }
                }
            }
        }
        .listRowSeparator(.hidden)
        .padding(.bottom)
    }
}

struct IssuesDetailProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        IssuesDetailProfilesView(
            propertyName: Property.example.name,
            profiles: [.example],
            selectedProfile: .constant(.example),
            selectedPayload: .constant(.example),
            selectedDetailTab: .constant(.payloadProperties),
            selectedProperty: .constant(.example)
        )
    }
}
