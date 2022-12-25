//
//  SettingsGeneralView.swift
//  Low Profile
//
//  Created by Nindi Gill on 25/12/2022.
//

import SwiftUI

struct SettingsGeneralView: View {
    @AppStorage("SUEnableAutomaticChecks") private var enableAutomaticChecks: Bool = true
    @AppStorage("SUScheduledCheckInterval") private var scheduledCheckInterval: Int = 86_400
    @ObservedObject var sparkleUpdater: SparkleUpdater
    private let width: CGFloat = 150

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Toggle(isOn: $enableAutomaticChecks) {
                    Text("Automatically check for app updates:")
                }
                Picker("Scheduled Check Interval", selection: $scheduledCheckInterval) {
                    Text("Once a day")
                        .tag(86_400)
                    Text("Once a week")
                        .tag(86_400 * 7)
                    Text("Once a fortnight")
                        .tag(86_400 * 14)
                    Text("Once a month")
                        .tag(86_400 * 30)
                }
                .labelsHidden()
                .disabled(!enableAutomaticChecks)
                .frame(width: width)
                Spacer()
                Button("Check now...") {
                    checkForUpdates()
                }
            }
            Text("You will be notified and given the option to proceed when an update is available.")
                .foregroundColor(.secondary)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
    }

    private func checkForUpdates() {
        sparkleUpdater.checkForUpdates()
    }
}

struct SettingsGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGeneralView(sparkleUpdater: SparkleUpdater())
    }
}
