//
//  ViewController.swift
//  TipCalculator
//
//  Created by Chintan Rita on 9/9/15.
//  Copyright © 2015 Chintan Rita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var horizontalRule: UIView!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    let tipPercentages = [0.18, 0.2, 0.22]
    let colors = [UIColor(red: 0.85, green: 0.92, blue: 0.83, alpha: 1), UIColor(red: 1.0, green: 0.95, blue: 0.80, alpha: 1), UIColor(red: 0.96, green: 0.80, blue: 0.80, alpha: 1.0)]
    
    let defaults = NSUserDefaults.standardUserDefaults()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        tipTextLabel.alpha = 0
        tipLabel.alpha = 0
        totalLabel.alpha = 0
        totalTextLabel.alpha = 0
        horizontalRule.alpha = 0
        updateSettingsTipValue()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()

        // Add observer:
        notificationCenter.addObserver(self,
            selector: Selector("applicationWillTerminateNotification"),
            name:UIApplicationWillTerminateNotification,
            object:nil)
        
        notificationCenter.addObserver(self, selector: "applicationDidBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func applicationWillTerminateNotification() {
        let date = NSDate().timeIntervalSince1970
        defaults.setDouble(date, forKey: "tipcalculator_closingtime")
        defaults.setObject(billField.text, forKey: "tipcalculator_billamount")
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "tipcalculator_tipselectedindex")
        defaults.synchronize()
    }
    
    func applicationDidBecomeActive() {
        let lastClosingTime = defaults.doubleForKey("tipcalculator_closingtime")
    
        let currentTime = NSDate().timeIntervalSince1970
        let difference = currentTime - lastClosingTime
        if difference <= 600 {
            let billAmount = defaults.valueForKey("tipcalculator_billamount")
            let tipSelectedIndex = defaults.integerForKey("tipcalculator_tipselectedindex")
            if let b = billAmount as? String {
                billField.text = b
                tipControl.selectedSegmentIndex = tipSelectedIndex
                calculateTotalAmount()
            }

        }
    }
    
    func updateSettingsTipValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("tipcalculator_default_tip_index")
        view.backgroundColor = colors[intValue]
        billField.backgroundColor = colors[intValue]
        tipControl.selectedSegmentIndex = intValue
        calculateTotalAmount()
    }
    
    func calculateTotalAmount() {
        let selectedTipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount: Double = NSString(string: billField.text!).doubleValue
        let tip = billAmount * selectedTipPercentage
        let totalAmount = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", totalAmount)
        let color = colors[tipControl.selectedSegmentIndex]
        if billAmount > 0 {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.tipTextLabel.alpha = 1
                self.tipLabel.alpha = 1
                self.totalTextLabel.alpha = 1
                self.totalLabel.alpha = 1
                self.horizontalRule.alpha = 1
                self.view.backgroundColor = color
                self.billField.backgroundColor = color
            })
        }
        else {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.tipLabel.alpha = 0
                self.tipTextLabel.alpha = 0
                self.totalTextLabel.alpha = 0
                self.totalLabel.alpha = 0
                self.horizontalRule.alpha = 0
                self.view.backgroundColor = color
                self.billField.backgroundColor = color
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        calculateTotalAmount()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateSettingsTipValue()
        billField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

