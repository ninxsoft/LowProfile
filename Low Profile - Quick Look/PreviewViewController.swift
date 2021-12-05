//
//  PreviewViewController.swift
//  Low Profile - Quick Look
//
//  Created by Nindi Gill on 11/8/20.
//

import Cocoa
import Quartz
import SwiftUI

class PreviewViewController: NSViewController, QLPreviewingController {

    override var nibName: NSNib.Name? {
        NSNib.Name("PreviewViewController")
    }

    override func loadView() {
        super.loadView()
    }

    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {

        do {
            let data: Data = try Data(contentsOf: url)

            guard let profile: Profile = Profile(from: data) else {
                handler(nil)
                return
            }

            let contentView: ContentView = ContentView(profile: profile)
            let subView: NSHostingView<ContentView> = NSHostingView(rootView: contentView)
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(subView)
            let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .left, .right]
            NSLayoutConstraint.activate(
                attributes.map {
                    NSLayoutConstraint(item: subView, attribute: $0, relatedBy: .equal, toItem: view, attribute: $0, multiplier: 1, constant: 0)
                }
            )
        } catch {
            print(error.localizedDescription)
        }

        handler(nil)
    }
}
