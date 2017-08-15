//
//  ShareViewController.swift
//  Photos
//
//  Created by Marcin Jackowski on 15/08/2017.
//  Copyright © 2017 Marcin Jackowski. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        openApp()
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
    }
}
