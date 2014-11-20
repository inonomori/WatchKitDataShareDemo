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
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if let dirURL = self.getShareDirURL() {
            if let imageData = NSData(contentsOfURL:dirURL.URLByAppendingPathComponent("image.png")) {
                self.imageInterface.setImage(UIImage(data: imageData))
            }
        }
    }
    
    func getShareDirURL() -> NSURL? {
        return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.watchShareData.container")
    }
}
