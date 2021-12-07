//
//  PreviewProvider.swift
//  Low Profile Quick Look
//
//  Created by Nindi Gill on 8/12/21.
//

import Cocoa
import Quartz

class PreviewProvider: QLPreviewProvider, QLPreviewingController {

    func providePreview(for request: QLFilePreviewRequest) async throws -> QLPreviewReply {

        let reply: QLPreviewReply = QLPreviewReply(dataOfContentType: .mobileconfig, contentSize: CGSize(width: 1_080, height: 720)) { preview in
            let data: Data = Data("Hello world".utf8)
            preview.title = request.fileURL.deletingPathExtension().lastPathComponent
            return data
        }

        return reply
    }
}
