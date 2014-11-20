//
//  ViewController.swift
//  watchShareData
//
//  Created by zhefu wang on 11/20/14.
//  Copyright (c) 2014 zhefu wang. All rights reserved.
//

import UIKit

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
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        if let dirURL = self.getShareDirURL() {
            UIImagePNGRepresentation(image).writeToURL(dirURL.URLByAppendingPathComponent("image.png"), atomically: true)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getShareDirURL()->NSURL?{
        return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.watchShareData.container")
    }
}

