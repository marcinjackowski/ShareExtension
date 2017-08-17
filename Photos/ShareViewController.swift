//
//  ShareViewController.swift
//  Photos
//
//  Created by Marcin Jackowski on 15/08/2017.
//  Copyright © 2017 Marcin Jackowski. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

final class ShareViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 1
        fetchPhotosUrls { photosUrls in
            // 2
            guard !photosUrls.isEmpty else { return self.endShareFlow() }
            // 3
            self.openApp()
        }
    }
    
    // 1
    private func fetchPhotosUrls(completion: @escaping (_ photoUrls: [URL]) -> ()) {
        var photoUrls = [URL]()
        let typeIdentifier = kUTTypeImage as String
        let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem
        let attachmentsCount = extensionItem?.attachments?.count ?? 0
        
        // 2
        extensionItem?.attachments?.enumerated().forEach { index, item in
            guard let attachment = item as? NSItemProvider else { return endShareFlow() }
            // 3
            if attachment.hasItemConformingToTypeIdentifier(typeIdentifier) {
                // 4
                attachment.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil) { data, error in
                    guard let url = data as? URL else { return self.endShareFlow() }
                    photoUrls.append(url)
                    // 5
                    if index == attachmentsCount - 1 {
                        let photosData = photoUrls.flatMap { try? Data(contentsOf: $0) }
                        // 6
                        UserDefaults(suiteName: "group.pl.marcinjackowski.ShareExtension")?.set(photosData, forKey: "sharePhotosKey")
                        completion(photoUrls)
                    }
                }
            }
        }
    }
    
    private func openApp() {
        // 1
        guard let url = NSURL(string: "shareextension://") else { return }
        
        // 2
        let selector = sel_registerName("openURL:")
        var responder = self as UIResponder?
        
        // 3
        while let tempResponder = responder, !tempResponder.responds(to: selector)  {
            responder = tempResponder.next
        }
        // 4
        _ = responder?.performSelector(inBackground: selector!, with: url)
        // 5
        endShareFlow()
    }
    
    func endShareFlow() {
        extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
    }
}
