//
//  SparkleUpdater.swift
//  Low Profile
//
//  Created by Nindi Gill on 25/12/2022.
//

import Foundation
import Sparkle

final class SparkleUpdater: ObservableObject {
    private let updaterController: SPUStandardUpdaterController
    @Published var canCheckForUpdates: Bool = false

    init() {
        updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
        updaterController.updater.publisher(for: \.canCheckForUpdates)
            .assign(to: &$canCheckForUpdates)
    }

    func checkForUpdates() {
        updaterController.checkForUpdates(nil)
    }
}
