//
//  ContentView.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/3/2022.
//

import SwiftUI

// swiftlint:disable:next type_body_length
struct ContentView: View {
    @Environment(\.openURL)
    var openURL: OpenURLAction
    @State private var profiles: [Profile] = []
    @State private var selectedProfile: Profile?
    @State private var selectedPayload: Payload?
    @State private var previousSelections: [String: String] = [:]
    @State private var selectedDetailTab: DetailTab = .information
    @State private var selectedProperty: Property?
    @State private var searchString: String = ""
    @State private var refreshing: Bool = false
    @State private var issues: [Issue] = []
    @State private var showIssuesPopover: Bool = false
    private var issuesButtonSystemName: String {
        issues.isEmpty ? "checkmark.circle" : "exclamationmark.triangle"
    }

    private var issuesButtonForegroundColor: Color {
        issues.isEmpty ? .green : .orange
    }

    private let profilesSidebarWidth: CGFloat = 250
    private let payloadsSidebarWidth: CGFloat = 275
    private let width: CGFloat = 1_260
    private let height: CGFloat = 720

    var body: some View {
        NavigationSplitView {
            List(profiles, selection: $selectedProfile) { profile in
                NavigationLink(value: profile) {
                    SidebarProfileRow(profile: profile)
                }
            }
            .frame(minWidth: profilesSidebarWidth)
        } content: {
            if let profile: Profile = selectedProfile {
                List(profile.payloads, selection: $selectedPayload) { payload in
                    NavigationLink(value: payload) {
                        SidebarPayloadRow(payload: payload)
                    }
                    .listRowSeparator(.hidden)
                }
                .frame(minWidth: payloadsSidebarWidth)
            } else {
                EmptyView()
                    .frame(width: payloadsSidebarWidth)
            }
        } detail: {
            if let profile: Profile = selectedProfile {
                if let payload: Payload = selectedPayload {
                    Detail(payload: payload, certificates: profile.certificates, selectedDetailTab: $selectedDetailTab, selectedProperty: $selectedProperty)
                } else {
                    Text("Select a Payload to view its contents 🙂")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
            } else {
                Text(profiles.isEmpty ? "There are no Profiles installed, lucky you 🙂" : "Select a Profile to view its contents 🙂")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
        }
        .searchable(text: $searchString, prompt: "Name, identifier or property")
        .searchSuggestions {
            ForEach(filteredProfiles()) { profile in
                ResultsTitleView(title: profile.name, image: "Profile")
                    .tag(profile.id)
                    .onTapGesture {
                        selectedProfile = profile
                        selectedPayload = nil
                        selectedDetailTab = .information
                        searchString = ""
                    }
                ForEach(filteredPayloads(for: profile)) { payload in
                    ResultsTitleView(title: payload.name, image: payload.name, indentation: 1)
                        .tag(payload.payloadUUID)
                        .onTapGesture {
                            selectedProfile = profile
                            selectedPayload = payload
                            selectedDetailTab = .information
                            searchString = ""
                        }
                    ForEach(PropertySection.allCases) { propertySection in
                        ForEach(filteredProperties(for: propertySection, using: payload)) { property in
                            ResultsKeyView(title: property.name, bold: false, indentation: 2)
                                .tag("\(payload.payloadUUID).\(property.name)")
                                .onTapGesture {
                                    setSelectedPropertyState(profile: profile, payload: payload, detailTab: detailTab(for: propertySection), property: property)
                                }
                        }
                    }
                }
            }
        }
        .toolbar {
            toolbarItemGroup()
        }
        .frame(minWidth: width, minHeight: height)
        .sheet(isPresented: $refreshing) {
            RefreshView()
        }
        .onAppear {
            refreshProfiles()
        }
        .onChange(of: selectedProfile) { profile in

            guard let profile: Profile = selectedProfile else {
                return
            }

            selectedPayload = profile.payloads.first { $0.id == previousSelections[profile.id] } ?? profile.payloads.first
        }
        .onChange(of: selectedPayload) { _ in

            guard
                let profile: Profile = selectedProfile,
                let payload: Payload = selectedPayload else {
                return
            }

            previousSelections[profile.id] = payload.id
        }
    }

    private func toolbarItemGroup() -> ToolbarItemGroup<some View> {
        // swiftlint:disable:next closure_body_length
        ToolbarItemGroup {
            if !issues.isEmpty {
                Text("\(issues.count) issue\(issues.count == 1 ? "" : "s") detected")
            }
            Button(action: {
                showIssuesPopover = true
            }, label: {
                Image(systemName: issuesButtonSystemName)
                    .foregroundColor(issuesButtonForegroundColor)
            })
            .help("Issues")
            .popover(isPresented: $showIssuesPopover, arrowEdge: .bottom) {
                if !issues.isEmpty {
                    IssuesView(issues: issues, selectedProfile: $selectedProfile, selectedPayload: $selectedPayload, selectedDetailTab: $selectedDetailTab, selectedProperty: $selectedProperty)
                } else {
                    Text("No issues detected, everything looks good 🥳").padding()
                }
            }
            Button {
                refreshProfiles()
            } label: {
                Label("Refresh Profiles", systemImage: "arrow.clockwise")
                    .foregroundColor(.accentColor)
            }
            .help("Refresh Profiles")
            Button {
                export()
            } label: {
                Label("Export Installed Profiles Report", systemImage: "square.and.arrow.up")
                    .foregroundColor(.accentColor)
            }
            .help("Export Installed Profiles Report")
            Button {
                homepage()
            } label: {
                Label("Visit Website", systemImage: "questionmark.circle")
                    .foregroundColor(.accentColor)
            }
            .help("Visit Website")
        }
    }

    func refreshProfiles() {
        refreshing = true

        Task {
            await PayloadHelper.shared.refresh()
            let profiles: [Profile] = ProfileHelper.shared.getProfiles()
            self.profiles = profiles
            selectedProfile = profiles.first
            selectedPayload = selectedProfile?.payloads.first
            issues = IssuesHelper.shared.getIssues(for: profiles)
            refreshing = false
        }
    }

    private func filteredProfiles() -> [Profile] {
        profiles.filter {
            $0.name.lowercased().contains(searchString.lowercased()) ||
                $0.id.lowercased().contains(searchString.lowercased()) ||
                !$0.payloads.filter {
                    $0.name.lowercased().contains(searchString.lowercased()) ||
                        $0.payloadIdentifier.lowercased().contains(searchString.lowercased()) ||
                        !$0.payloadProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
                        !$0.availableProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
                        !$0.unknownProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty
                }.isEmpty
        }
    }

    private func filteredPayloads(for profile: Profile) -> [Payload] {
        profile.payloads.filter {
            $0.name.lowercased().contains(searchString.lowercased()) ||
                $0.payloadIdentifier.lowercased().contains(searchString.lowercased()) ||
                !$0.payloadProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
                !$0.availableProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty ||
                !$0.unknownProperties.map(\.name).filter { $0.lowercased().contains(searchString.lowercased()) }.isEmpty
        }
    }

    private func filteredProperties(for propertySection: PropertySection, using payload: Payload) -> [Property] {
        switch propertySection {
        case .payload:
            payload.payloadProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        case .available:
            payload.availableProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        case .unknown:
            payload.unknownProperties.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        }
    }

    private func detailTab(for propertySection: PropertySection) -> DetailTab {
        switch propertySection {
        case .payload:
            .payloadProperties
        case .available:
            .availableProperties
        case .unknown:
            .unknownProperties
        }
    }

    private func setSelectedPropertyState(profile: Profile, payload: Payload, detailTab: DetailTab, property: Property) {
        selectedProfile = profile
        selectedPayload = payload
        selectedDetailTab = detailTab
        selectedProperty = property
        searchString = ""
    }

    private func export() {
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date: String = dateFormatter.string(from: Date())

        let savePanel: NSSavePanel = .init()
        savePanel.title = "Export Low Profile Report"
        savePanel.prompt = "Export"
        savePanel.nameFieldStringValue = "Low Profile Report \(date)"
        savePanel.canCreateDirectories = true
        savePanel.canSelectHiddenExtension = true
        savePanel.isExtensionHidden = false
        savePanel.allowedContentTypes = [.lowprofilereport]

        let response: NSApplication.ModalResponse = savePanel.runModal()

        guard
            response == .OK,
            let url: URL = savePanel.url else {
            return
        }

        let array: [[String: Any]] = profiles.map(\.dictionary)

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: array, format: .xml, options: .bitWidth)
            let string: String = .init(decoding: data, as: UTF8.self)
            try string.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func homepage() {
        guard let url: URL = URL(string: .repositoryURL) else {
            return
        }

        openURL(url)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
