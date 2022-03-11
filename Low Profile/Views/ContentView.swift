//
//  ContentView.swift
//  Low Profile
//
//  Created by Nindi Gill on 2/3/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL: OpenURLAction
    @State private var profiles: [Profile] = []
    @State private var selectedProfile: Profile?
    @State private var searchString: String = ""
    @State private var refreshing: Bool = false
    private var filteredProfiles: [Profile] {
        searchString.isEmpty ? profiles : profiles.filter { $0.name.lowercased().contains(searchString.lowercased()) }
    }
    private var selectionString: String {
        "Select a \(selectedProfile == nil ? "Profile" : "Payload") to view its contents 🙂"
    }
    private let sidebarWidth: CGFloat = 250
    private let width: CGFloat = 1_080
    private let height: CGFloat = 720
    private let keys: [String] = [
        "_name",
        "_items",
        "spconfigprofile_profile_identifier",
        "spconfigprofile_profile_uuid",
        "spconfigprofile_other_info",
        "spconfigprofile_description",
        "spconfigprofile_organization",
        "spconfigprofile_version",
        "spconfigprofile_RemovalDisallowed",
        "spconfigprofile_install_date",
        "spconfigprofile_certificate_payload_uuid",
        "spconfigprofile_verification_state",
        "spconfigprofile_payload_identifier",
        "spconfigprofile_payload_display_name",
        "spconfigprofile_payload_uuid",
        "spconfigprofile_payload_version",
        "spconfigprofile_payload_data"
    ]

    var body: some View {
        NavigationView {
            List(filteredProfiles, selection: $selectedProfile) { profile in
                NavigationLink(destination: SidebarPayloadsView(profile: profile), tag: profile, selection: $selectedProfile) {
                    SidebarProfileRow(profile: profile)
                }
            }
            .searchable(text: $searchString)
            .frame(width: sidebarWidth)
            EmptyView()
                .frame(width: sidebarWidth)
            Text(selectionString)
                .font(.title)
                .foregroundColor(.secondary)
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    toggleSidebar()
                } label: {
                    Label("Toggle Sidebar", systemImage: "sidebar.left")
                        .foregroundColor(.accentColor)
                }
                .help("Toggle Sidebar")
            }
            ToolbarItemGroup {
                Button {
                    refreshProfiles()
                } label: {
                    Label("Refresh Profiles", systemImage: "arrow.clockwise")
                        .foregroundColor(.accentColor)
                }
                .help("Refresh Profiles")
                Button {
                    homepage()
                } label: {
                    Label("Visit Website", systemImage: "questionmark.circle")
                        .foregroundColor(.accentColor)
                }
                .help("Visit Website")
            }
        }
        .frame(minWidth: width, minHeight: height)
        .sheet(isPresented: $refreshing) {
            RefreshView()
        }
        .onAppear {
            refreshProfiles()
        }
    }

    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }

    func refreshProfiles() {

        refreshing = true

        DispatchQueue.global(qos: .background).async {

            let profiles: [Profile] = getProfiles()

            guard !profiles.isEmpty else {

                DispatchQueue.main.async {
                    refreshing = false
                }

                return
            }

            DispatchQueue.main.async {
                selectedProfile = nil
                self.profiles = profiles
                refreshing = false
            }
        }
    }

    private func getProfiles() -> [Profile] {

        let url: URL = URL(fileURLWithPath: "\(NSTemporaryDirectory())/LowProfile.plist")

        guard FileManager.default.createFile(atPath: url.path, contents: nil) else {
            return []
        }

        do {
            let output: FileHandle = try FileHandle(forWritingTo: url)
            let process: Process = Process()
            process.launchPath = "/usr/bin/env"
            process.arguments = ["system_profiler", "-xml", "SPConfigurationProfileDataType", "-detailLevel", "full"]
            process.standardOutput = output
            process.launch()
            process.waitUntilExit()

            guard process.terminationStatus == 0 else {
                return []
            }

            let data: Data = try Data(contentsOf: url)
            var format: PropertyListSerialization.PropertyListFormat = .xml

            guard let array: [[String: Any]] = try PropertyListSerialization.propertyList(from: data, options: [], format: &format) as? [[String: Any]],
                !array.isEmpty,
                let parentItems: [[String: Any]] = array[0]["_items"] as? [[String: Any]],
                !parentItems.isEmpty,
                let items: [[String: Any]] = parentItems[0]["_items"] as? [[String: Any]] else {
                return []
            }

            var profiles: [Profile] = []

            for item in items {

                guard let profile: Profile = profile(for: item) else {
                    continue
                }

                profiles.append(profile)
            }

            return profiles.sorted { $0.name < $1.name }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    private func profile(for dictionary: [String: Any]) -> Profile? {

        var dictionary: [String: Any] = dictionary
        dictionary["PayloadType"] = "Configuration"
        dictionary["PayloadDisplayName"] = dictionary["_name"]
        dictionary["PayloadIdentifier"] = dictionary["spconfigprofile_profile_identifier"]
        dictionary["PayloadUUID"] = dictionary["spconfigprofile_profile_uuid"]
        dictionary["PayloadDescription"] = dictionary["spconfigprofile_description"]
        dictionary["PayloadOrganization"] = dictionary["spconfigprofile_organization"]
        dictionary["PayloadVersion"] = dictionary["spconfigprofile_version"]
        dictionary["PayloadRemovalDisallowed"] = dictionary["spconfigprofile_RemovalDisallowed"]

        guard let array: [[String: Any]] = dictionary["_items"] as? [[String: Any]] else {
            return nil
        }

        var payloadContent: [[String: Any]] = []

        for item in array {
            var payloadDictionary: [String: Any] = item
            payloadDictionary["PayloadType"] = payloadDictionary["_name"]
            payloadDictionary["PayloadDisplayName"] = payloadDictionary["spconfigprofile_payload_display_name"]
            payloadDictionary["PayloadIdentifier"] = payloadDictionary["spconfigprofile_payload_identifier"]
            payloadDictionary["PayloadUUID"] = payloadDictionary["spconfigprofile_payload_uuid"]
            payloadDictionary["PayloadDescription"] = payloadDictionary["spconfigprofile_description"]
            payloadDictionary["PayloadOrganization"] = payloadDictionary["spconfigprofile_organization"]
            payloadDictionary["PayloadVersion"] = payloadDictionary["spconfigprofile_payload_version"]

            guard let string: String = payloadDictionary["spconfigprofile_payload_data"] as? String,
                let jsonString: String = string.toJSONString(),
                let data: Data = jsonString.data(using: .utf8) else {
                continue
            }

            do {
                if let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed, .json5Allowed]) as? [String: Any] {
                    payloadDictionary.merge(dictionary) { current, _ in current }
                }
            } catch {
                print(error.localizedDescription)
            }

            keys.forEach { payloadDictionary.removeValue(forKey: $0) }
            payloadContent.append(payloadDictionary)
        }

        dictionary["PayloadContent"] = payloadContent
        keys.forEach { dictionary.removeValue(forKey: $0) }

        do {
            let data: Data = try PropertyListSerialization.data(fromPropertyList: dictionary, format: .xml, options: .bitWidth)
            return Profile(from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    private func homepage() {

        guard let url: URL = URL(string: .homepage) else {
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
