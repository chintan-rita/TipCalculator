//
//  ViewController.swift
//  TipCalculator
//
//  Created by Chintan Rita on 9/9/15.
//  Copyright © 2015 Chintan Rita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    let tipPercentages = [0.18, 0.2, 0.22]
    let colors = [UIColor(red: 0.85, green: 0.92, blue: 0.83, alpha: 1), UIColor(red: 1.0, green: 0.95, blue: 0.80, alpha: 1), UIColor(red: 0.96, green: 0.80, blue: 0.80, alpha: 1.0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"

        updateSettingsTipValue()
    }
    
    func updateSettingsTipValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey("defaultTipIndex")
        view.backgroundColor = colors[intValue]
        billField.backgroundColor = colors[intValue]
        tipControl.selectedSegmentIndex = intValue
        calculateTotalAmount()
    }
    
    func calculateTotalAmount() {
        let selectedTipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        view.backgroundColor = colors[tipControl.selectedSegmentIndex]
        billField.backgroundColor = colors[tipControl.selectedSegmentIndex]
        
        let billAmount: Double = NSString(string: billField.text!).doubleValue
        let tip = billAmount * selectedTipPercentage
        let totalAmount = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", totalAmount)
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
}

