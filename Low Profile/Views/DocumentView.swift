//
//  DocumentView.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/8/20.
//

import SwiftUI

struct DocumentView: View {
    @Environment(\.openURL)
    var openURL: OpenURLAction
    var profile: Profile
    @State private var selectedPayload: Payload?
    @State private var selectedDetailTab: DetailTab = .information
    @State private var selectedProperty: Property?
    private let sidebarWidth: CGFloat = 250
    private let width: CGFloat = 1_080
    private let height: CGFloat = 720

    var body: some View {
        NavigationSplitView {
            List(profile.payloads, id: \.id, selection: $selectedPayload) { payload in
                NavigationLink(value: payload) {
                    SidebarPayloadRow(payload: payload)
                }
            }
            .frame(minWidth: sidebarWidth)
        } detail: {
            if let payload: Payload = selectedPayload {
                Detail(payload: payload, certificates: profile.certificates, selectedDetailTab: $selectedDetailTab, selectedProperty: $selectedProperty)
            } else {
                Text("Select a Payload to view its contents 🙂")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .searchable(text: $searchString, prompt: Text("Name, identifier or property"))
        .toolbar {
            ToolbarItem {
                Button(action: {
                    homepage()
                }, label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.accentColor)
                })
                .help("Visit Website")
            }
        }
        .frame(minWidth: width, minHeight: height)
        .onAppear {
            selectedPayload = profile.payloads.first

    private func filteredPayloads() -> [Payload] {
        profile.payloads.filter {
            $0.name.lowercased().contains(searchString.lowercased()) ||
            $0.payloadIdentifier.lowercased().contains(searchString.lowercased()) ||
            !$0.payloadProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
            !$0.availableProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
            !$0.unknownProperties.map { $0.name }.filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty
        }
    }

    private func filteredProperties(for propertySection: PropertySection, using payload: Payload) -> [Property] {
        switch propertySection {
        case .payload:
            return payload.payloadProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        case .available:
            return payload.availableProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        case .unknown:
            return payload.unknownProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        }
    }

    private func detailTab(for propertySection: PropertySection) -> DetailTab {
        switch propertySection {
        case .payload:
            return .payloadProperties
        case .available:
            return .availableProperties
        case .unknown:
            return .unknownProperties
        }
    }

    private func setSelectedPropertyState(payload: Payload, detailTab: DetailTab, property: Property) {
        selectedPayload = payload
        selectedDetailTab = detailTab
        selectedProperty = property
        searchString = ""
    }

    private func homepage() {

        guard let url: URL = URL(string: .repositoryURL) else {
            return
        }

        openURL(url)
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(profile: .example)
    }
}
