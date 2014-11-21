//
//  InterfaceController.swift
//  watchShareData WatchKit Extension
//
//  Created by zhefu wang on 11/20/14.
//  Copyright (c) 2014 zhefu wang. All rights reserved.
//

import WatchKit
import Foundation

let groupIdentifier = "group.watchShareData.container"

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var labelValue: WKInterfaceLabel!
    @IBOutlet weak var slider: WKInterfaceSlider!
    var sliderValue: Float?

    override func willActivate() {
        super.willActivate()
        
        if let userDefault:NSUserDefaults = NSUserDefaults(suiteName: groupIdentifier) {
            let value = userDefault.integerForKey("shareInt")
            self.labelValue.setText("\(value)")
            self.sliderValue = Float(value)
            self.slider.setValue(Float(value))
        }
    }

    @IBAction func readButtonTouched() {
        if let userDefault:NSUserDefaults = NSUserDefaults(suiteName: groupIdentifier) {
            let value = userDefault.integerForKey("shareInt")
            self.labelValue.setText("\(value)")
        }
    }
    
    @IBAction func writeButtonTouched() {
        if let userDefault:NSUserDefaults = NSUserDefaults(suiteName: groupIdentifier) {
            if let sliderValue = self.sliderValue {
                userDefault.setInteger(Int(sliderValue),forKey: "shareInt")
            }
        }
    }
    
    func doSliderAction(value: Float) {
        self.labelValue.setText("\(Int(value))")
        self.sliderValue = value
    }
    
    @IBAction func push1() {
        self.pushControllerWithName("ic1001", context: nil)
    }
    
    @IBAction func push2() {
        self.pushControllerWithName("ic1002", context: nil)
    }
}
