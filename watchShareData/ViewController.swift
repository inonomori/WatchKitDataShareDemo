//
//  ViewController.swift
//  watchShareData
//
//  Created by zhefu wang on 11/20/14.
//  Copyright (c) 2014 zhefu wang. All rights reserved.
//

import UIKit

let groupIdentifier = "group.watchShareData.container"

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var textField: UITextField!
    lazy var imagePicker: UIImagePickerController = UIImagePickerController()

    @IBAction func writebuttonTouched(sender: AnyObject) {
        if let userdefault = NSUserDefaults(suiteName: "group.watchShareData.container") {
            userdefault.setInteger(self.textField.text.toInt()!, forKey: "shareInt")
        }
    }
    
    @IBAction func readButtonTouched(sender: AnyObject) {
        if let userdefault = NSUserDefaults(suiteName: "group.watchShareData.container") {
            let numberInt = userdefault.integerForKey("shareInt")
            self.textField.text = "\(numberInt)"
        }
    }
    
    @IBAction func shareImageButtonTouched(sender: AnyObject) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.sourceType = .PhotoLibrary
        self.imagePicker.delegate = self
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let mediaURL = info[(UIImagePickerControllerReferenceURL as NSObject)] as NSURL
        let originImage = info[(UIImagePickerControllerOriginalImage as NSObject)] as UIImage
        
        let mediaURLComponent = NSURLComponents(URL: mediaURL, resolvingAgainstBaseURL: false)
        
        let queryItemID = mediaURLComponent?.queryItems?[0] as NSURLQueryItem
        if let idString = queryItemID.value {
            if let dirURL = self.getShareDirURL() {
                let queryItemExt = mediaURLComponent?.queryItems?[1] as NSURLQueryItem
                if let ext = queryItemExt.value {
                    let fileName = "\(idString).\(ext.lowercaseString)"
                    UIImagePNGRepresentation(originImage).writeToURL(dirURL.URLByAppendingPathComponent(fileName), atomically: true)
                    if let userdefault = NSUserDefaults(suiteName: groupIdentifier) {
                        userdefault.setObject(fileName, forKey: "idString")
                        userdefault.synchronize()
                    }
                }
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getShareDirURL()->NSURL?{
        return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(groupIdentifier)
    }
}

