//
//  showImageInterfaceController.swift
//  watchShareData
//
//  Created by zhefu wang on 11/20/14.
//  Copyright (c) 2014 zhefu wang. All rights reserved.
//

import UIKit
import WatchKit

class showImageInterfaceController: WKInterfaceController {
   
    @IBOutlet weak var imageInterface: WKInterfaceImage!
    
    override func willActivate() {
        super.willActivate()
        
        let filename = NSUserDefaults(suiteName: groupIdentifier)?.objectForKey("idString") as String

        if let dirURL = self.getShareDirURL() {
            if let imageData = NSData(contentsOfURL:dirURL.URLByAppendingPathComponent(filename)) {
                if let image = UIImage(data: imageData) {
                    WKInterfaceDevice.currentDevice().addCachedImage(image,name:filename)
                }
            }
        }
        self.imageInterface.setImageNamed(filename)
    }
    
    func getShareDirURL() -> NSURL? {
        return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(groupIdentifier)
    }
}
